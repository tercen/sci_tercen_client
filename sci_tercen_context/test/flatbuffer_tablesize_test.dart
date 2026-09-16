import 'dart:math';
import 'dart:typed_data';

import 'package:sci_tercen_context/sci_tercen_context.dart';
import 'package:sci_tercen_context/src/arrow_ipc/flatbuffer.dart';
import 'package:test/test.dart';

// ============================================================
// Vtable `tableSize` conformance.
//
// The FlatBuffers spec defines a table's vtable[1] (tableSize) as the
// object size: the largest field end, measured from the table start —
// max(entry + width) over the table's present fields, 4 for an empty
// table. Accessor-based readers never read tableSize, so a wrong value is
// latent (only strict verifiers like `flatc --verify` would reject) and
// the round-trip suite cannot catch it: this guard reads the vtables
// directly.
//
// Field widths follow format/Schema.fbs, format/Message.fbs and
// format/RecordBatch.fbs as the writer emits them.
// ============================================================

const _widths = <String, Map<int, int>>{
  'Message': {0: 2, 1: 1, 2: 4, 3: 8}, // version, header_type, header, bodyLength
  'Schema': {0: 2, 1: 4}, // endianness, fields
  'Field': {0: 4, 1: 1, 2: 1, 3: 4}, // name, nullable, type_type, type
  'Int': {0: 4, 1: 1}, // bitWidth, is_signed
  'FloatingPoint': {0: 2}, // precision
  'Utf8': {}, // empty table
  'RecordBatch': {0: 8, 1: 4, 2: 4}, // length, nodes, buffers
};

class _Reader {
  final Uint8List b;
  _Reader(List<int> bytes)
      : b = bytes is Uint8List ? bytes : Uint8List.fromList(bytes);

  int u8(int off) => b[off];
  int u16(int off) =>
      ByteData.sublistView(b, off, off + 2).getUint16(0, Endian.little);
  int u32(int off) =>
      ByteData.sublistView(b, off, off + 4).getUint32(0, Endian.little);
  int i32(int off) =>
      ByteData.sublistView(b, off, off + 4).getInt32(0, Endian.little);
  int i64(int off) =>
      ByteData.sublistView(b, off, off + 8).getInt64(0, Endian.little);

  /// The table's vtable: `(tableSize, {field: entry})`, absent fields
  /// (entry 0) omitted.
  (int, Map<int, int>) vtableOf(int table) {
    final vt = table - i32(table);
    final vtSize = u16(vt);
    final entries = <int, int>{};
    for (var f = 0; 4 + 2 * f < vtSize; f++) {
      final e = u16(vt + 4 + 2 * f);
      if (e != 0) entries[f] = e;
    }
    return (u16(vt + 2), entries);
  }

  int? _fieldPos(int table, int field) {
    final vt = table - i32(table);
    final vtSize = u16(vt);
    final slot = 4 + 2 * field;
    if (slot >= vtSize) return null;
    final entry = u16(vt + slot);
    return entry == 0 ? null : table + entry;
  }

  int? fieldU8(int table, int field) =>
      _fieldPos(table, field) == null ? null : u8(_fieldPos(table, field)!);

  int fieldI64(int table, int field) => i64(_fieldPos(table, field)!);

  int? fieldTable(int table, int field) {
    final p = _fieldPos(table, field);
    return p == null ? null : p + u32(p);
  }

  List<int> vectorTables(int table, int field) {
    final p = _fieldPos(table, field)!;
    final vec = p + u32(p);
    final n = u32(vec);
    return List.generate(n, (i) {
      final slot = vec + 4 + 4 * i;
      return slot + u32(slot);
    });
  }

  /// Stored tableSize minus the spec size; >0 or <0 is non-conformant.
  int tableSizeDelta(int table, Map<int, int> widths) {
    final (stored, entries) = vtableOf(table);
    for (final f in entries.keys) {
      if (!widths.containsKey(f)) {
        throw StateError('unexpected field $f (widths cover ${widths.keys})');
      }
    }
    final expected = entries.isEmpty
        ? 4
        : entries.entries
            .map((e) => e.value + widths[e.key]!)
            .reduce((a, b) => a > b ? a : b);
    return stored - expected;
  }
}

