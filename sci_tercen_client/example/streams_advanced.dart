/// Advanced example demonstrating the difference between useFactory=true and useFactory=false
/// and more complex query patterns.

import 'package:sci_tercen_client/sci_service_factory_web.dart';
import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart' as tercen;

void main() async {
  // Initialize service factory
  await createServiceFactoryForWebApp();

  // Example 1: Demonstrate useFactory parameter
  print('=== Example 1: useFactory parameter ===');
  await demonstrateUseFactory();

  // Example 2: Complex multi-field queries
  print('\n=== Example 2: Multi-field queries ===');
  await complexQueries();

  // Example 3: Stream processing with filters
  print('\n=== Example 3: Stream processing ===');
  await streamProcessing();

  // Example 4: Pagination with streams
  print('\n=== Example 4: Pagination ===');
  await paginationExample();
}

/// Demonstrate the difference between useFactory=true and useFactory=false
Future<void> demonstrateUseFactory() async {
  var projectDocService = tercen.ServiceFactory().projectDocumentService;
  var projectId = 'your-project-id';

  print('--- With useFactory=false (abstract types) ---');
  var countAbstract = 0;
  await for (var doc in projectDocService.findProjectObjectsByLastModifiedDateStream(
    startKeyProjectId: projectId,
    endKeyProjectId: projectId,
    useFactory: false,  // Returns ProjectDocument (abstract type)
  )) {
    print('Document: ${doc.name} (kind: ${doc.kind})');
    print('  Type: ${doc.runtimeType}');  // Will be ProjectDocument
    print('  Has basic properties: projectId, name, lastModifiedDate');
    // Cannot access FileDocument-specific or TableSchema-specific properties
    countAbstract++;
    if (countAbstract >= 3) break;
  }

  print('\n--- With useFactory=true (concrete types) ---');
  var countConcrete = 0;
  await for (var doc in projectDocService.findProjectObjectsByLastModifiedDateStream(
    startKeyProjectId: projectId,
    endKeyProjectId: projectId,
    useFactory: true,  // Returns concrete subclasses
  )) {
    print('Document: ${doc.name} (kind: ${doc.kind})');
    print('  Type: ${doc.runtimeType}');  // Will be FileDocument, TableSchema, etc.

    // Can check type and access specific properties
    if (doc is FileDocument) {
      print('  File size: ${doc.storageSize} bytes');
      print('  Data URI: ${doc.dataUri}');
    } else if (doc is TableSchema) {
      print('  Rows: ${doc.nRows}');
      print('  Columns: ${doc.columns.length}');
    } else if (doc is Workflow) {
      print('  Steps: ${doc.steps.length}');
    }
    countConcrete++;
    if (countConcrete >= 3) break;
  }
}

/// Complex multi-field queries
Future<void> complexQueries() async {
  var projectService = tercen.ServiceFactory().projectService;

  // Find projects by team, public status, and date range
  print('Finding team projects (public only, recent)...');
  var count = 0;
  await for (var project in projectService.findByTeamAndIsPublicAndLastModifiedDateStream(
    startKeyOwner: 'team-id',
    endKeyOwner: 'team-id',
    startKeyIsPublic: true,
    endKeyIsPublic: true,
    startKeyLastModifiedDate: '2024-01-01',
    endKeyLastModifiedDate: '2025-12-31',
    descending: true,
    useFactory: true,
  )) {
    print('Project: ${project.name}');
    print('  Team: ${project.acl.owner}');
    print('  Public: ${project.isPublic}');
    print('  Modified: ${project.lastModifiedDate.value}');
    count++;
    if (count >= 5) break;
  }
}

/// Stream processing with custom filters and transformations
Future<void> streamProcessing() async {
  var projectDocService = tercen.ServiceFactory().projectDocumentService;
  var projectId = 'your-project-id';

  print('Finding large files...');

  // Stream all files and filter for large ones
  var largeFiles = projectDocService.findFileByLastModifiedDateStream(
    startKeyProjectId: projectId,
    endKeyProjectId: projectId,
    useFactory: true,
  )
  .where((doc) => doc is FileDocument && doc.storageSize > 1000000)  // > 1MB
  .map((doc) => doc as FileDocument)
  .take(5);  // Limit to 5 results

  await for (var file in largeFiles) {
    print('Large file: ${file.name}');
    print('  Size: ${(file.storageSize / 1024 / 1024).toStringAsFixed(2)} MB');
  }
}

/// Pagination example
Future<void> paginationExample() async {
  var userService = tercen.ServiceFactory().userService;

  print('Paginating through users...');

  // Page 1: First 10 users
  var page1 = await userService.findUserByCreatedDateAndNameStream(
    useFactory: true,
  ).take(10).toList();

  print('Page 1: ${page1.length} users');
  page1.forEach((user) => print('  - ${user.name} (${user.email})'));

  // Page 2: Next 10 users (start after last user from page 1)
  if (page1.isNotEmpty) {
    var lastUser = page1.last;
    var page2 = await userService.findUserByCreatedDateAndNameStream(
      startKeyCreatedDate: lastUser.createdDate.value,
      startKeyName: lastUser.name,
      useFactory: true,
    ).skip(1).take(10).toList();  // Skip the last user from page 1

    print('Page 2: ${page2.length} users');
    page2.forEach((user) => print('  - ${user.name} (${user.email})'));
  }
}
