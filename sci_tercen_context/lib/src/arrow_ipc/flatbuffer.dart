import 'dart:convert';

/// Minimal FlatBuffers builder, sufficient for writing Arrow IPC metadata
/// messages (tables with scalar/offset fields, strings, vectors of offsets
/// and vectors of inline structs).
///
/// The buffer grows backward: bytes are pushed onto a list in reverse order,
/// so `length` is always the byte distance from the END of the eventual
/// buffer. Because FlatBuffers offsets are relative, this representation is
/// convenient — aligning `length` to a boundary aligns the written field
/// relative to the buffer end, and every write is self-consistent when the
/// finished bytes are handed to a reader.
///
/// Tables are built bottom-up (children fully built before the parent's
/// [startTable]); nested [startTable] calls are not supported.
class FbBuilder {
  final List<int> _rev = [];

  bool _inTable = false;
  final List<int?> _slots = [];
  int _minFieldEndD = 0;

  // ============================================================
  // Primitive pushes (LE bytes, pushed high-order first so the final
  // buffer reads little-endian)
  // ============================================================

  void _u8(int v) => _rev.add(v & 0xFF);

  void _u16(int v) {
    _rev.add((v >> 8) & 0xFF);
    _rev.add(v & 0xFF);
  }

  void _u32(int v) {
    _rev.add((v >> 24) & 0xFF);
    _rev.add((v >> 16) & 0xFF);
    _rev.add((v >> 8) & 0xFF);
    _rev.add(v & 0xFF);
  }

  void _i64(int v) {
    for (var i = 7; i >= 0; i--) {
      _rev.add((v >> (8 * i)) & 0xFF);
    }
  }

  void _align(int a) {
    while (_rev.length % a != 0) {
      _rev.add(0);
    }
  }

  // ============================================================
  // Tables
  // ============================================================

  /// Starts a table. Must be followed by field adds and [endTable].
  void startTable() {
    assert(!_inTable, 'nested tables are not supported');
    _inTable = true;
    _slots.clear();
    _minFieldEndD = 1 << 60;
  }

  void _record(int field, int startD, int width) {
    while (_slots.length <= field) {
      _slots.add(null);
    }
    _slots[field] = startD;
    // The vtable's tableSize must cover each field's END (its furthest
    // byte from the table start), not just where the fields start — so
    // track the minimum end distance, i.e. the field reaching closest to
    // the buffer end.
    final endD = startD - width;
    if (endD < _minFieldEndD) _minFieldEndD = endD;
  }

  /// Adds a bool field (1 byte, no default elision).
  void addBool(int field, bool v) => addUint8(field, v ? 1 : 0);

  /// Adds a 1-byte unsigned scalar field (union discriminators, ...).
  void addUint8(int field, int v) {
    final d = _rev.length + 1;
    _u8(v);
    _record(field, d, 1);
  }

  /// Adds a 2-byte scalar field (endianness, precision, ...).
  void addInt16(int field, int v) {
    _align(2);
    final d = _rev.length + 2;
    _u16(v);
    _record(field, d, 2);
  }

  /// Adds a 4-byte scalar field (Int.bitWidth, ...).
  void addInt32(int field, int v) {
    _align(4);
    final d = _rev.length + 4;
    _u32(v);
    _record(field, d, 4);
  }

  /// Adds an 8-byte scalar field (bodyLength, RecordBatch.length, ...).
  void addInt64(int field, int v) {
    _align(8);
    final d = _rev.length + 8;
    _i64(v);
    _record(field, d, 8);
  }

  /// Adds an offset field pointing at a previously built object ([targetD]
  /// is the distance-from-end returned when that object was finished).
  void addOffset(int field, int targetD) {
    _align(4);
    final d = _rev.length + 4;
    _u32(d - targetD);
    _record(field, d, 4);
  }

