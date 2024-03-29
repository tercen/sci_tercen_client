import 'dart:async';
import 'package:stack_trace/stack_trace.dart';
import '../../error.dart';

const MESSAGE = 'msg';
const CANCEL = 'cancel';
const PAUSE = 'pause';
const RESUME = 'resume';
const LISTEN = 'listen';
const ENDPOINT = 'endpoint';

const ERROR_IN = 'error_in';
const ERROR_OUT = 'error_in';

const DONE = 'done';

class Message {
  String? channelId;
  String? type;
  Map? data;

  Message.fromJson(Map m) {
    channelId = m['channelId'] as String?;
    type = m['type'] as String?;
    data = m['data'] as Map?;
  }

  Message(this.channelId, this.type, this.data);

  bool get isCancel => type == CANCEL;
  bool get isErrorIn => type == ERROR_IN;
  bool get isErrorOut => type == ERROR_OUT;

  bool get isDone => type == DONE;

  bool get isControl =>
      type == LISTEN ||
      type == CANCEL ||
      type == PAUSE ||
      type == RESUME ||
      type == ERROR_IN ||
      type == ERROR_OUT ||
      type == DONE;

  bool get isMsg => type == MESSAGE;

  Map toJson() => {'channelId': channelId, 'type': type, 'data': data};

  @override
  String toString() => '$runtimeType($channelId,$type,$data)';
}

class OutputStream {
  String? channelId;
  Stream<Message> inputStream;
  StreamSubscription<Message>? inputStreamSub;
  Sink<Message>? remoteCommandSink;
  late StreamController<Map?> controller;
  Completer? inputCompleter;

  OutputStream(this.channelId, this.inputStream, this.remoteCommandSink,
      [this.inputCompleter]) {
    controller = StreamController(
        onListen: onListen,
        onPause: onLocalPause,
        onResume: onLocalResume,
        onCancel: onLocalCancel,
        sync: true);

    inputStreamSub = inputStream
        .where((msg) => msg.channelId == channelId)
        .listen(_onRemoteMessage, onError: _onError, onDone: _onDone);
  }

  Stream<Map?> get stream => controller.stream;

  void onListen() {
//    print('$this onListen $channelId send LISTEN');
    remoteCommandSink!.add(Message(channelId, LISTEN, null));
  }

  void _onRemoteMessage(Message msg) {
//    print('$this _onRemoteMessage $msg');
    var type = msg.type;
    switch (type) {
      case MESSAGE:
        controller.add(msg.data);
        break;
      case CANCEL:
        _onRemoteCancel();
        break;
      case DONE:
        close();
        break;
      case ERROR_IN:
        controller.addError(ServiceError.fromJson(msg.data!));
        close();
        break;
    }
  }

  Future _onRemoteCancel() async {
//    print('$this ----------------------------------------------------- _onRemoteCancel');
    if (inputCompleter != null) {
      if (inputCompleter!.isCompleted) return;
      close();
    } else {
      close();
    }
//    new Future.delayed(new Duration(milliseconds: 1), close);
//    close();
  }

  void _onError(Object e, StackTrace st) {
    print('$this _onError $e');
    print(st);
    controller.addError(ServiceError.fromError(e), st);
    close();
  }

  void _onDone() {
    controller.addError(ServiceError.bad('inputStream shoud not be done'));
    close();
  }

  void onLocalPause() {
//    print('$this onLocalPause $channelId');
    remoteCommandSink!.add(Message(channelId, PAUSE, null));
  }

  void onLocalResume() {
//    print('$this onLocalResume $channelId');
    remoteCommandSink!.add(Message(channelId, RESUME, null));
  }

  onLocalCancel() {
    if (!controller.isClosed) {
      print('$this onLocalCancel before close $channelId');
    }

    remoteCommandSink!.add(Message(channelId, CANCEL, null));
  }

  void close() {
//    print('$this close $channelId');
    if (inputStreamSub != null) inputStreamSub!.cancel();
    inputStreamSub = null;
    controller.close();
  }
}

typedef CancelCallBack = void Function();

