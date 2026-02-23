import 'package:sci_tercen_client/sci_client.dart';
import 'helper.dart';

void main() async {
  var factory = await initFactory();

  // --- Search documents ---
  var result = await factory.documentService.search('test', 10, true, '');
  print('search: ${result.toJson().keys}');

  // --- Get library ---
  var lib = await factory.documentService.getLibrary(
      '', // projectId (empty for global)
      [], // teamIds
      [], // docTypes filter
      [], // tags filter
      0,
      10);
  print('library: ${lib.length} documents');

  // --- Tercen operator library ---
  var ops = await factory.documentService.getTercenOperatorLibrary(0, 10);
  print('operators: ${ops.length}');
  for (var op in ops.take(3)) {
    print('  ${op.name} v${op.version}');
  }

  // --- Find projects by owner and name (stream) ---
  var projects = await factory.documentService
      .findProjectByOwnersAndNameStream()
      .take(5)
      .toList();
  print('projects: ${projects.length}');
  for (var p in projects) {
    print('  ${p.name}');
  }

  // --- Find operators by owner (stream) ---
  var operators = await factory.documentService
      .findOperatorByOwnerLastModifiedDateStream()
      .take(5)
      .toList();
  print('operators (stream): ${operators.length}');
}
