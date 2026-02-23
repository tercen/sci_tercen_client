import 'dart:io';
import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'package:sci_tercen_client/sci_client_base.dart';
import 'package:sci_http_client/http_auth_client.dart';

Future<ServiceFactoryBase> initFactory() async {
  var uri = Platform.environment['TERCEN_URI'] ?? 'http://127.0.0.1:5400';
  var token = Platform.environment['TERCEN_TOKEN'];
  if (token == null) throw 'TERCEN_TOKEN env var required';

  var authClient = HttpAuthClient('Bearer $token');
  var factory = ServiceFactoryBase();
  await factory.initializeWith(Uri.parse(uri), authClient);
  return factory;
}

Future<sci.Project> getOrCreateProject(
    ServiceFactoryBase factory, String name) async {
  var projects = await factory.documentService
      .findProjectByOwnersAndNameStream(
          startKeyName: name, endKeyName: name)
      .toList();

  if (projects.isNotEmpty) return projects.first as sci.Project;

  var project = sci.Project()
    ..name = name
    ..isPublic = true;
  return await factory.projectService.create(project);
}
