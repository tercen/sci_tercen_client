import 'package:sci_tercen_client/sci_client.dart';
import 'helper.dart';
import 'package:sci_tercen_client/src/sci_client_extensions.dart';

void main() async {
  var factory = await initFactory();
  var project = await getOrCreateProject(factory, 'example-project');

  // --- Find project objects by last modified date (stream) ---
  var docs = await factory.projectDocumentService
      .findProjectObjectsByLastModifiedDateStream(
          startKeyProjectId: project.id,
          endKeyProjectId: project.id,
          useFactory: true)
      .take(10)
      .toList();
  print('project docs: ${docs.length}');
  for (var d in docs) {
    print('  ${d.runtimeType}: ${d.name}');
  }

  // --- Find by folder and name (stream) ---
  var byFolder = await factory.projectDocumentService
      .findProjectObjectsByFolderAndNameStream(
          startKeyProjectId: project.id,
          endKeyProjectId: project.id,
          useFactory: true)
      .take(10)
      .toList();
  print('by folder: ${byFolder.length}');

  // --- Get from path ---
  if (docs.isNotEmpty) {
    var doc = await factory.projectDocumentService
        .getFromPath(project.id, docs.first.name, true);
    print('getFromPath: ${doc.name} (${doc.runtimeType})');

    // --- Get parent folders ---
    var parents =
        await factory.projectDocumentService.getParentFolders(doc.id);
    print('parent folders: ${parents.length}');

    // --- Clone project document ---
    var cloned = await factory.projectDocumentService
        .cloneProjectDocument(doc.id, project.id);
    print('cloned doc: ${cloned.name}');
  }
}
