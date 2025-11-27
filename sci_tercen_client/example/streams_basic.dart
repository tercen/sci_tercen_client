/// Basic example demonstrating stream-based query extensions
/// for Tercen client in a Flutter web app.
///
/// This example shows how to use createServiceFactoryForWebApp
/// and stream extensions for querying documents.

import 'package:sci_tercen_client/sci_service_factory_web.dart';
import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_tercen_client/src/sci_client_extensions.dart';

void main() async {
  // Initialize the service factory for web app
  // Token and URI can be provided via environment variables or parameters
  await createServiceFactoryForWebApp(
    tercenToken: 'your-token-here',  // or set TERCEN_TOKEN env var
    serviceUri: 'https://tercen.com', // or set SERVICE_URI env var
  );

  // Example 1: Find recent projects using streams
  print('=== Example 1: Find recent projects ===');
  await findRecentProjects();

  // Example 2: Find files in a project
  print('\n=== Example 2: Find files in a project ===');
  await findProjectFiles('project-id-here');

  // Example 3: Find public projects
  print('\n=== Example 3: Find public projects ===');
  await findPublicProjects();

  // Example 4: Search operators by owner
  print('\n=== Example 4: Find operators by owner ===');
  await findOperatorsByOwner('user-id-here');
}

/// Find recent projects using the stream extension
Future<void> findRecentProjects() async {
  var projectService = ServiceFactory().projectService;

  // Using stream extension to find public projects ordered by last modified date
  var count = 0;
  await for (var project in projectService.findByIsPublicAndLastModifiedDateStream(
    startKeyIsPublic: true,
    endKeyIsPublic: true,
    descending: true,  // Most recent first
    useFactory: true,  // Get concrete Project instances with full type info
  )) {
    print('Project: ${project.name} (${project.id})');
    print('  Owner: ${project.acl.owner}');
    print('  Modified: ${project.lastModifiedDate.value}');
    count++;
    if (count >= 5) break;  // Limit to 5 results
  }
  print('Found $count recent projects');
}

/// Find files in a specific project
Future<void> findProjectFiles(String projectId) async {
  var projectDocService = ServiceFactory().projectDocumentService;

  // Find files by project ID and last modified date
  var count = 0;
  await for (var doc in projectDocService.findFileByLastModifiedDateStream(
    startKeyProjectId: projectId,
    endKeyProjectId: projectId,
    descending: true,
    useFactory: true,  // Get concrete FileDocument instances
  )) {
    // When useFactory=true, doc is actually a FileDocument
    if (doc is FileDocument) {
      print('File: ${doc.name}');
      print('  Size: ${doc.storageSize} bytes');
      print('  Modified: ${doc.lastModifiedDate.value}');
    }
    count++;
    if (count >= 10) break;
  }
  print('Found $count files');
}

/// Find public projects by team
Future<void> findPublicProjects() async {
  var projectService = ServiceFactory().projectService;

  var count = 0;
  await for (var project in projectService.findByIsPublicAndLastModifiedDateStream(
    startKeyIsPublic: true,
    endKeyIsPublic: true,
    descending: true,
    useFactory: false,  // Get abstract Project type (lighter weight)
  )) {
    print('Public project: ${project.name}');
    count++;
    if (count >= 10) break;
  }
  print('Found $count public projects');
}

/// Find operators by owner
Future<void> findOperatorsByOwner(String ownerId) async {
  var documentService = ServiceFactory().documentService;

  var count = 0;
  await for (var doc in documentService.findOperatorByOwnerLastModifiedDateStream(
    startKeyOwner: ownerId,
    endKeyOwner: ownerId,
    descending: true,
    useFactory: true,  // Get concrete Operator instances
  )) {
    if (doc is Operator) {
      print('Operator: ${doc.name}');
      print('  URL: ${doc.url.uri}');
      print('  Version: ${doc.version}');
    }
    count++;
    if (count >= 5) break;
  }
  print('Found $count operators');
}