  /// Finishes the table and returns its distance-from-end for referencing.
  int endTable() {
    assert(_inTable, 'endTable without startTable');
    _inTable = false;

    // Table's first field: the signed soffset to its vtable (patched below).
    _align(4);
    final soffsetSlot = _rev.length;
    _u32(0);
    final tableD = _rev.length;

    // Vtable: [vtSize:u16][tableSize:u16][entry0:u16]... Entries are field
    // offsets from the table start; absent fields are 0. Pushed last-entry
    // first so entry0 ends up immediately after the two sizes.
    _align(2);
    final nFields = _slots.length;
    for (var i = nFields - 1; i >= 0; i--) {
      final d = _slots[i];
      _u16(d == null ? 0 : tableD - d);
    }
    // tableSize = the object size: distance from the table start to the
    // lowest field end (4 = the soffset slot alone, for an empty table).
    _u16(_minFieldEndD == (1 << 60) ? 4 : tableD - _minFieldEndD);
    _u16(4 + 2 * nFields); // vtable size
    final vtD = _rev.length;

    // Patch soffset: reader computes vtable position as tableStart - soffset.
    // The pushed group occupies reverse indices [soffsetSlot, soffsetSlot+3];
    // the last-pushed byte (index soffsetSlot+3) is the LSB at the field's
    // own start address.
    final soffset = vtD - tableD;
    _rev[soffsetSlot] = (soffset >> 24) & 0xFF;
    _rev[soffsetSlot + 1] = (soffset >> 16) & 0xFF;
    _rev[soffsetSlot + 2] = (soffset >> 8) & 0xFF;
    _rev[soffsetSlot + 3] = soffset & 0xFF;
    return tableD;
  }

  // ============================================================
  // Objects
  // ============================================================

  /// Writes a string (`[len:u32][data][0x00]`) and returns its position.
  int writeString(String s) {
    final data = utf8.encode(s);
    // Pad up front (above the object, between the NUL terminator and
    // previously built content) so the length field lands 4-aligned
    // relative to the buffer end — from whatever position the builder is
    // sitting at (an odd-field-count endTable leaves it 2 mod 4). Padding
    // below the length, between it and the data, would corrupt the string.
    final pad = (-(_rev.length + data.length + 1 + 4)) % 4;
    for (var i = 0; i < pad; i++) {
      _rev.add(0);
    }
    _rev.add(0); // NUL terminator
    for (var i = data.length - 1; i >= 0; i--) {
      _rev.add(data[i]);
    }
    _u32(data.length);
    return _rev.length;
  }

  /// Writes a vector of offsets to previously built objects and returns the
  /// vector's position.
  int writeOffsetVector(List<int> targets) {
    _align(4); // elements and the count are u32s — align wherever we sit
    for (var i = targets.length - 1; i >= 0; i--) {
      _u32(_rev.length + 4 - targets[i]);
    }
    _u32(targets.length);
    return _rev.length;
  }

  /// Writes a vector of inline 16-byte structs, each a pair of 64-bit LE
  /// integers (`[first][second]`), and returns the vector's position. Used
  /// for Arrow's `FieldNode` and `Buffer` struct vectors — elements are
  /// 16 bytes wide, so with the vector 8-aligned they need no per-element
  /// padding.
  int writeLongPairVector(List<(int, int)> pairs) {
    _align(8); // the count (u32) then 16-byte elements: 8-aligned elements
    for (var i = pairs.length - 1; i >= 0; i--) {
      _i64(pairs[i].$2);
      _i64(pairs[i].$1);
    }
    _u32(pairs.length);
    return _rev.length;
  }

  // ============================================================
  // Finish
  // ============================================================

  /// Terminates the builder with the root offset and returns the bytes.
  ///
  /// Pads so the FINISHED buffer — root offset included — is a multiple of
  /// the maximum alignment (8). The builder aligns fields relative to the
  /// buffer END, while readers place them relative to the buffer START;
  /// the two agree only when the total length is 8-aligned. The pad sits
  /// between the root offset and the content: offsets are end-relative and
  /// unaffected by it. (Padding before the root would hide the root offset
  /// from the reader; padding after the buffer would leave every internal
  /// anchor off by `pad % 8`.)
  List<int> takeBytes(int rootD) {
    while ((_rev.length + 4) % 8 != 0) {
      _rev.add(0);
    }
    _u32(_rev.length + 4 - rootD);
    return _rev.reversed.toList(growable: false);
  }
}
