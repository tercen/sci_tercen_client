import 'dart:async';
import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'helper.dart';

void main() async {
  var factory = await initFactory();

  // --- Subscribe to a channel ---
  print('subscribing to channel...');
  var channelSub = factory.eventService.channel('my-channel').listen((event) {
    print('channel event: ${event.runtimeType}');
  });

  // --- Send events to channel ---
  var logEvent = sci.TaskLogEvent()..message = 'hello from client';
  await factory.eventService.sendChannel('my-channel', logEvent);

  var progressEvent = sci.TaskProgressEvent()
    ..message = 'processing'
    ..total = 100
    ..actual = 42;
  await factory.eventService.sendChannel('my-channel', progressEvent);
  print('events sent');

  // --- Listen to task channel (requires a running task) ---
  // var taskEvents = factory.eventService.listenTaskChannel(taskId, true);
  // await for (var event in taskEvents) {
  //   if (event is sci.TaskLogEvent) print('log: ${event.message}');
  //   if (event is sci.TaskProgressEvent) {
  //     print('progress: ${event.actual}/${event.total}');
  //   }
  //   if (event is sci.TaskStateEvent) {
  //     print('state: ${event.state.runtimeType}');
  //     if (event.state is sci.DoneState) break;
  //     if (event.state is sci.FailedState) break;
  //   }
  // }

  // --- onTaskState (simplified, only state changes) ---
  // await for (var stateEvent in factory.eventService.onTaskState(taskId)) {
  //   print('state: ${stateEvent.state.runtimeType}');
  //   if (stateEvent.state is sci.DoneState ||
  //       stateEvent.state is sci.FailedState) break;
  // }

  // --- Persistent channel ---
  // await factory.eventService.sendPersistentChannel('my-channel', logEvent);

  await Future.delayed(Duration(seconds: 1));
  await channelSub.cancel();
  print('done');
}
