# Service Extensions Summary

This document summarizes the stream-based service extensions added to the Tercen client library for Flutter web applications.

## Overview

Stream extensions have been added to all Tercen services, providing a convenient way to query and stream documents using Dart's async streams. These extensions are particularly useful for Flutter web applications built with WASM.

## Files Added

### Core Extensions
- **`lib/src/sci_client_extensions.dart`**: All service extension methods (33 methods across 17 services)
- **Exported in**: `lib/sci_client.dart`

### Examples
- **`example/streams_basic.dart`**: Basic usage examples
- **`example/streams_advanced.dart`**: Advanced patterns including useFactory demonstration
- **`example/streams_flutter_web.dart`**: Complete Flutter web app example
- **`example/README.md`**: Comprehensive documentation and patterns

## Key Features

### 1. Stream-Based Queries

All extensions return `Stream<T>` instead of `Future<List<T>>`, enabling:
- Progressive loading
- Real-time UI updates
- Memory-efficient processing of large result sets
- Easy composition with Dart stream operations

### 2. useFactory Parameter

Every method includes a `useFactory` parameter:

```dart
Stream<ProjectDocument> findFileByLastModifiedDateStream({
  // ... other parameters
  bool useFactory = false,
})
```

**When `useFactory=false`** (default):
- Returns abstract base type instances (e.g., `ProjectDocument`)
- Lighter weight
- Only basic properties available
- Better performance for large result sets

**When `useFactory=true`**:
- Returns concrete subclass instances (e.g., `FileDocument`, `TableSchema`, `Workflow`)
- Full type information available
- Can access subclass-specific properties
- Enables runtime type checking with `is` operator

### 3. Type-Safe Lambdas

All lambdas use abstract types with casting when needed:

```dart
(ProjectDocument doc) => [doc.projectId, doc.lastModifiedDate.value]  // No cast needed
(ProjectDocument doc) => [(doc as FileDocument).dataUri]  // Cast for subclass property
```

This ensures type safety while maintaining flexibility.

## Services with Extensions

All 17 services now have stream extensions:

1. **PatchRecordService** - 1 method
2. **PersistentService** - 2 methods
3. **DocumentService** - 4 methods
4. **ProjectDocumentService** - 6 methods
5. **FolderService** - 1 method
6. **TableSchemaService** - 1 method
7. **ProjectService** - 2 methods
8. **TeamService** - 1 method
9. **UserService** - 2 methods
10. **UserSecretService** - 1 method
11. **SubscriptionPlanService** - 2 methods
12. **FileService** - 1 method
13. **TaskService** - 2 methods
14. **GarbageCollectorService** - 1 method
15. **EventService** - 1 method
16. **ActivityService** - 3 methods
17. **CranLibraryService** - 1 method

**Total: 33 extension methods**

## Usage with createServiceFactoryForWebApp

The extensions are designed to work seamlessly with the web factory:

```dart
import 'package:sci_tercen_client/sci_service_factory_web.dart';
import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart' as tercen;

void main() async {
  // Initialize for web app
  await createServiceFactoryForWebApp(
    tercenToken: 'your-token',
    serviceUri: 'https://tercen.com',
  );

  // Use extensions
  var projectService = tercen.ServiceFactory().projectService;

  await for (var project in projectService.findByIsPublicAndLastModifiedDateStream(
    descending: true,
    useFactory: true,
  )) {
    print('Project: ${project.name}');
  }
}
```

## Common Patterns

### Pattern 1: Load All Items
```dart
var items = await service.findStream(useFactory: true).toList();
```

### Pattern 2: Load First N Items
```dart
await for (var item in service.findStream(useFactory: true)) {
  print(item.name);
  if (count++ >= 10) break;
}
```

### Pattern 3: Filter and Transform
```dart
var filtered = service.findStream(useFactory: true)
  .where((item) => item.isValid)
  .map((item) => item.name)
  .take(20);
```

### Pattern 4: Progressive Loading in Flutter
```dart
await for (var item in service.findStream(useFactory: true)) {
  setState(() {
    items.add(item);
  });
}
```

### Pattern 5: Type-Specific Handling
```dart
await for (var doc in service.findProjectObjectsByLastModifiedDateStream(
  useFactory: true,
)) {
  if (doc is FileDocument) {
    print('File: ${doc.storageSize} bytes');
  } else if (doc is TableSchema) {
    print('Table: ${doc.nRows} rows');
  }
}
```

## Documentation

Each extension method includes comprehensive documentation:
- One-line summary
- Return type description
- Parameter documentation with defaults
- Explanation of `useFactory` parameter
- ACL context information

## Examples Provided

### 1. Basic Example (`streams_basic.dart`)
- Service factory initialization
- Basic stream queries
- Finding projects, files, operators
- Simple useFactory usage

### 2. Advanced Example (`streams_advanced.dart`)
- Detailed useFactory comparison
- Complex multi-field queries
- Stream processing and filtering
- Pagination patterns

### 3. Flutter Web Example (`streams_flutter_web.dart`)
- Complete Flutter WASM app
- Project browser UI
- Progressive loading
- Error handling
- Navigation and state management

## Benefits for Flutter Web Apps

1. **Progressive Loading**: Show results as they arrive
2. **Memory Efficient**: Process large result sets without loading all at once
3. **Type Safe**: Full compile-time type checking
4. **Flexible**: Easy to compose with standard Dart stream operations
5. **Performant**: Choose between lightweight abstract types or full concrete types
6. **Modern API**: Idiomatic Dart async/await patterns

## Migration from Existing Code

### Before (using findStartKeys):
```dart
var results = await service.findProjectObjectsByLastModifiedDate(
  startKey: [projectId, date],
  endKey: [projectId, '\uf000'],
  limit: 100,
  useFactory: true,
);
```

### After (using stream extension):
```dart
var results = await service.findProjectObjectsByLastModifiedDateStream(
  startKeyProjectId: projectId,
  startKeyLastModifiedDate: date,
  useFactory: true,
).toList();

// Or progressive:
await for (var doc in service.findProjectObjectsByLastModifiedDateStream(...)) {
  // Process each document as it arrives
}
```

## Notes

- Extensions maintain backward compatibility - existing code continues to work
- All extensions are exported through `sci_client.dart`
- Type system ensures correctness at compile time
- Stream-based API is more idiomatic for Flutter/Dart
- Well-suited for WASM deployment with efficient memory usage

## See Also

- `example/README.md` - Detailed usage guide and patterns
- `lib/src/sci_client_extensions.dart` - Full API documentation
- `example/streams_flutter_web.dart` - Complete working example
