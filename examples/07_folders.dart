import 'package:sci_tercen_client/sci_client.dart';
import 'helper.dart';
import 'package:sci_tercen_client/src/sci_client_extensions.dart';

void main() async {
  var factory = await initFactory();
  var project = await getOrCreateProject(factory, 'example-project');

  // --- GetOrCreate folder ---
  var folder =
      await factory.folderService.getOrCreate(project.id, 'data/raw');
  print('folder: ${folder.id} name=${folder.name}');
  print('  projectId=${folder.projectId} folderId=${folder.folderId}');

  // --- Nested folder ---
  var nested =
      await factory.folderService.getOrCreate(project.id, 'data/raw/2024');
  print('nested: ${nested.name}');

  // --- Find folders by parent (stream) ---
  var folders = await factory.folderService
      .findFolderByParentFolderAndNameStream(
          startKeyProjectId: project.id, endKeyProjectId: project.id)
      .toList();
  print('folders in project: ${folders.length}');
  for (var f in folders) {
    print('  ${f.name} (parent=${f.folderId})');
  }
}
