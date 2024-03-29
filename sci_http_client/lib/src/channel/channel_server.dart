import 'dart:async';
import 'package:logging/logging.dart';
import 'package:async/async.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:tson/tson.dart' as TSON;
import 'message.dart' as msg_lib;
import '../../error.dart';

abstract class RequestHandler {
  request(ChannelServerRequest request);
  void close() {}
}

class ErrorRequestHandler extends RequestHandler {
  final String error;

  ErrorRequestHandler(this.error);

  @override
  request(ChannelServerRequest request) async {
    return ChannelServerResponse(Stream.fromFuture(Future.error(error)));
  }
}

class ServerRequest {
  Stream<Map>? stream;
}

class ServerResponse {
  Stream<Map>? stream;
}

typedef RequestHandlerForEndPointZoned<R> = R? Function(R Function() body);

class ChannelServer {
  static Logger logger = Logger('ChannelServer');
  StreamChannel? _channel;
  late RequestHandlerForEndPointZoned requestHandlerForEndPointZoned;

  Map<String, RequestHandler>? _requestHandlers;

  Stream<msg_lib.Message>? _stream;
  StreamSubscription<msg_lib.Message>? _streamSub;
  StreamGroup<msg_lib.Message>? _streamGroup;

  StreamController<msg_lib.Message>? _commandController;
  Map<String, String> headers;

  ChannelServer(this.headers, StreamChannel<dynamic> this._channel,
      {RequestHandlerForEndPointZoned? requestHandlerForEndPointZoned}) {
    if (requestHandlerForEndPointZoned == null) {
      this.requestHandlerForEndPointZoned = (Function() body) => body();
    } else {
      this.requestHandlerForEndPointZoned = requestHandlerForEndPointZoned;
    }

    _requestHandlers = {};

    _streamGroup = StreamGroup();

    _commandController = StreamController(sync: true);
    _streamGroup!.add(_commandController!.stream);

    _stream = _channel!.stream
        .map((each) => msg_lib.Message.fromJson(TSON.decode(each) as Map))
        .asBroadcastStream();

    _channel!.sink.addStream(
        _streamGroup!.stream.map((each) => TSON.encode(each.toJson())));

    _streamSub =
        _stream!.listen(_onRequest, onError: _onError, onDone: _onDone);
  }

  void _onRequest(msg_lib.Message msg) {
//    print('$this _onRequest msg ${msg}');
    if (!_requestHandlers!.containsKey(msg.channelId)) {
      if (msg.type == msg_lib.ENDPOINT) {
        requestHandlerForEndPoint(
            headers, msg.data!['endPoint'] as String?, msg.channelId);
      }
    }
  }

  requestHandlerForEndPoint(
      Map<String, String> headers, String? endPoint, String? channelId) {
    RequestHandler? handler = _requestHandlers![endPoint!];
    handler ??= ErrorRequestHandler('Endpoint : $endPoint not found');
    var request = ChannelServerRequest(headers,
        msg_lib.OutputStream(channelId, _stream!, _commandController).stream);

    // scicancel.runCancelZoned(() {
    requestHandlerForEndPointZoned(() {
      Stream outputStream;

      var res = handler!.request(request);

      if (res is Future) {
        outputStream =
            StreamCompleter.fromFuture(res.then((res) => res.stream as Stream));
      } else if (res is ChannelServerResponse) {
        outputStream = res.stream;
      } else {
        throw 'error bad response';
      }

      if (logger.isLoggable(Level.FINE)) {
        var watch = Stopwatch()..start();
        var start = DateTime.now();
        var count = 0;
        outputStream = outputStream.asBroadcastStream();
        var listen = (each) {};

        if (logger.isLoggable(Level.FINEST)) {
          listen = (each) {
            logger.finest(
                'EVENT -- endPoint = $endPoint -- channelId = $channelId '
                '-- count = $count '
                '-- ms ${watch.elapsedMilliseconds}');
            count++;
            watch.reset();
          };
        }

        outputStream.listen(listen, onDone: () {
          logger.finer('DONE -- endPoint = $endPoint -- channelId = $channelId '
              '-- ms ${DateTime.now().difference(start).inMilliseconds}');
          watch.reset();
        }, onError: (e, st) {
          logger
              .severe('ERROR -- endPoint = $endPoint -- channelId = $channelId '
                  '-- ms ${DateTime.now().difference(start).inMilliseconds} '
                  '-- error = $e ');
          if (e is ServiceError && e.isUserAbortError) {
          } else {
            logger.severe(Trace.format(st as StackTrace));
            watch.stop();
          }
        });
      }

      _streamGroup!.add(msg_lib.InputStreamConsumer(
              channelId, outputStream.cast<Map>(), _stream!)
          .stream);
    });
  }

  void registerEndPoint(String endPoint, RequestHandler handler) {
    _requestHandlers![endPoint] = handler;
  }

  void _onError(Object e, StackTrace st) {
    print('$this _onError $e');
    print(st);
    close();
  }

  void _onDone() {
    close();
  }

  void close() {
    if (_commandController != null) _commandController!.close();
    if (_streamGroup != null) _streamGroup!.close();
    if (_streamSub != null) _streamSub!.cancel();
    if (_requestHandlers != null) {
      for (var each in _requestHandlers!.values) {
        each.close();
      }
    }
    _commandController = null;
    _streamGroup = null;
    _streamSub = null;
    _stream = null;
    _channel = null;
    _requestHandlers = null;
  }
}

class ChannelServerRequest {
  final Stream<Map?> stream;
  Map<String, String> headers;

  ChannelServerRequest(this.headers, this.stream);
}

class ChannelServerResponse {
  final Stream<dynamic> stream;
  ChannelServerResponse(this.stream);
}
