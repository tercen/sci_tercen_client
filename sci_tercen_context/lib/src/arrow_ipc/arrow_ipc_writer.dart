/// Minimal Arrow IPC stream writer for Tercen's client-side column types.
///
/// Emits the standard encapsulated IPC stream format: a schema message, one
/// record batch per page, and an end-of-stream marker. Little-endian buffers,
/// no dictionaries, no compression, `null_count = 0` (zero-length validity
/// buffers) — exactly the subset the engine's importer reads. `LargeUtf8`
/// exists on the engine side but the client's [StrValues] maps to `Utf8`.
///
/// This is the "bounded scope" writer from the streamed-save design (§2.3):
/// every client language but Dart already ships a writer; this one exists so
/// Dart operators can stream results page by page instead of materialising
/// the whole table as TSON.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:sci_tercen_client/sci_client.dart';
import 'package:tson/string_list.dart' show CStringList;

import 'flatbuffer.dart';

// Arrow format constants (format/Schema.fbs, format/Message.fbs).
const int _metadataVersionV5 = 4; // MetadataVersion.V5
const int _headerSchema = 1; // MessageHeader.Schema
const int _headerRecordBatch = 3; // MessageHeader.RecordBatch
const int _typeInt = 2; // Type.Int
const int _typeFloatingPoint = 3; // Type.FloatingPoint
const int _typeUtf8 = 5; // Type.Utf8
const int _precisionDouble = 2; // FloatingPoint.Precision.DOUBLE
const int _continuation = 0xFFFFFFFF;
const int kDefaultMaxPageBytes = 16 * 1024 * 1024;

enum _Kind { int32, float64, utf8 }

_Kind _kindOf(String type) {
  switch (type) {
    case 'int32':
      return _Kind.int32;
    case 'double':
      return _Kind.float64;
    case 'string':
      return _Kind.utf8;
    default:
      throw ArgumentError.value(type, 'type',
          'unsupported column type for Arrow IPC (expected int32, double or string)');
  }
}

/// One column of a page, pre-converted to the writer's buffer forms.
class _ColData {
  final String name;
  final _Kind kind;
  final int rows;
  final Int32List? i32;
  final Float64List? f64;
  final Int32List? strOffsets; // rows + 1 entries
  final Uint8List? strData;

  _ColData(this.name, this.kind, this.rows,
      {this.i32, this.f64, this.strOffsets, this.strData});

  /// Body bytes this column contributes to a batch spanning rows
  /// `[from, to)`: validity buffers are empty (null_count = 0).
  int byteCost(int from, int to) {
    final n = to - from;
    switch (kind) {
      case _Kind.int32:
        return 4 * n;
      case _Kind.float64:
        return 8 * n;
      case _Kind.utf8:
        var data = 0;
        for (var i = from; i < to; i++) {
          data += strOffsets![i + 1] - strOffsets![i];
        }
        return 4 * (n + 1) + data;
    }
  }
}

_ColData _colDataOf(Column col) {
  final kind = _kindOf(col.type);
  final values = col.values;
  switch (kind) {
    case _Kind.int32:
      final v = values as Int32List;
      return _ColData(col.name, kind, v.length, i32: v);
    case _Kind.float64:
      final v = values as Float64List;
      return _ColData(col.name, kind, v.length, f64: v);
    case _Kind.utf8:
      final list = values as CStringList;
      final offsets = Int32List(list.length + 1);
      final data = BytesBuilder(copy: false);
      var pos = 0;
      for (var i = 0; i < list.length; i++) {
        final b = utf8.encode(list[i]);
        data.add(b);
        pos += b.length;
        offsets[i + 1] = pos;
      }
      return _ColData(col.name, kind, list.length,
          strOffsets: offsets, strData: data.toBytes());
  }
}

List<_ColData> _colsOf(Table table) =>
    table.columns.map(_colDataOf).toList(growable: false);

// ============================================================
// Message framing
// ============================================================

void _appendU32(BytesBuilder out, int v) {
  final b = Uint8List(4)..buffer.asByteData().setUint32(0, v, Endian.little);
  out.add(b);
}

/// Appends one encapsulated message: `continuation | metaLen | padded
/// flatbuffer | body`. The flatbuffer is padded (trailing zeros only — the
/// root offset is its first byte) so the body — and the next message's
/// 8-byte prefix — starts 8-byte aligned.
void _appendMessage(
    BytesBuilder out, FbBuilder fbb, int rootD, List<int> body) {
  final meta = fbb.takeBytes(rootD);
  final pad = (-meta.length) % 8;
  _appendU32(out, _continuation);
  _appendU32(out, meta.length + pad);
  out.add(meta);
  if (pad > 0) out.add(Uint8List(pad));
  if (body.isNotEmpty) out.add(body);
}

