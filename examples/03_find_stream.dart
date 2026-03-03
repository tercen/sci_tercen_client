import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'helper.dart';
import 'package:sci_tercen_client/src/sci_client_extensions.dart';


void main() async {
  var factory = await initFactory();

  // --- Find public projects (stream, auto-paginates) ---
  var projects = await factory.projectService
      .findByIsPublicAndLastModifiedDateStream(startKeyIsPublic: true)
      .take(5)
      .toList();
  print('public projects: ${projects.length}');
  for (var p in projects) {
    print('  ${p.name} (public=${p.isPublic})');
  }

  // --- Find by team/owner ---
  var teamProjects = await factory.projectService
      .findByTeamAndIsPublicAndLastModifiedDateStream(
          startKeyOwner: 'test-team', endKeyOwner: 'test-team')
      .take(3)
      .toList();
  print('team projects: ${teamProjects.length}');

  // --- useFactory: true returns concrete types ---
  var docs = await factory.projectDocumentService
      .findProjectObjectsByLastModifiedDateStream(useFactory: true)
      .take(5)
      .toList();
  for (var doc in docs) {
    print('  ${doc.runtimeType}: ${doc.name}');
  }

  // --- Descending (newest first, default) vs ascending ---
  var ascending = await factory.projectService
      .findByIsPublicAndLastModifiedDateStream(
          startKeyIsPublic: true, descending: false)
      .take(3)
      .toList();
  print('ascending (oldest first): ${ascending.map((p) => p.name).toList()}');

  // --- Skip equivalent: just use Stream.skip() ---
  var page2 = await factory.projectService
      .findByIsPublicAndLastModifiedDateStream(startKeyIsPublic: true)
      .skip(5)
      .take(5)
      .toList();
  print('page 2: ${page2.length} projects');
}
