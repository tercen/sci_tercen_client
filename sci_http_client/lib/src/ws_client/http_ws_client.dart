import 'dart:async';
import 'package:web_socket_channel/html.dart';
import 'package:async/async.dart';

import '../channel/channel_client.dart';
import '../../web_socket_client.dart';

typedef CancelCallBack = void Function();

class HttpWebSocketClient implements WebSocketClient {
  ChannelClient? _client;
  final String uri;
  CancelCallBack? cancelCallBack;

  HttpWebSocketClient(this.uri, {this.cancelCallBack});

  void createClient() {
    if (_client != null) return;
    _client = ChannelClient(
        HtmlWebSocketChannel.connect(uri, binaryType: BinaryType.list),
        cancelCallBack: cancelCallBack);
    _client!.stream!.drain().whenComplete(() {
      _client = null;
    });
  }

  @override
  Stream<Map?> send(String endPoint, Map data) {
    return sendStream(endPoint, Stream.fromIterable([data]));
  }

  @override
  Stream<Map?> sendStream(String endPoint, Stream<Map> stream) {
    if (_client == null) {
      return StreamCompleter.fromFuture(Future(() {
        createClient();
        return basicSendStream(endPoint, stream);
      }));
    } else {
      return basicSendStream(endPoint, stream);
    }
  }

  Stream<Map?> basicSendStream(String endPoint, Stream<Map> stream) =>
      _client!.send(ChannelClientRequest(endPoint, stream)).stream;

  @override
  Future close() => _client!.close();
}