/// Schema message: `Message{version: V5, header: Schema{endianness: Little,
/// fields}}`, empty body. Field layout per format/Schema.fbs: `name` (0),
/// `nullable` (1), `type_type` (2), `type` (3).
void _writeSchemaMessage(BytesBuilder out, List<_ColData> cols) {
  final fbb = FbBuilder();

  final fieldDs = <int>[];
  for (final c in cols) {
    // Type table first: the Field references it.
    fbb.startTable();
    switch (c.kind) {
      case _Kind.int32:
        fbb.addInt32(0, 32); // Int.bitWidth
        fbb.addBool(1, true); // Int.is_signed
        break;
      case _Kind.float64:
        fbb.addInt16(0, _precisionDouble); // FloatingPoint.precision
        break;
      case _Kind.utf8:
        break; // Utf8: empty table
    }
    final typeD = fbb.endTable();

    final typeCode = switch (c.kind) {
      _Kind.int32 => _typeInt,
      _Kind.float64 => _typeFloatingPoint,
      _Kind.utf8 => _typeUtf8,
    };

    final nameD = fbb.writeString(c.name);
    fbb.startTable();
    fbb.addOffset(0, nameD); // Field.name
    fbb.addBool(1, false); // Field.nullable (null_count is always 0)
    fbb.addUint8(2, typeCode); // Field.type_type (union discriminator)
    fbb.addOffset(3, typeD); // Field.type
    fieldDs.add(fbb.endTable());
  }

  final fieldsVecD = fbb.writeOffsetVector(fieldDs);
  fbb.startTable();
  fbb.addInt16(0, 0); // Schema.endianness = Little
  fbb.addOffset(1, fieldsVecD); // Schema.fields
  final schemaD = fbb.endTable();

  fbb.startTable();
  fbb.addInt16(0, _metadataVersionV5); // Message.version
  fbb.addUint8(1, _headerSchema); // Message.header_type
  fbb.addOffset(2, schemaD); // Message.header
  fbb.addInt64(3, 0); // Message.bodyLength
  _appendMessage(out, fbb, fbb.endTable(), const []);
}

/// Record-batch message + body for rows `[from, to)` of [cols].
///
/// Body layout: per column in field order — empty validity buffer, then the
/// value buffer(s), each 8-byte aligned (padding included in the recorded
/// length, as the reference writers do). Struct vectors per
/// format/RecordBatch.fbs: `FieldNode{length, null_count}`,
/// `Buffer{offset, length}`.
void _writeRecordBatch(
    BytesBuilder out, List<_ColData> cols, int from, int to) {
  final rows = to - from;
  final body = BytesBuilder(copy: false);
  final nodes = <(int, int)>[];
  final buffers = <(int, int)>[];

  // Buffers are laid out at 8-aligned body offsets; alignment padding is
  // appended before each buffer's bytes and excluded from its length.
  var offset = 0;
  void addBuffer(List<int> bytes) {
    final pad = (-offset) % 8;
    if (pad > 0) body.add(Uint8List(pad));
    buffers.add((offset + pad, bytes.length));
    body.add(bytes);
    offset += pad + bytes.length;
  }

  for (final c in cols) {
    nodes.add((rows, 0)); // FieldNode{length, null_count = 0}
    addBuffer(const []); // validity (empty, null_count = 0)
    switch (c.kind) {
      case _Kind.int32:
        final v = c.i32!;
        addBuffer(Uint8List.sublistView(
            v.buffer.asUint8List(v.offsetInBytes, 4 * v.length),
            4 * from,
            4 * to));
        break;
      case _Kind.float64:
        final v = c.f64!;
        addBuffer(Uint8List.sublistView(
            v.buffer.asUint8List(v.offsetInBytes, 8 * v.length),
            8 * from,
            8 * to));
        break;
      case _Kind.utf8:
        // Offsets buffer: to - from + 1 entries, re-based at 0.
        final off = Int32List(rows + 1);
        final base = c.strOffsets![from];
        for (var i = 0; i <= rows; i++) {
          off[i] = c.strOffsets![from + i] - base;
        }
        addBuffer(Uint8List.sublistView(
            off.buffer.asUint8List(off.offsetInBytes, 4 * off.length)));
        // Data buffer: the [from, to) byte slice.
        addBuffer(
            Uint8List.sublistView(c.strData!, base, c.strOffsets![to]));
        break;
    }
  }

  // Body tail: pad to 8 so the NEXT message starts on an 8-byte boundary
  // (Arrow IPC framing); bodyLength counts the padded body.
  final tail = (-body.length) % 8;
  if (tail > 0) body.add(Uint8List(tail));

  final fbb = FbBuilder();
  final nodesVecD = fbb.writeLongPairVector(nodes);
  final buffersVecD = fbb.writeLongPairVector(buffers);
  fbb.startTable();
  fbb.addInt64(0, rows); // RecordBatch.length
  fbb.addOffset(1, nodesVecD); // RecordBatch.nodes
  fbb.addOffset(2, buffersVecD); // RecordBatch.buffers
  final batchD = fbb.endTable();

  fbb.startTable();
  fbb.addInt16(0, _metadataVersionV5);
  fbb.addUint8(1, _headerRecordBatch);
  fbb.addOffset(2, batchD);
  fbb.addInt64(3, body.length); // Message.bodyLength
  _appendMessage(out, fbb, fbb.endTable(), body.toBytes());
}

