import 'dart:convert';
import 'dart:typed_data';

import 'package:sci_base/sci_service.dart' as api;
import 'package:sci_tercen_context/sci_tercen_context.dart';
import 'package:test/test.dart';
import 'package:tson/tson.dart' as tson;

import 'mocks/mock_service_factory.dart';

// ============================================================
// Minimal Arrow IPC stream reader — test-side oracle for the writer.
//
// Parses the encapsulated stream (continuation | metaLen | flatbuffer |
// body) enough to recover the schema and every record batch's values.
// Deliberately independent of the writer's builder, so a round-trip here
// validates the emitted bytes rather than the writer's own bookkeeping.
// ============================================================

class _Reader {
  final Uint8List b;
  _Reader(List<int> bytes)
      : b = bytes is Uint8List ? bytes : Uint8List.fromList(bytes);

  int u8(int off) => b[off];
  int u16(int off) {
    if (off % 2 != 0) throw StateError('unaligned u16 read at offset $off');
    return ByteData.sublistView(b, off, off + 2).getUint16(0, Endian.little);
  }

  int u32(int off) {
    if (off % 4 != 0) throw StateError('unaligned u32 read at offset $off');
    return ByteData.sublistView(b, off, off + 4).getUint32(0, Endian.little);
  }

  int i32(int off) {
    if (off % 4 != 0) throw StateError('unaligned i32 read at offset $off');
    return ByteData.sublistView(b, off, off + 4).getInt32(0, Endian.little);
  }

  int i64(int off) {
    if (off % 8 != 0) throw StateError('unaligned i64 read at offset $off');
    return ByteData.sublistView(b, off, off + 8).getInt64(0, Endian.little);
  }

  double f64(int off) {
    if (off % 8 != 0) throw StateError('unaligned f64 read at offset $off');
    return ByteData.sublistView(b, off, off + 8).getFloat64(0, Endian.little);
  }

  // --- FlatBuffers table access ---

  int? _fieldPos(int table, int field) {
    final vt = table - i32(table);
    final vtSize = u16(vt);
    final slot = 4 + 2 * field;
    if (slot >= vtSize) return null;
    final entry = u16(vt + slot);
    return entry == 0 ? null : table + entry;
  }

  int? fieldI16(int table, int field) =>
      _fieldPos(table, field) == null ? null : u16(_fieldPos(table, field)!);

  int? fieldU8(int table, int field) =>
      _fieldPos(table, field) == null ? null : u8(_fieldPos(table, field)!);

  int? fieldI32(int table, int field) =>
      _fieldPos(table, field) == null ? null : i32(_fieldPos(table, field)!);

  int? fieldI64(int table, int field) =>
      _fieldPos(table, field) == null ? null : i64(_fieldPos(table, field)!);

  int? fieldTable(int table, int field) {
    final p = _fieldPos(table, field);
    return p == null ? null : p + u32(p);
  }

  String fieldString(int table, int field) {
    final p = _fieldPos(table, field)!;
    final target = p + u32(p);
    final len = u32(target);
    return utf8.decode(b.sublist(target + 4, target + 4 + len));
  }

  /// Offset vector → the tables it points to.
  List<int> vectorTables(int table, int field) {
    final p = _fieldPos(table, field)!;
    final vec = p + u32(p);
    final n = u32(vec);
    return List.generate(n, (i) {
      final slot = vec + 4 + 4 * i;
      return slot + u32(slot);
    });
  }

  /// Struct vector of `[int64, int64]` pairs.
  List<(int, int)> vectorPairs(int table, int field) {
    final p = _fieldPos(table, field)!;
    final vec = p + u32(p);
    final n = u32(vec);
    return List.generate(
        n, (i) => (i64(vec + 4 + 16 * i), i64(vec + 4 + 16 * i + 8)));
  }

  // --- Encapsulated stream ---

  List<_Message> messages() {
    final out = <_Message>[];
    var pos = 0;
    while (pos < b.length) {
      // Arrow IPC requires every encapsulated message (and the EOS marker)
      // to start on an 8-byte boundary; a drifted phase means some earlier
      // body skipped its tail padding.
      expect(pos % 8, 0, reason: 'message starts 8-aligned (at $pos)');
      expect(u32(pos), 0xFFFFFFFF, reason: 'continuation marker at $pos');
      final metaLen = i32(pos + 4);
      if (metaLen == 0) break; // end-of-stream
      expect(metaLen % 8, 0, reason: 'metadata padded to 8 at $pos');
      final fb = pos + 8;
      final root = u32(fb);
      final msg = fb + root;
      final headerType = fieldU8(msg, 1)!;
      final header = fieldTable(msg, 2)!;
      final bodyLength = fieldI64(msg, 3)!;
      final bodyStart = fb + metaLen;
      out.add(_Message(this, headerType, header,
          Uint8List.sublistView(b, bodyStart, bodyStart + bodyLength)));
      pos = bodyStart + bodyLength;
    }
    return out;
  }
}

