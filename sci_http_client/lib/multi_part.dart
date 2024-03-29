import 'dart:typed_data';
import 'dart:math';
import 'dart:async';
import 'dart:convert';

class MultiPart {
  final Map<String, String> headers;
  final String? string;
  final Stream<List<int>>? stream;
  MultiPart(this.headers, {this.string, this.stream});

  Object? get object {
    if (string != null) return string;
    return stream;
  }
}

class MultiPartMixTransformer {
  final String frontier;
  MultiPartMixTransformer(this.frontier);
  Stream<List<int>> transform(Stream<MultiPart> stream) async* {
    var frontier = utf8.encode(this.frontier);
    await for (var m in stream) {
      var builder = <int>[];
      builder.addAll(utf8.encode('--'));
      builder.addAll(frontier);
      builder
        ..add(13)
        ..add(10);

      m.headers.forEach((k, v) {
        builder
          ..addAll(utf8.encode(k))
          ..addAll(utf8.encode(': '))
          ..addAll(utf8.encode(v))
          ..add(13)
          ..add(10);
      });
      builder
        ..add(13)
        ..add(10);

      yield builder;

      var o = m.object;

      if (o is String) {
        yield utf8.encode(o);
      } else if (o is Stream<List<int>>) {
        yield* o;
      } else {
        throw 'bad type';
      }

      yield [13, 10];
    }
    yield utf8.encode('--');
    yield frontier;
    yield utf8.encode('--');
    yield [13, 10];
  }

  Future<List<int>> encode(List<MultiPart> list) async {
    var stream = transform(Stream.fromIterable(list));
    var builder = BytesBuilder(copy: false);
    (await stream.toList()).forEach(builder.add);
    return builder.toBytes();
  }
}

/// Builds a list of bytes, allowing bytes and lists of bytes to be added at the
/// end.
///
/// Used to efficiently collect bytes and lists of bytes.
abstract class BytesBuilder {
  /// Construct a empty [BytesBuilder].
  ///
  /// If [copy] is true, the data is always copied when added to the list. If
  /// it [copy] is false, the data is only copied if needed. That means that if
  /// the lists are changed after added to the [BytesBuilder], it may effect the
  /// output. Default is `true`.
  factory BytesBuilder({bool copy = true}) {
    if (copy) {
      return _CopyingBytesBuilder();
    } else {
      return _BytesBuilder();
    }
  }

  /// Appends [bytes] to the current contents of the builder.
  ///
  /// Each value of [bytes] will be bit-representation truncated to the range
  /// 0 .. 255.
  void add(List<int> bytes);

  /// Append [byte] to the current contents of the builder.
  ///
  /// The [byte] will be bit-representation truncated to the range 0 .. 255.
  void addByte(int byte);

  /// Returns the contents of `this` and clears `this`.
  ///
  /// The list returned is a view of the internal buffer, limited to the
  /// [length].
  List<int> takeBytes();

  /// Returns a copy of the current contents of the builder.
  ///
  /// Leaves the contents of the builder intact.
  List<int> toBytes();

  /// The number of bytes in the builder.
  int get length;

  /// Returns `true` if the buffer is empty.
  bool get isEmpty;

  /// Returns `true` if the buffer is not empty.
  bool get isNotEmpty;

  /// Clear the contents of the builder.
  void clear();
}

class _CopyingBytesBuilder implements BytesBuilder {
  // Start with 1024 bytes.
  static const int _INIT_SIZE = 1024;

  int _length = 0;
  Uint8List? _buffer;

  @override
  void add(List<int> bytes) {
    int bytesLength = bytes.length;
    if (bytesLength == 0) return;
    int required = _length + bytesLength;
    if (_buffer == null) {
      int size = _pow2roundup(required);
      size = max(size, _INIT_SIZE);
      _buffer = Uint8List(size);
    } else if (_buffer!.length < required) {
      // We will create a list in the range of 2-4 times larger than
      // required.
      int size = _pow2roundup(required) * 2;
      var newBuffer = Uint8List(size);
      newBuffer.setRange(0, _buffer!.length, _buffer!);
      _buffer = newBuffer;
    }
    assert(_buffer!.length >= required);
    if (bytes is Uint8List) {
      _buffer!.setRange(_length, required, bytes);
    } else {
      for (int i = 0; i < bytesLength; i++) {
        _buffer![_length + i] = bytes[i];
      }
    }
    _length = required;
  }

  @override
  void addByte(int byte) {
    add([byte]);
  }

  @override
  List<int> takeBytes() {
    if (_buffer == null) return Uint8List(0);
    var buffer = Uint8List.view(_buffer!.buffer, 0, _length);
    clear();
    return buffer;
  }

  @override
  List<int> toBytes() {
    if (_buffer == null) return Uint8List(0);
    return Uint8List.fromList(Uint8List.view(_buffer!.buffer, 0, _length));
  }

  @override
  int get length => _length;

  @override
  bool get isEmpty => _length == 0;

  @override
  bool get isNotEmpty => _length != 0;

  @override
  void clear() {
    _length = 0;
    _buffer = null;
  }

  int _pow2roundup(int x) {
    --x;
    x |= x >> 1;
    x |= x >> 2;
    x |= x >> 4;
    x |= x >> 8;
    x |= x >> 16;
    return x + 1;
  }
}

class _BytesBuilder implements BytesBuilder {
  int _length = 0;
  final List<Uint8List> _chunks = [];

  @override
  void add(List<int> bytes) {
    Uint8List typedBytes;
    if (bytes is Uint8List) {
      typedBytes = bytes;
    } else {
      typedBytes = Uint8List.fromList(bytes);
    }
    _chunks.add(typedBytes);
    _length += typedBytes.length;
  }

  @override
  void addByte(int byte) {
    add([byte]);
  }

  @override
  List<int> takeBytes() {
    if (_chunks.isEmpty) return Uint8List(0);
    if (_chunks.length == 1) {
      var buffer = _chunks.single;
      clear();
      return buffer;
    }
    var buffer = Uint8List(_length);
    int offset = 0;
    for (var chunk in _chunks) {
      buffer.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }
    clear();
    return buffer;
  }

  @override
  List<int> toBytes() {
    if (_chunks.isEmpty) return Uint8List(0);
    var buffer = Uint8List(_length);
    int offset = 0;
    for (var chunk in _chunks) {
      buffer.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }
    return buffer;
  }

  @override
  int get length => _length;

  @override
  bool get isEmpty => _length == 0;

  @override
  bool get isNotEmpty => _length != 0;

  @override
  void clear() {
    _length = 0;
    _chunks.clear();
  }
}