/// End-of-stream marker: `continuation | 0`.
void writeIpcEndOfStream(BytesBuilder out) {
  _appendU32(out, _continuation);
  _appendU32(out, 0);
}

// ============================================================
// Page encoding
// ============================================================

/// Splits `[0, rows)` into row ranges whose estimated batch body stays
/// within [maxPageBytes] bytes. A range is at least one row (a row is never
/// split); a single row whose cost exceeds the bound is emitted alone.
List<(int, int)> _rowRanges(List<_ColData> cols, int rows, int maxPageBytes) {
  if (rows == 0) return const [];
  final ranges = <(int, int)>[];
  var start = 0;
  var cost = 0;
  for (var row = 0; row < rows; row++) {
    var rowCost = 0;
    for (final c in cols) {
      rowCost += c.byteCost(row, row + 1);
    }
    if (row > start && cost + rowCost > maxPageBytes) {
      ranges.add((start, row));
      start = row;
      cost = 0;
    }
    cost += rowCost;
  }
  ranges.add((start, rows));
  return ranges;
}

/// Incremental Arrow IPC stream builder: feed pages, then [finish].
///
/// The schema message is written from the first page; every page is
/// re-chunked so no record batch's body exceeds [maxPageBytes] bytes.
class ArrowIpcStreamBuilder {
  final int maxPageBytes;
  final BytesBuilder _out = BytesBuilder(copy: false);
  List<_ColData>? _cols;
  bool _finished = false;

  ArrowIpcStreamBuilder({this.maxPageBytes = kDefaultMaxPageBytes});

  /// Adds one page. All pages must share the schema (names, types, order).
  void addPage(Table page) {
    if (_finished) {
      throw StateError('stream already finished');
    }
    final cols = _colsOf(page);
    if (_cols == null) {
      _cols = cols;
      _writeSchemaMessage(_out, cols);
    } else {
      _checkSameSchema(_cols!, cols);
    }
    final rows = page.nRows > 0 ? page.nRows : _rowsOf(cols);
    for (final (from, to) in _rowRanges(cols, rows, maxPageBytes)) {
      _writeRecordBatch(_out, cols, from, to);
    }
  }

  /// Writes the end-of-stream marker and returns the whole stream.
  List<int> finish() {
    if (!_finished) {
      if (_cols == null) {
        // A stream with no pages still carries its (empty) schema.
        _writeSchemaMessage(_out, const []);
      }
      writeIpcEndOfStream(_out);
      _finished = true;
    }
    return _out.toBytes();
  }

  static int _rowsOf(List<_ColData> cols) {
    if (cols.isEmpty) return 0;
    final n = cols.first.rows;
    for (final c in cols.skip(1)) {
      if (c.rows != n) {
        throw ArgumentError('column row counts differ: ${cols.first.name}=$n, '
            '${c.name}=${c.rows}');
      }
    }
    return n;
  }

  static void _checkSameSchema(List<_ColData> expected, List<_ColData> got) {
    if (expected.length != got.length) {
      throw ArgumentError(
          'page column count changed: ${expected.length} -> ${got.length}');
    }
    for (var i = 0; i < expected.length; i++) {
      if (expected[i].name != got[i].name || expected[i].kind != got[i].kind) {
        throw ArgumentError(
            'page column $i changed: ${expected[i].name}/${expected[i].kind}'
            ' -> ${got[i].name}/${got[i].kind}');
      }
    }
  }
}

/// Encodes a stream of [Table] pages into a complete Arrow IPC stream.
///
/// The schema message is written from the first page; every page is
/// re-chunked so no record batch's body exceeds [maxPageBytes]. The result
/// ends with the end-of-stream marker.
Future<List<int>> encodeTablePagesToIpc(Stream<Table> pages,
    {int maxPageBytes = kDefaultMaxPageBytes}) async {
  final builder = ArrowIpcStreamBuilder(maxPageBytes: maxPageBytes);
  await for (final page in pages) {
    builder.addPage(page);
  }
  return builder.finish();
}