class _Message {
  final _Reader r;
  final int headerType;
  final int table;
  final Uint8List body;
  _Message(this.r, this.headerType, this.table, this.body);

  bool get isSchema => headerType == 1;
  bool get isRecordBatch => headerType == 3;
  int get bodyLength => body.length;
  int get batchRows => r.fieldI64(table, 0)!;

  List<({String name, String type})> schemaFields() {
    return r.vectorTables(table, 1).map((f) {
      final name = r.fieldString(f, 0);
      final typeType = r.fieldU8(f, 2)!;
      final type = switch (typeType) {
        2 => 'int${r.fieldI32(r.fieldTable(f, 3)!, 0)}', // Int
        3 => r.fieldI16(r.fieldTable(f, 3)!, 0) == 2
            ? 'double' // FloatingPoint precision DOUBLE
            : 'float32',
        5 => 'string', // Utf8
        _ => 'type?$typeType',
      };
      return (name: name, type: type);
    }).toList();
  }

  /// Decodes the batch's columns against the stream schema. Buffer offsets
  /// are relative to the batch body, so reads go through a body-scoped
  /// reader.
  List<List<dynamic>> columns(List<({String name, String type})> schema) {
    final nodes = r.vectorPairs(table, 1);
    final buffers = r.vectorPairs(table, 2);
    final rb = _Reader(body);
    final out = <List<dynamic>>[];
    var bi = 0; // cursor: validity + values per column (utf8 has two value buffers)
    for (var c = 0; c < schema.length; c++) {
      expect(nodes[c].$2, 0, reason: 'null_count is always 0');
      bi++; // validity buffer (empty, null_count = 0)
      switch (schema[c].type) {
        case 'int32':
          final (off, len) = buffers[bi++];
          out.add(List.generate(len ~/ 4, (i) => rb.i32(off + 4 * i)));
          break;
        case 'double':
          final (off, _) = buffers[bi++];
          out.add(
              List.generate(nodes[c].$1, (i) => rb.f64(off + 8 * i)));
          break;
        case 'string':
          final (oOff, _) = buffers[bi++];
          final (dOff, _) = buffers[bi++];
          final rows = nodes[c].$1;
          out.add(List.generate(rows, (i) {
            final s = rb.i32(oOff + 4 * i);
            final e = rb.i32(oOff + 4 * (i + 1));
            return utf8.decode(Uint8List.sublistView(rb.b, dOff + s, dOff + e));
          }));
          break;
      }
    }
    return out;
  }
}

// ============================================================
// Capturing mocks for the staged-save path
// ============================================================

class CapturingTableSchemaService extends MockTableSchemaService {
  final uploadedFiles = <FileDocument>[];
  final uploadedBytes = <Uint8List>[];
  final updatedSchemas = <Schema>[];
  Schema? nextStaged;

  @override
  Future<Schema> uploadTable(FileDocument file, Stream<List> bytes,
      {api.AclContext? aclContext}) async {
    uploadedFiles.add(file);
    uploadedBytes.add(Uint8List.fromList(
        (await bytes.toList()).expand((c) => c.cast<int>()).toList()));
    return nextStaged ?? (Schema()..id = 'staged-1');
  }

  @override
  Future<String> update(Schema object, {api.AclContext? aclContext}) async {
    updatedSchemas.add(object);
    return 'rev-2';
  }

  final pagedResults = <SelectPage>[];
  final pagedCursors = <String>[];
  final pagedMaxBytes = <int>[];

  @override
  Future<SelectPage> selectRelationPage(
      Relation relation, List<String> cnames, String cursor, int maxBytes,
      {api.AclContext? aclContext}) async {
    pagedCursors.add(cursor);
    pagedMaxBytes.add(maxBytes);
    if (pagedResults.isEmpty) {
      throw StateError('selectPages iterated past the end marker');
    }
    return pagedResults.removeAt(0);
  }
}

class _CapturingFileService extends MockFileService {
  final uploads = <({FileDocument file, List<List<dynamic>> chunks})>[];
  int _counter = 100;

