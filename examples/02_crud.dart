import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'helper.dart';

void main() async {
  var factory = await initFactory();

  // --- Create ---
  var project = sci.Project()
    ..name = 'crud-example'
    ..isPublic = true;
  project = await factory.projectService.create(project);
  print('created: ${project.id} rev=${project.rev}');

  // --- Get ---
  var fetched = await factory.projectService.get(project.id);
  print('get: ${fetched.name}');

  // --- Rev ---
  var currentRev = await factory.projectService.rev(project.id);
  print('rev: $currentRev');

  // --- Update ---
  fetched.description = 'Updated description';
  var newRev = await factory.projectService.update(fetched);
  print('updated rev: $newRev');

  // --- List ---
  var items = await factory.projectService.list([project.id]);
  print('list: ${items.length} items');

  // --- ListNotFound ---
  var maybeItems =
      await factory.projectService.listNotFound([project.id, 'nonexistent']);
  for (var item in maybeItems) {
    print('listNotFound: ${item?.name ?? "NOT FOUND"}');
  }

  // --- Delete ---
  await factory.projectService.delete(project.id, newRev);
  print('deleted');
}
