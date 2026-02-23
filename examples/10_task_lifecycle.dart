import 'dart:convert';
import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'helper.dart';

void main() async {
  var factory = await initFactory();
  var project = await getOrCreateProject(factory, 'example-project');

  // --- Create + run a CSVTask ---
  var csvContent = 'x,y\n1,2\n3,4\n';
  var fileDoc = sci.FileDocument()
    ..name = 'task-data.csv'
    ..projectId = project.id;
  var uploaded = await factory.fileService
      .upload(fileDoc, Stream.value(utf8.encode(csvContent)));

  var csvTask = sci.CSVTask()
    ..fileDocumentId = uploaded.id
    ..projectId = project.id
    ..owner = project.acl.owner;
  csvTask = await factory.taskService.create(csvTask) as sci.CSVTask;
  print('task created: ${csvTask.id}');

  // --- Set environment before running ---
  await factory.taskService.setTaskEnvironment(csvTask.id, [
    sci.Pair()
      ..key = 'MY_VAR'
      ..value = 'my_value',
  ]);
  print('environment set');

  // --- Run + wait ---
  await factory.taskService.runTask(csvTask.id);
  var done = await factory.taskService.waitDone(csvTask.id);
  print('task state: ${done.state.runtimeType}');
  print('duration: ${done.duration}s');

  if (done.state is sci.FailedState) {
    var failed = done.state as sci.FailedState;
    print('FAILED: ${failed.reason}');
  }

  // --- RunWorkflowTask (requires existing workflow) ---
  // var wfTask = sci.RunWorkflowTask()
  //   ..workflowId = 'some-workflow-id'
  //   ..projectId = project.id
  //   ..owner = project.acl.owner;
  // wfTask = await factory.taskService.create(wfTask) as sci.RunWorkflowTask;
  // await factory.taskService.runTask(wfTask.id);
  // var wfDone = await factory.taskService.waitDone(wfTask.id);

  // --- Cancel a running task ---
  // await factory.taskService.cancelTask(taskId);
}