class InputStreamConsumer {
  String? channelId;
  Stream<Map> inputStream;
  StreamSubscription<Map>? inputStreamSub;

  StreamController<Message>? controller;

  Stream<Message> remoteCommandStream;
  StreamSubscription<Message>? remoteCommandStreamSub;

  late bool isLocalListen;
  late bool isRemotePause;
  late bool isLocalPause;

  Completer? done;

  CancelCallBack? cancelCallBack;

  InputStreamConsumer(
      this.channelId, this.inputStream, this.remoteCommandStream,
      {this.cancelCallBack}) {
    isRemotePause = false;
    isLocalPause = false;
    isLocalListen = false;

    done = Completer();

    remoteCommandStreamSub = remoteCommandStream
        .where((msg) => msg.channelId == channelId && msg.isControl)
        .listen(_onCommand, onError: _onCommandError, onDone: _onCommandDone);

    controller = StreamController(
        onListen: onListen,
        onPause: onPause,
        onResume: onResume,
        onCancel: onCancel,
        sync: true);
  }

  Future get onDone => done!.future;

  // remote commands
  void _onCommand(Message msg) {
//    print('$this _onCommand $channelId $msg');
    var type = msg.type;
    switch (type) {
      case LISTEN:
        onRemoteListen();
        break;
      case PAUSE:
        isRemotePause = true;
        inputStreamSub!.pause();
        break;
      case RESUME:
        isRemotePause = false;
        if (!isLocalPause) inputStreamSub!.resume();
        break;
      case CANCEL:
        if (!controller!.isClosed) {
          print('$this ----------------------- REMOTE CANCEL');
        }
        close();
        break;
      case ERROR_OUT:
        done!.completeError(ServiceError.fromJson(msg.data!));
        close();
        break;
      case ERROR_IN:
        done!.completeError(ServiceError.fromJson(msg.data!));
        controller!.add(Message(channelId, ERROR_OUT, msg.data));
        close();
        break;
    }
  }

  void _onCommandError(Object e, StackTrace st) {
//    print('$this _onCommandError $channelId $e');
//    print(st);
    done!.completeError(e, st);
    close();
  }

  void _onCommandDone() {
    // main stream is done
    close();
  }

  void onRemoteListen() {
    assert(isLocalListen);
    inputStreamSub = inputStream.listen((m) {
//      print('$this send MESSAGE $channelId $m');
      controller!.add(Message(channelId, MESSAGE, m));
    }, onError: (e, st) {
      print("$this inputStream error : $e");
      print(Trace.format(st as StackTrace));

//      print('$this send ERROR_IN $channelId');
      controller!.add(
          Message(channelId, ERROR_IN, ServiceError.fromError(e).toJson()));
      close();
    }, onDone: () {
//      print('$this inputStream onDone $channelId');
//      print('$this send DONE $channelId');
      controller!.add(Message(channelId, DONE, null));
      close();
    });
  }

  void onListen() {
//    print('$this onListen $channelId');
    isLocalListen = true;
  }

  void onPause() {
//    print('$this onPause $channelId');
    isLocalPause = true;
    inputStreamSub?.pause();
  }

  void onResume() {
//    print('$this onResume $channelId');
    isLocalPause = false;
    if (!isRemotePause) inputStreamSub?.resume();
  }

  onCancel() {
//    print('$this onCancel $channelId');

    if (controller != null) {
      if (!controller!.isClosed) {
        controller!.add(Message(channelId, CANCEL, null));
        close();
      }
    }
  }

  void close() {
    cancelCallBack?.call();

    if (controller!.isClosed) return;
    if (!done!.isCompleted) done!.complete(null);

    if (inputStreamSub != null) {
      inputStreamSub!.cancel();
    } else {
      print('$this -- remote has cancel before listen');
    }
    if (remoteCommandStreamSub != null) remoteCommandStreamSub!.cancel();

    if (controller != null) controller!.close();
    inputStreamSub = null;
    controller = null;
    remoteCommandStreamSub = null;
  }

  Stream<Message> get stream => controller!.stream;
}
