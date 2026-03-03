import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'helper.dart';
import 'package:sci_tercen_client/src/sci_client_extensions.dart';

void main() async {
  var factory = await initFactory();
  var project = await getOrCreateProject(factory, 'example-project');
  print('project: ${project.id}');

  // --- Explore public projects by category ---
  var explored = await factory.projectService.explore('all', 0, 5);
  print('explore: ${explored.length} projects');
  for (var p in explored) {
    print('  ${p.name}');
  }

  // --- Recent projects for a user ---
  var user = (await factory.userService
          .findUserByEmailStream()
          .take(1)
          .toList())
      .first;
  var recent = await factory.projectService.recentProjects(user.id);
  print('recent: ${recent.length} projects');

  // --- Profiles ---
  var profiles = await factory.projectService.profiles(project.id);
  print('profiles: ${profiles.toJson()}');

  // --- Resource summary ---
  var summary = await factory.projectService.resourceSummary(project.id);
  print('summary: ${summary.toJson()}');

  // --- Clone project ---
  var cloneTarget = sci.Project()
    ..name = 'cloned-project'
    ..isPublic = true;
  var cloned =
      await factory.projectService.cloneProject(project.id, cloneTarget);
  print('cloned: ${cloned.id} ${cloned.name}');

  // cleanup
  var rev = await factory.projectService.rev(cloned.id);
  await factory.projectService.delete(cloned.id, rev);
}
