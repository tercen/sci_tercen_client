import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'helper.dart';
import 'package:sci_tercen_client/src/sci_client_extensions.dart';

void main() async {
  var factory = await initFactory();
  var project = await getOrCreateProject(factory, 'example-project');

  // --- Find workflows in project ---
  var docs = await factory.projectDocumentService
      .findProjectObjectsByLastModifiedDateStream(
          startKeyProjectId: project.id,
          endKeyProjectId: project.id,
          useFactory: true)
      .where((d) => d is sci.Workflow)
      .take(5)
      .toList();
  print('workflows: ${docs.length}');

  if (docs.isNotEmpty) {
    var workflow = docs.first as sci.Workflow;
    print('workflow: ${workflow.name} (${workflow.id})');

    // --- Get workflow ---
    var wf = await factory.workflowService.get(workflow.id);
    print('steps: ${wf.steps.length}');

    // --- Get cube query for a step ---
    if (wf.steps.isNotEmpty) {
      var stepId = wf.steps.first.id;
      var cubeQuery =
          await factory.workflowService.getCubeQuery(wf.id, stepId);
      print('cubeQuery: ${cubeQuery.toJson().keys}');
    }

    // --- Copy app (workflow) to another project ---
    // var copied = await factory.workflowService.copyApp(wf.id, targetProjectId);
    // print('copied workflow: ${copied.id}');

    // --- Update workflow ---
    // wf.name = 'renamed-workflow';
    // var newRev = await factory.workflowService.update(wf);
    // print('updated rev: $newRev');
  }
}
