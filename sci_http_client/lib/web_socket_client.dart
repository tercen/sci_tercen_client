import 'dart:async';
export './error.dart';

abstract class WebSocketClient {
  static WebSocketClient? _CURRENT;

  static WebSocketClient? getCurrent() {
    if (_CURRENT == null) throw 'WebSocketClient current is null';
    return _CURRENT;
  }

  static setCurrent(WebSocketClient client) {
    _CURRENT = client;
  }

  Stream<Map?> send(String endPoint, Map data);

  Stream<Map?> sendStream(String endPoint, Stream<Map> stream);

  Future close();
}
