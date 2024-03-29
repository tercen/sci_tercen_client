import 'dart:async';
import 'dart:convert';
import 'package:tson/tson.dart' as TSON;
// import 'package:sci_util/list.dart' as scilist;
import 'package:typed_data/typed_data.dart' as scilist;

import 'package:logging/logging.dart';

abstract class ContentCodec {
  String get name;

  factory ContentCodec.json() => JsonContentCodec();
  factory ContentCodec.tson() => TsonContentCodec();
  factory ContentCodec.contentType(String contentType,
      [ContentCodec? defaultCodec]) {
    switch (contentType) {
      case 'application/json':
        return ContentCodec.json();
      case 'application/tson':
        return ContentCodec.tson();
      default:
        return defaultCodec!;
    }
  }

  Map<String, String> get contentTypeHeader => {'content-type': contentType};
  String get contentType;

  dynamic decode(dynamic input);
  dynamic encode(dynamic value);

  Stream<List<int>> encodeStream(dynamic value);
  dynamic decodeStream(Stream<List<int>> stream, [Encoding? encoding]);

  String get responseType;
}

class TsonContentCodec implements ContentCodec {
  static Logger logger = Logger('TsonContentCodec');
  @override
  String get name => 'tson';

  @override
  String get contentType => 'application/tson';

  @override
  Map<String, String> get contentTypeHeader => {'content-type': contentType};

  @override
  dynamic decode(dynamic source) => TSON.decode(source);

  @override
  dynamic encode(dynamic value) {
    try {
      return TSON.encode(value);
    } catch (e, st) {
      logger.severe('TSON encoding failed : $e for value $value', st);
      throw 'TSON encoding failed : $e';
    }
  }

  @override
  Stream<List<int>> encodeStream(dynamic value) =>
      Stream.fromIterable([TSON.encode(value)]);

  @override
  String get responseType => 'arraybuffer';

  @override
  Future<dynamic> decodeStream(Stream<List<int>> stream,
      [Encoding? encoding]) async {
    var buffer = scilist.Uint8Buffer();
    await for (var bytes in stream) {
      buffer.addAll(bytes);
    }
    return TSON
        .decode(buffer.buffer.asUint8List(buffer.offsetInBytes, buffer.length));
    // scilist.Uint8Buffer bytes = await stream.fold(
    //     scilist.newUint8Buffer(1024),
    //     (buf, list) =>
    //         buf..setRange(buf.length, buf.length + list.length, list));

    // return TSON.decode(bytes.view);
  }
}

class JsonContentCodec implements ContentCodec {
  static Logger logger = Logger('JsonContentCodec');
  @override
  String get name => 'json';

  @override
  String get contentType => 'application/json';
  @override
  Map<String, String> get contentTypeHeader => {'content-type': contentType};

  @override
  dynamic decode(dynamic source) => json.decode(source);

  @override
  dynamic encode(dynamic value) {
    try {
      return json.encode(value);
    } catch (e, st) {
      logger.severe('TSON encoding failed : $e for value $value', st);
      throw 'TSON encoding failed : $e';
    }
  }

  @override
  Stream<List<int>> encodeStream(dynamic value) =>
      Stream.fromIterable([utf8.encode(json.encode(value))]);

  @override
  String get responseType => 'text';

  @override
  Future<dynamic> decodeStream(Stream<List<int>> stream,
      [Encoding? encoding]) async {
    var buffer = scilist.Uint8Buffer();
    await for (var bytes in stream) {
      buffer.addAll(bytes);
    }
    return TSON
        .decode(buffer.buffer.asUint8List(buffer.offsetInBytes, buffer.length));

    // scilist.Uint8List bytes = await stream.fold(
    //     scilist.newUint8Buffer(1024),
    //     (buf, list) =>
    //         buf..setRange(buf.length, buf.length + list.length, list));
    //
    // return json.decode(utf8.decode(bytes));
  }
}
