# Tercen Client Examples

This directory contains examples demonstrating how to use the Tercen client library in Flutter web applications (WASM).

## Examples

### 1. `streams_basic.dart` - Basic Stream Queries

Basic examples showing how to:
- Initialize the service factory using `createServiceFactoryForWebApp()`
- Use stream extensions for querying documents
- Find recent projects, files, and operators
- Use the `useFactory` parameter

**Key concepts:**
```dart
// Initialize for web app
await createServiceFactoryForWebApp(
  tercenToken: 'your-token',
  serviceUri: 'https://tercen.com'
);

// Use stream extension
await for (var project in projectService.findByIsPublicAndLastModifiedDateStream(
  descending: true,
  useFactory: true,  // Returns concrete Project instances
)) {
  print('Project: ${project.name}');
}
```

### 2. `streams_advanced.dart` - Advanced Stream Usage

Advanced examples demonstrating:
- The difference between `useFactory=true` and `useFactory=false`
- Complex multi-field queries
- Stream processing with filters and transformations
- Pagination patterns

**Key concepts:**

#### useFactory Parameter

```dart
// useFactory=false: Returns abstract base types (lighter weight)
await for (var doc in service.findProjectObjectsByLastModifiedDateStream(
  useFactory: false,  // Returns ProjectDocument
)) {
  // Can only access ProjectDocument properties
  print('${doc.name} - ${doc.projectId}');
}

// useFactory=true: Returns concrete subclass instances (full type info)
await for (var doc in service.findProjectObjectsByLastModifiedDateStream(
  useFactory: true,  // Returns FileDocument, TableSchema, Workflow, etc.
)) {
  // Can check type and access subclass-specific properties
  if (doc is FileDocument) {
    print('File size: ${doc.storageSize}');
  } else if (doc is TableSchema) {
    print('Table rows: ${doc.nRows}');
  }
}
```

#### Stream Processing

```dart
// Filter and transform streams
var largeFiles = service.findFileByLastModifiedDateStream(
  projectId: projectId,
  useFactory: true,
)
.where((doc) => doc is FileDocument && doc.storageSize > 1000000)
.map((doc) => doc as FileDocument)
.take(5);
```

### 3. `streams_flutter_web.dart` - Flutter Web App Integration

Complete Flutter web application example showing:
- Integration with Flutter WASM
- Project browser UI with real-time loading
- Project detail page showing files, tables, and workflows
- Error handling and loading states
- Navigation between pages

**Key features:**
- Uses `createServiceFactoryForWebApp()` in `main()`
- Demonstrates progressive loading using streams
- Shows how to handle concrete types in UI
- Material Design UI components

## Running the Examples

### Basic and Advanced Examples

These are console applications:

```bash
cd sci_tercen_client

# Set environment variables
export TERCEN_TOKEN="your-token-here"
export SERVICE_URI="https://tercen.com"

# Run basic example
dart run example/streams_basic.dart

# Run advanced example
dart run example/streams_advanced.dart
```

### Flutter Web Example

This is a Flutter web application:

```bash
cd sci_tercen_client

# Build for web (WASM)
flutter build web --wasm

# Or run in development mode
flutter run -d chrome
```

#### Environment Configuration

You can configure the token and URI in several ways:

1. **Environment variables at build time:**
```bash
flutter build web --wasm \
  --dart-define=TERCEN_TOKEN=your-token \
  --dart-define=SERVICE_URI=https://tercen.com
```

2. **URL parameters at runtime:**
```
https://your-app.com/?token=your-token&serviceUri=https://tercen.com
```

3. **Local storage:** Store token in browser's local storage

## Service Extensions Available

All service extensions follow the same pattern and are available for:

- **PatchRecordService**: `findByChannelIdAndSequenceStream()`
- **PersistentService**: `findDeletedStream()`, `findByKindStream()`
- **DocumentService**: `findProjectByOwnersAndNameStream()`, `findOperatorByUrlAndVersionStream()`, etc.
- **ProjectDocumentService**: `findProjectObjectsByLastModifiedDateStream()`, `findFileByLastModifiedDateStream()`, etc.
- **ProjectService**: `findByIsPublicAndLastModifiedDateStream()`, `findByTeamAndIsPublicAndLastModifiedDateStream()`
- **UserService**: `findUserByCreatedDateAndNameStream()`, `findUserByEmailStream()`
- **TeamService**: `findTeamByOwnerStream()`
- **FileService**: `findByDataUriStream()`
- **TaskService**: `findByHashStream()`, `findGCTaskByLastModifiedDateStream()`
- **ActivityService**: `findByUserAndDateStream()`, `findByTeamAndDateStream()`, `findByProjectAndDateStream()`
- And more...

## Common Patterns

### Pattern 1: Loading All Items

```dart
var items = await service.findByKeyStream(
  useFactory: true,
).toList();
```

### Pattern 2: Loading First N Items

```dart
await for (var item in service.findByKeyStream(useFactory: true)) {
  print(item.name);
  if (count++ >= 10) break;
}
```

### Pattern 3: Filtering and Processing

```dart
var filtered = service.findByKeyStream(useFactory: true)
  .where((item) => item.isValid)
  .map((item) => item.name)
  .take(20);
```

### Pattern 4: Pagination

```dart
// Page 1
var page1 = await service.findByKeyStream().take(10).toList();

// Page 2 (start after last item from page 1)
var lastItem = page1.last;
var page2 = await service.findByKeyStream(
  startKey: lastItem.key,
).skip(1).take(10).toList();
```

### Pattern 5: Real-time Updates

```dart
// In Flutter widget
await for (var item in service.findByKeyStream(useFactory: true)) {
  setState(() {
    items.add(item);
  });
}
```

## Best Practices

1. **Use `useFactory=true` when you need concrete types**
   - When displaying type-specific properties in UI
   - When you need to access subclass methods
   - When type checking is required

2. **Use `useFactory=false` when you only need base properties**
   - For better performance
   - When you only need common properties like `id`, `name`, `lastModifiedDate`
   - For large result sets where type info isn't needed

3. **Use stream transformations for filtering**
   - Apply `.where()`, `.map()`, `.take()` for client-side filtering
   - More flexible than server-side filtering

4. **Handle errors gracefully**
   - Wrap stream processing in try-catch
   - Display error messages to users
   - Provide retry mechanisms

5. **Progressive loading in Flutter**
   - Use `setState()` to update UI as items arrive
   - Show loading indicators
   - Implement "load more" buttons for pagination

## Documentation

For detailed API documentation, see the inline documentation in each extension method at:
`lib/src/sci_client_extensions.dart`

Each method includes:
- Description of what it does
- Parameter documentation with default values
- Explanation of the `useFactory` parameter
- Return type information