  @override
  Future<FileDocument> upload(FileDocument file, Stream<List> bytes,
      {api.AclContext? aclContext}) async {
    final chunks = List<List<dynamic>>.from(await bytes.toList());
    uploads.add((file: file, chunks: chunks));
    if (file.id.isEmpty) {
      file.id = 'file-${_counter++}';
    }
    return file;
  }
}

class _StagedFactory extends MockServiceFactory {
  final CapturingTableSchemaService _schemaSvc = CapturingTableSchemaService();
  final _CapturingFileService _fileSvc = _CapturingFileService();

  @override
  CapturingTableSchemaService get tableSchemaService => _schemaSvc;
  @override
  _CapturingFileService get fileService => _fileSvc;
}

// ============================================================
// Tests
// ============================================================

Table _page(Map<String, List<dynamic>> cols) {
  final t = Table();
  for (final e in cols.entries) {
    final data = e.value;
    if (data.isEmpty) {
      t.columns.add(AbstractOperatorContext.makeStringColumn(e.key, const []));
      continue;
    }
    t.columns.add(switch (data.first) {
      int() => AbstractOperatorContext.makeInt32Column(e.key, List<int>.from(data)),
      double() =>
        AbstractOperatorContext.makeFloat64Column(e.key, List<double>.from(data)),
      _ => AbstractOperatorContext.makeStringColumn(e.key, List<String>.from(data)),
    });
  }
  if (t.columns.isNotEmpty) t.nRows = t.columns.first.nRows;
  return t;
}