Table _page(Map<String, List<dynamic>> cols) {
  final t = Table();
  for (final e in cols.entries) {
    final data = e.value;
    if (data.isEmpty) {
      t.columns.add(AbstractOperatorContext.makeStringColumn(e.key, const []));
      continue;
    }
    t.columns.add(switch (data.first) {
      int() =>
        AbstractOperatorContext.makeInt32Column(e.key, List<int>.from(data)),
      double() => AbstractOperatorContext.makeFloat64Column(
          e.key, List<double>.from(data)),
      _ => AbstractOperatorContext.makeStringColumn(
          e.key, List<String>.from(data)),
    });
  }
  if (t.columns.isNotEmpty) t.nRows = t.columns.first.nRows;
  return t;
}

void main() {
  test(
      'every table in an IPC stream stores the spec tableSize '
      '(max entry + width)', () async {
    final bytes = await encodeTablePagesToIpc(Stream.fromIterable([
      _page({
        'i': [1, 2],
        'd': [1.5, 2.5],
        's': ['a', 'b'],
      })
    ]));
    final r = _Reader(bytes);

    // Walk the stream: two messages, each a Message table wrapping a header
    // table (Schema for the first, RecordBatch for the second); the Schema
    // carries one Field per column, each Field a type table.
    final deltas = <String, List<int>>{};
    void check(String type, int table) {
      (deltas[type] ??= []).add(r.tableSizeDelta(table, _widths[type]!));
    }

    var pos = 0;
    while (true) {
      final metaLen = r.i32(pos + 4);
      if (metaLen == 0) break; // end-of-stream
      final fb = pos + 8;
      final msg = fb + r.u32(fb);
      check('Message', msg);

      final header = r.fieldTable(msg, 2)!;
      if (r.fieldU8(msg, 1) == 1) {
        // Schema message.
        check('Schema', header);
        for (final field in r.vectorTables(header, 1)) {
          check('Field', field);
          final type = r.fieldTable(field, 3)!;
          check(switch (r.fieldU8(field, 2)) {
            2 => 'Int',
            3 => 'FloatingPoint',
            5 => 'Utf8',
            final t => throw StateError('unexpected type_type $t'),
          }, type);
        }
      } else {
        // Record-batch message.
        check('RecordBatch', header);
      }
      pos = fb + metaLen + r.fieldI64(msg, 3);
    }

    final bad = {
      for (final e in deltas.entries)
        if (e.value.any((d) => d != 0)) e.key: e.value,
    };
    expect(bad, isEmpty,
        reason: 'stored tableSize − spec tableSize, per table type '
            '(all deltas: ${deltas.map((k, v) => MapEntry(k, v.toSet()))})');
    // Both message shapes, three schema fields and their type tables were
    // actually exercised.
    expect(deltas['Message'], hasLength(2));
    expect(deltas['Field'], hasLength(3));
    expect(deltas.keys, containsAll(['Int', 'FloatingPoint', 'Utf8']));
  });

  test('direct FbBuilder: empty table stores size 4', () {
    final fbb = FbBuilder()..startTable();
    final bytes = fbb.takeBytes(fbb.endTable());
    final (stored, entries) = _Reader(bytes).vtableOf(_Reader(bytes).u32(0));
    expect(entries, isEmpty);
    expect(stored, 4);
  });

  test('direct FbBuilder: single i64 field stores its full width', () {
    final fbb = FbBuilder()
      ..startTable()
      ..addInt64(0, 1);
    final bytes = fbb.takeBytes(fbb.endTable());
    final (stored, entries) = _Reader(bytes).vtableOf(_Reader(bytes).u32(0));
    expect(stored, entries.values.single + 8);
  });

  test('direct FbBuilder: mixed-width table (u8 then i64)', () {
    final fbb = FbBuilder()
      ..writeString('content below, so alignment is not degenerate')
      ..startTable()
      ..addUint8(0, 7)
      ..addInt64(1, 123);
    final bytes = fbb.takeBytes(fbb.endTable());
    final (stored, entries) = _Reader(bytes).vtableOf(_Reader(bytes).u32(0));
    expect(stored, max(entries[0]! + 1, entries[1]! + 8));
  });
}
