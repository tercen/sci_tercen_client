import 'dart:async';

import 'package:logging/logging.dart';
import 'package:async/async.dart';
import 'package:uuid/uuid.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:tson/tson.dart' as TSON;

import 'message.dart' as msg;
import 'message.dart';

class ChannelClient {
  static Logger logger = Logger('ChannelClient');

  StreamChannel? _channel;

  Stream<msg.Message>? _stream;

  late StreamGroup<msg.Message> _streamGroup;

  StreamController<msg.Message>? _commandController;

  CancelCallBack? cancelCallBack;

  ChannelClient(StreamChannel<dynamic> this._channel, {this.cancelCallBack}) {
    _streamGroup = StreamGroup();
    _commandController = StreamController();
    _streamGroup.add(_commandController!.stream);
    _stream = _channel!.stream
        .map((each) => msg.Message.fromJson(TSON.decode(each) as Map))
        .asBroadcastStream()
        .cast();

    _channel!.sink
        .addStream(_streamGroup.stream.map((msg) => TSON.encode(msg.toJson())));
  }

  Stream? get stream => _stream;

  Future close() async {
    logger.finest('close');
    if (_channel == null) return;
    _channel!.sink.close();
    _channel = null;
    _stream = null;
    _commandController!.close();
    _commandController = null;
  }

  ChannelClientResponse send(ChannelClientRequest request) {
    var channelId = Uuid().v4().toString();
    var input = msg.InputStreamConsumer(channelId, request.stream, _stream!,
        cancelCallBack: cancelCallBack);
    _commandController!.add(
        msg.Message(channelId, msg.ENDPOINT, {'endPoint': request.endPoint}));

    _streamGroup.add(input.stream);

    return ChannelClientResponse(
        msg.OutputStream(channelId, _stream!, _commandController, input.done)
            .stream);
  }
}

class ChannelClientRequest {
  final String endPoint;
  final Stream<Map> stream;

  ChannelClientRequest(this.endPoint, this.stream);
}

class ChannelClientResponse {
  final Stream<Map?> stream;

  ChannelClientResponse(this.stream);
}