void main() {
  test('round-trips a single page through the stream format', () async {
    final page = _page({
      'i': [1, -2, 3, 7],
      'd': [1.5, -2.5, 3.25, 0.0],
      's': ['x', '', 'hello world', 'é'],
    });

    final bytes = await encodeTablePagesToIpc(Stream.fromIterable([page]));
    final r = _Reader(bytes);
    final msgs = r.messages();

    expect(msgs.first.isSchema, isTrue);
    final fields = msgs.first.schemaFields();
    expect(fields.map((f) => f.name), ['i', 'd', 's']);
    expect(fields.map((f) => f.type), ['int32', 'double', 'string']);

    final batches = msgs.where((m) => m.isRecordBatch).toList();
    expect(batches, hasLength(1));
    expect(batches.single.batchRows, 4);
    final cols = batches.single.columns(fields);
    expect(cols[0], [1, -2, 3, 7]);
    expect(cols[1], [1.5, -2.5, 3.25, 0.0]);
    expect(cols[2], ['x', '', 'hello world', 'é']);

    // End-of-stream marker: continuation | 0.
    expect(bytes.sublist(bytes.length - 8),
        [0xFF, 0xFF, 0xFF, 0xFF, 0, 0, 0, 0]);
  });

  test('re-chunks a page so no batch exceeds maxPageBytes', () async {
    final page = _page({
      'i': List.generate(100, (i) => i),
      's': List.generate(100, (i) => 'row-$i-${'x' * 20}'),
    });

    final bytes = await encodeTablePagesToIpc(Stream.fromIterable([page]),
        maxPageBytes: 512);
    final r = _Reader(bytes);
    final msgs = r.messages();
    final fields = msgs.first.schemaFields();
    final batches = msgs.where((m) => m.isRecordBatch).toList();

    expect(batches, hasLength(greaterThan(1)));
    expect(batches.every((m) => m.bodyLength <= 512), isTrue,
        reason: 'every batch body within the bound');
    // Rows are only split at boundaries (no row halved) and total preserved.
    expect(batches.fold<int>(0, (n, m) => n + m.batchRows), 100);
    final allI = <int>[];
    final allS = <String>[];
    for (final b in batches) {
      final cols = b.columns(fields);
      allI.addAll(cols[0].cast<int>());
      allS.addAll(cols[1].cast<String>());
    }
    expect(allI, List.generate(100, (i) => i));
    expect(allS, List.generate(100, (i) => 'row-$i-${'x' * 20}'));
  });

  test('multi-page stream concatenates batches; empty pages emit none',
      () async {
    final p1 = _page({
      'i': [1, 2],
      's': ['a', 'b'],
    });
    // Empty page: explicit types (an empty column can't be inferred).
    final p2 = Table()
      ..columns.add(AbstractOperatorContext.makeInt32Column('i', const []))
      ..columns.add(AbstractOperatorContext.makeStringColumn('s', const []))
      ..nRows = 0;

    final bytes = await encodeTablePagesToIpc(Stream.fromIterable([p1, p2]));
    final msgs = _Reader(bytes).messages();
    final batches = msgs.where((m) => m.isRecordBatch).toList();
    expect(batches, hasLength(1), reason: 'zero-row page emits no batch');
    expect(batches.single.batchRows, 2);
  });

  test('a page-less stream is a schema message plus end-of-stream', () async {
    final bytes = await encodeTablePagesToIpc(const Stream.empty());
    final msgs = _Reader(bytes).messages();
    expect(msgs, hasLength(1));
    expect(msgs.single.isSchema, isTrue);
    expect(msgs.single.schemaFields(), isEmpty);
  });

  test('saveTableStream stages, marks and references through the services',
      () async {
    final factory = _StagedFactory()
      ..tableSchemaService.nextStaged = makeSchema('staged-1', [], nRows: 0);
    final cqt = CubeQueryTask();
    cqt.id = 'task-1';
    cqt.owner = 'op';
    cqt.projectId = 'proj-1';
    cqt.query = makeCubeQuery();
    factory.taskService.addTask('task-1', cqt);

    final ctx = await OperatorContext.create(
        serviceFactory: factory, taskId: 'task-1');
    final pages = Stream.fromIterable([
      _page({
        'i': [5, 6],
        's': ['p', 'q'],
      })
    ]);

    await ctx.saveTableStream(pages);

    // 1. Stage: hidden, arrow content type, names after the task.
    expect(factory.tableSchemaService.uploadedFiles, hasLength(1));
    final file = factory.tableSchemaService.uploadedFiles.single;
    expect(file.name, 'task-1.staged');
    expect(file.isHidden, isTrue);
    expect(file.projectId, 'proj-1');
    expect(file.acl.owner, 'op');
    expect(file.metadata.contentType, 'application/vnd.apache.arrow.file');

    // The uploaded bytes are a valid Arrow IPC stream carrying the page.
    final stream = _Reader(factory.tableSchemaService.uploadedBytes.single);
    final msgs = stream.messages();
    final fields = msgs.first.schemaFields();
    expect(fields.map((f) => f.name), ['i', 's']);
    final batches = msgs.where((m) => m.isRecordBatch).toList();
    expect(batches.single.batchRows, 2);
    expect(batches.single.columns(fields)[1], ['p', 'q']);

    // 2. Mark: staged_result == this task.
    expect(
        factory.tableSchemaService.updatedSchemas.single
            .getMeta(AbstractOperatorContext.stagedResultMetaKey),
        'task-1');

    // 3. Reference: the TSON result save carries a TableRelation to S.
    final resultUpload = factory.fileService.uploads.single;
    final decoded = tson.decode(resultUpload.chunks.single) as Map;
    final join = (decoded['joinOperators'] as List).single as Map;
    final right = join['rightRelation'] as Map;
    expect(right['id'], 'staged-1');
    expect(right['kind'], TableRelation().kind);
  });

  test('selectPages walks the cursor chain and stops at the empty marker',
      () async {
    final factory = _StagedFactory()
      ..tableSchemaService.pagedResults.addAll([
        SelectPage()
          ..table = _page({
            'i': [1]
          })
          ..nextCursor = 'c2',
        SelectPage()
          ..table = _page({
            'i': [2]
          })
          ..nextCursor = 'c3',
        // No nextCursor set: the TSON key is absent, the field defaults to
        // '' — the client-side realization of the "null ⇔ end" pin.
        SelectPage()
          ..table = _page({
            'i': [3]
          }),
      ]);
    final cqt = CubeQueryTask();
    cqt.id = 'task-1';
    cqt.owner = 'op';
    cqt.projectId = 'proj-1';
    cqt.query = makeCubeQuery();
    factory.taskService.addTask('task-1', cqt);
    final ctx = await OperatorContext.create(
        serviceFactory: factory, taskId: 'task-1');

    final pages = await ctx
        .selectPages(TableRelation()..id = 'staged-1', ['i'],
            maxBytes: 4096)
        .toList();

    expect(pages, hasLength(3));
    expect(pages.map((p) => p.nextCursor), ['c2', 'c3', '']);
    // Cursor minting: first call empty, then each yielded page's nextCursor.
    expect(factory.tableSchemaService.pagedCursors, ['', 'c2', 'c3']);
    // maxBytes passes through on every call.
    expect(factory.tableSchemaService.pagedMaxBytes, [4096, 4096, 4096]);
  });
}
