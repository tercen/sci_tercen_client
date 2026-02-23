# Phase 3: Tercen Integration

**This file is READ-ONLY during app builds. Do NOT modify it. If you encounter a gap or error, note it in the app's `_local/skill-feedback.md` and continue.**

Replace mock services with real Tercen data services. The Phase 2 mock app is your starting point.

**SDK**: sci_tercen_client — always use the latest version from <https://github.com/tercen/sci_tercen_client>

---

## Rules — read before writing any code

1. **No fallback chains in data access.** The real service has ONE fallback: Tercen fails entirely -> fall back to mock. Do NOT add fallback strategies within data access itself. Flow A and Flow B are different access patterns for different data, not fallback alternatives.
2. **Never navigate the JSON relation tree for tabular data.** The relation tree contains `SimpleRelation` nodes — references to stored tables, not embedded data. Use `tableSchemaService.select()` with the appropriate hash (qtHash, columnHash, rowHash). The ONLY use of JSON relation tree navigation is to find `.documentId` for file downloads (Flow B).
3. **Always use explicit GetIt type parameters.** `getIt.registerSingleton<ServiceFactory>(factory)` not `getIt.registerSingleton(factory)`. Omitting the type defaults to `Object` and causes runtime type mismatches.
4. **Never use `dart:html` or `http` package for Tercen API calls.** Always use `sci_tercen_client` services — they handle auth and CORS.
5. **When data access fails: STOP.** Do not add workarounds. Run the diagnostic report (see bottom of this skill), present results to the user. The fix may require workflow reconfiguration, a different flow choice, or an SDK enhancement — not more code.

---

## Inputs

1. Working mock app (Phase 2 output)
2. Functional spec Section 2.2 (Data Source) — determines Flow A, B, C, or D
3. A real Tercen taskId (Flows A/B/C) or projectId (Flow D) for testing (user provides)

---

## Choose data flow

Read the functional spec Section 2.2.

| Flow | When | Source |
| ---- | ---- | ------ |
| A | App displays computed values, charts, grids of data from Tercen projections | `query.qtHash` + `query.columnHash` + `query.rowHash` via `tableSchemaService.select()` — or use `OperatorContext` (see note) |
| B | App downloads files (images, ZIPs, documents) referenced by `.documentId` | `query.relation` JSON tree -> InMemoryTable -> `.documentId` -> `fileService.download()` |
| C | App needs both | Flow A for data + Flow B for files, in separate resolver classes |
| D | App browses/navigates Tercen objects (projects, workflows, steps, folders, documents) | Entity services (`projectService`, `workflowService`, `folderService`, etc.) with `startKey`/`endKey` range queries. No CubeQueryTask — uses `projectId` instead of `taskId`. |

---

## Step 1: main.dart

```dart
import 'package:sci_tercen_client/sci_service_factory_web.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const useMocks = bool.fromEnvironment('USE_MOCKS', defaultValue: false);

  ServiceFactory? tercenFactory;
  String? taskId;

  if (!useMocks) {
    try {
      tercenFactory = await createServiceFactoryForWebApp();
      taskId = Uri.base.queryParameters['taskId'];

      if (taskId == null || taskId.isEmpty) {
        runApp(_buildErrorApp('Missing taskId parameter'));
        return;
      }
    } catch (e) {
      debugPrint('Tercen init failed: $e');
    }
  }

  setupServiceLocator(
    useMocks: tercenFactory == null,
    tercenFactory: tercenFactory,
    taskId: taskId,
  );

  final prefs = await SharedPreferences.getInstance();
  runApp(YourApp(prefs: prefs));
}
```

---

## Step 2: service_locator.dart

```dart
import 'package:sci_tercen_client/sci_client_service_factory.dart';

void setupServiceLocator({
  bool useMocks = true,
  ServiceFactory? tercenFactory,
  String? taskId,
}) {
  if (serviceLocator.isRegistered<DataService>()) return;

  if (useMocks) {
    serviceLocator.registerLazySingleton<DataService>(() => MockDataService());
  } else {
    serviceLocator.registerSingleton<ServiceFactory>(tercenFactory!);
    serviceLocator.registerLazySingleton<DataService>(
      () => TercenDataService(tercenFactory, taskId: taskId),
    );
  }
}
```

For multiple services, register each with the same factory.

---

## Step 3: Task navigation

Put in `lib/utils/` or inline in your resolver.

```dart
import 'package:sci_tercen_client/sci_client.dart' show CubeQueryTask, RunWebAppTask;
import 'package:sci_tercen_client/sci_client_service_factory.dart' show ServiceFactory;

Future<CubeQueryTask> navigateToCubeQueryTask(
  ServiceFactory factory,
  String taskId,
) async {
  final task = await factory.taskService.get(taskId);
  if (task is CubeQueryTask) return task;
  if (task is RunWebAppTask) {
    if (task.cubeQueryTaskId.isEmpty) {
      throw StateError('RunWebAppTask has empty cubeQueryTaskId');
    }
    final cubeTask = await factory.taskService.get(task.cubeQueryTaskId);
    if (cubeTask is! CubeQueryTask) {
      throw StateError('Expected CubeQueryTask, got ${cubeTask.runtimeType}');
    }
    return cubeTask;
  }
  throw StateError('Unsupported task type: ${task.runtimeType}');
}
```

---

## Step 4A: Flow A — cross-tab projections

> **OperatorContext alternative.** For apps that only need cross-tab projections and operator properties, `sci_tercen_context` provides `OperatorContext` — a high-level wrapper that replaces raw `tableSchemaService` calls. See "OperatorContext (high-level)" in the API reference below. Use it when the app reads projections, operator settings, and optionally saves results back. Fall back to the raw three-hash approach below only when `OperatorContext` doesn't cover your access pattern.

### Three hashes

| Hash | Contains | Index |
| ---- | -------- | ----- |
| `query.qtHash` | `.x`, `.y`, `.ri`, `.ci` projection data | — |
| `query.columnHash` | Per-column metadata (group labels, upstream operator attributes) | Indexed by `.ci` |
| `query.rowHash` | Per-row metadata (variable names, gene names) | Indexed by `.ri` |

### Read from a hash

This pattern works for all three hashes:

```dart
Future<Map<int, Map<String, dynamic>>> _readFactorTable(
  ServiceFactory factory,
  String hash,
) async {
  if (hash.isEmpty) return {};
  final schema = await factory.tableSchemaService.get(hash);
  final names = schema.columns
      .map((c) => c.name)
      .where((n) => !n.startsWith('.'))
      .toList();
  if (names.isEmpty || schema.nRows == 0) return {};

  final table = await factory.tableSchemaService.select(
    hash, names, 0, schema.nRows,
  );

  final result = <int, Map<String, dynamic>>{};
  for (final col in table.columns) {
    final values = col.values as List?;
    if (values == null) continue;
    for (int i = 0; i < values.length; i++) {
      result.putIfAbsent(i, () => {});
      result[i]![col.name] = values[i];
    }
  }
  return result;
}
```

Column names may have namespace prefixes (e.g., `ds1.Image`). Strip with: `name.contains('.') ? name.split('.').last : name`

### Read projections from qtHash

```dart
final query = cubeTask.query;
final qtSchema = await factory.tableSchemaService.get(query.qtHash);
final nRows = qtSchema.nRows;

final qtData = await factory.tableSchemaService.select(
  query.qtHash, ['.y', '.ri', '.ci'], 0, nRows,  // add '.x' if needed
);

List ciValues = [], riValues = [];
List<double> yValues = [];
for (final col in qtData.columns) {
  switch (col.name) {
    case '.y': yValues = (col.values as List).map((v) => (v as num).toDouble()).toList();
    case '.ri': riValues = col.values as List;
    case '.ci': ciValues = col.values as List;
  }
}
```

### Three-table join

Combine projections with column and row metadata:

```dart
final colMetadata = await _readFactorTable(factory, query.columnHash);
final rowMetadata = await _readFactorTable(factory, query.rowHash);

for (int i = 0; i < nRows; i++) {
  final ci = (ciValues[i] as num).toInt();
  final ri = (riValues[i] as num).toInt();
  final y = yValues[i];
  final colMeta = colMetadata[ci]; // e.g. {Image: "img1", spotRow: 3}
  final rowMeta = rowMetadata[ri]; // e.g. {variable: "gridX"}
  // Build your domain model
}
```

---

## Step 4B: Flow B — file downloads

`.documentId` is filtered from the schema API. Extract it from the relation tree JSON.

### Navigate relation tree

```dart
String? _findDocumentId(CubeQueryTask cubeTask) {
  final taskJson = cubeTask.toJson();
  var rel = taskJson['query']['relation'] as Map?;

  for (int depth = 0; rel != null && depth < 20; depth++) {
    final kind = rel!['kind'] as String?;

    if (kind == 'InMemoryRelation' && rel['inMemoryTable'] != null) {
      for (final col in rel['inMemoryTable']['columns'] as List) {
        final name = col['name'] as String?;
        if (name == '.documentId' || (name != null && name.endsWith('..documentId'))) {
          return (col['values'] as List).first.toString();
        }
      }
      break;
    }

    if (rel['relation'] != null) {
      rel = rel['relation'] as Map?;
    } else if (kind == 'CompositeRelation' && rel['mainRelation'] != null) {
      rel = rel['mainRelation'] as Map?;
    } else {
      break;
    }
  }
  return null; // If null, try recursive search through joinOperators[].rightRelation
}
```

### SDK helper for alias resolution

```dart
import 'package:sci_tercen_client/sci_client.dart' show Relation;
final actualDocId = cubeTask.query.relation.findDocumentId(aliasValue);
```

### Download files

```dart
final stream = factory.fileService.download(documentId);
final chunks = <List<int>>[];
await for (final chunk in stream) { chunks.add(chunk); }
final bytes = Uint8List.fromList(chunks.expand((x) => x).toList());
```

ZIP files:

```dart
final entries = await factory.fileService.listZipContents(documentId);
final entryStream = factory.fileService.downloadZipEntry(documentId, entryPath);
```

Limit concurrent downloads to 3.

---

## Step 4D: Flow D — entity navigation

Flow D is for apps that browse, list, and navigate Tercen objects — **not** cross-tab projection data. These apps use `projectId` and `teamId` (not `taskId`) and call entity services directly.

### App lifecycle: always inside the orchestrator

All apps run as iframes inside the orchestrator — never standalone. The orchestrator is the only component that reads URL params and `--dart-define` values. It passes credentials and context to each app via `postMessage`.

**Lifecycle:**

1. Orchestrator loads the app iframe
2. App starts in a **waiting** state (shows loading spinner)
3. Orchestrator sends `init-context` message with token, teamId, projectId
4. App creates `ServiceFactory` with the received token
5. App registers services, loads data
6. App sends `app-ready` back to orchestrator

**Dev workflow:** Build the sub-apps (`flutter build web`), then run the orchestrator with `--dart-define` flags. The orchestrator passes those values to child apps via `init-context`.

```bash
# Build a sub-app
cd apps/project_nav && flutter build web --release

# Run orchestrator (which loads the built sub-apps)
cd apps/orchestrator
flutter run -d chrome --web-port 8080 \
  --dart-define=TERCEN_TOKEN=xxx \
  --dart-define=TEAM_ID=thiago_library \
  --dart-define=PROJECT_ID=abc123
```

**Mock mode:** `--dart-define=USE_MOCKS=true` on the sub-app build skips the postMessage wait and uses mock data directly.

### postMessage protocol

All inter-app messages use the same envelope — small JSON, one `type`, flat `payload`:

```json
{"type": "init-context", "source": "orchestrator", "target": "project-nav",
 "payload": {"token": "xxx", "teamId": "thiago_library", "projectId": "abc123"}}
```

```json
{"type": "app-ready", "source": "project-nav", "target": "orchestrator",
 "payload": {}}
```

```json
{"type": "step-selected", "source": "project-nav", "target": "*",
 "payload": {"projectId": "abc123", "workflowId": "wf1", "stepId": "s1"}}
```

**Envelope shape:**

| Field | Type | Description |
| ----- | ---- | ----------- |
| `type` | `String` | Message kind — the only field receivers switch on |
| `source` | `String` | Sender app ID (e.g., `"orchestrator"`, `"project-nav"`) |
| `target` | `String` | Receiver app ID, or `"*"` for broadcast |
| `payload` | `Map` | Flat key/value data specific to the message type |

### Listening for messages (receive)

```dart
import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:convert';

void _listenForMessages(void Function(String type, Map<String, dynamic> payload) onMessage) {
  web.window.addEventListener('message', (web.Event event) {
    final msgEvent = event as web.MessageEvent;
    final data = msgEvent.data;
    if (data == null) return;

    // Convert JS object to Dart map
    final jsonStr = web.window['JSON'].callMethod('stringify'.toJS, data) as JSString;
    final map = json.decode(jsonStr.toDart) as Map<String, dynamic>;

    final type = map['type'] as String?;
    final payload = map['payload'] as Map<String, dynamic>? ?? {};
    if (type != null) {
      onMessage(type, payload);
    }
  }.toJS);
}
```

### Sending messages (emit)

```dart
void _postToOrchestrator(String type, String sourceAppId, Map<String, dynamic> payload, {String target = 'orchestrator'}) {
  final message = {
    'type': type,
    'source': sourceAppId,
    'target': target,
    'payload': payload,
  };
  web.window.parent?.postMessage(message.jsify(), '*'.toJS);
}
```

### main.dart for Flow D

```dart
import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'package:sci_tercen_client/sci_service_factory_web.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const useMocks = bool.fromEnvironment('USE_MOCKS', defaultValue: false);

  if (useMocks) {
    setupServiceLocator(useMocks: true);
    final prefs = await SharedPreferences.getInstance();
    runApp(YourApp(prefs: prefs));
    return;
  }

  // Wait for init-context from orchestrator
  _listenForMessages((type, payload) async {
    if (type == 'init-context') {
      try {
        final token = payload['token'] as String;
        final teamId = payload['teamId'] as String;
        final projectId = payload['projectId'] as String?;

        final factory = await createServiceFactoryForWebApp(tercenToken: token);

        setupServiceLocator(
          useMocks: false,
          tercenFactory: factory,
          teamId: teamId,
          projectId: projectId,
        );

        final prefs = await SharedPreferences.getInstance();
        runApp(YourApp(prefs: prefs));

        _postToOrchestrator('app-ready', 'project-nav', {});
      } catch (e) {
        debugPrint('Tercen init failed: $e');
        runApp(_buildErrorApp('Initialization failed: $e'));
      }
    }
  });
}
```

### service_locator.dart for Flow D

```dart
void setupServiceLocator({
  bool useMocks = true,
  ServiceFactory? tercenFactory,
  String? projectId,
  String? teamId,
}) {
  if (serviceLocator.isRegistered<DataService>()) return;

  if (useMocks) {
    serviceLocator.registerLazySingleton<DataService>(() => MockDataService());
  } else {
    serviceLocator.registerSingleton<ServiceFactory>(tercenFactory!);
    serviceLocator.registerLazySingleton<DataService>(
      () => TercenDataService(
        tercenFactory,
        projectId: projectId,
        teamId: teamId!,
      ),
    );
  }
}
```

### Sending domain messages from providers

```dart
// In AppStateProvider — when user clicks a data step:
void selectStep(TreeNode step) {
  _selectedStepId = step.id;
  notifyListeners();

  _postToOrchestrator('step-selected', 'project-nav', {
    'projectId': _findAncestorId(step, TreeNodeType.project),
    'workflowId': _findAncestorId(step, TreeNodeType.workflow),
    'stepId': step.id,
  }, target: '*');
}
```

### The startKey/endKey pattern

Entity services use CouchDB-style range queries. **The method name encodes the key structure.**

```
findProjectByOwnerName(...)       → keys are [owner, name]
findFolderByParentFolderAndName(...)  → keys are [projectId, parentFolderId, name]
findProjectObjectsByFolderAndName(...)→ keys are [projectId, folderId, name]
findOperatorByUrlAndVersion(...)  → keys are [url, version]
findWorkflowByProjectIdFolder(...)→ keys are [projectId, folderId]
```

**How to read the method name:** `find<Entity>By<Key1><Key2>...<KeyN>` → `startKey: [key1, key2, ..., keyN]`, `endKey: [key1, key2, ..., keyN]`.

**Range conventions:**

| Want | startKey | endKey |
| ---- | -------- | ------ |
| All items matching a prefix | `[prefix, ""]` | `[prefix, "\uf000"]` |
| Descending (newest first) | `[prefix, "\ufff0"]` | `[prefix, ""]` |
| All items for a project/folder | `[projectId, folderId, ""]` | `[projectId, folderId, "\uf000"]` |

`"\uf000"` and `"\ufff0"` are Unicode high characters used as upper bounds. Use either — both work as "greater than any normal string."

### List projects for a team/user

`teamId` comes from the URL path (production) or `--dart-define=TEAM_ID` (dev). See "Dev vs Production mode" above.

```dart
// teamId = "thiago_library" (from URL path or --dart-define)
final projects = await factory.projectService.findProjectByOwnerNameStream(
  startKeyOwner: teamId,
  endKeyOwner: teamId,
  startKeyName: "",
  endKeyName: "\uf000",
).toList();
// Returns all projects owned by "thiago_library"
```

### List folders in a project

```dart
final folders = await factory.folderService.findFolderByParentFolderAndName(
  startKey: [projectId, parentFolderId, ""],
  endKey: [projectId, parentFolderId, "\uf000"],
);
```

### List documents (workflows, schemas, files) in a folder

```dart
// Workflows
final workflows = await factory.projectDocumentService
    .findWorkflowByProjectIdFolderStream(
      startKeyProjectId: projectId, endKeyProjectId: projectId,
      startKeyFolderId: folderId,   endKeyFolderId: folderId,
    ).toList();

// Schemas
final schemas = await factory.projectDocumentService
    .findSchemaByProjectIdFolderStream(
      startKeyProjectId: projectId, endKeyProjectId: projectId,
      startKeyFolderId: folderId,   endKeyFolderId: folderId,
    ).toList();

// File documents
final files = await factory.projectDocumentService
    .findFileDocumentByProjectIdFolderStream(
      startKeyProjectId: projectId, endKeyProjectId: projectId,
      startKeyFolderId: folderId,   endKeyFolderId: folderId,
    ).toList();
```

### Get a workflow and its steps

```dart
final workflow = await factory.workflowService.get(workflowId);
// workflow.steps is List<Step> — iterate to find DataStep instances
for (final step in workflow.steps) {
  if (step is DataStep) {
    // step.id, step.name, step.state, step.computedRelation
  }
}
```

### Get multiple workflows at once

```dart
final workflowList = await factory.workflowService.list(workflowIds);
```

### Access data from a workflow step (bridging Flow D → Flow A)

When a user selects a data step, you may need its output data:

```dart
final workflow = await factory.workflowService.get(workflowId);
final step = workflow.steps.firstWhere((s) => s.id == stepId) as DataStep;

// Get output schemas from the step's computed relation
final relations = _getSimpleRelations(step.computedRelation);
final schemaList = await factory.tableSchemaService.list(
  relations.map((r) => r.id).toList(),
);

// Select data from a specific schema
final targetSchema = schemaList.firstWhere((s) => s.name == "TargetTable");
final table = await factory.tableSchemaService.select(
  targetSchema.id,
  targetSchema.columns.map((c) => c.name).toList(),
  0,
  targetSchema.nRows,
);
```

### Helper: extract simple relations from nested structure

```dart
List<Relation> _getSimpleRelations(Relation relation) {
  final result = <Relation>[];
  void _walk(Relation? r) {
    if (r == null) return;
    if (r is SimpleRelation || r is ReferenceRelation) {
      result.add(r);
    } else if (r is JoinRelation) {
      _walk(r.left);
      _walk(r.right);
    } else if (r is WhereRelation || r is RenameRelation) {
      _walk(r.relation);
    } else if (r is CompositeRelation) {
      _walk(r.mainRelation);
      for (final j in r.joinOperators) {
        _walk(j.rightRelation);
      }
    }
  }
  _walk(relation);
  return result;
}
```

### Folder tree caching pattern (for navigation apps)

Load the full folder structure once, then navigate in memory:

```dart
class ProjectStructureCache {
  final ServiceFactory _factory;
  final String _projectId;
  List<FolderDocument>? _folders;
  List<ProjectDocument>? _documents;

  Future<void> load() async {
    _folders = await _fetchAllFolders(_projectId, "");
    _documents = await _fetchAllDocuments(_projectId, "");
  }

  Future<List<FolderDocument>> _fetchAllFolders(String projectId, String parentId) async {
    final folders = await _factory.folderService.findFolderByParentFolderAndName(
      startKey: [projectId, parentId, ""],
      endKey: [projectId, parentId, "\uf000"],
    );
    final children = <FolderDocument>[];
    for (final folder in folders) {
      children.addAll(await _fetchAllFolders(projectId, folder.id));
    }
    return [...folders, ...children];
  }

  Future<List<ProjectDocument>> _fetchAllDocuments(String projectId, String folderId) async {
    return await _factory.projectDocumentService
        .findProjectObjectsByFolderAndName(
          startKey: [projectId, folderId, ""],
          endKey: [projectId, folderId, "\uf000"],
        );
  }
}
```

### Diagnostic report for Flow D

```dart
Future<void> _printFlowDDiagnostic(ServiceFactory factory, String projectId) async {
  print('=== TERCEN DIAGNOSTIC REPORT (Flow D) ===');
  print('ProjectId: $projectId');

  try {
    final project = await factory.projectService.get(projectId);
    print('Project: ${project.name} (owner: ${project.acl.owner})');
  } catch (e) { print('Project fetch ERROR: $e'); }

  try {
    final folders = await factory.folderService.findFolderByParentFolderAndName(
      startKey: [projectId, "", ""], endKey: [projectId, "", "\uf000"],
    );
    print('Root folders: ${folders.length}');
    for (final f in folders) { print('  - ${f.name} (${f.id})'); }
  } catch (e) { print('Folder list ERROR: $e'); }

  print('=== END REPORT ===');
}
```

---

## Step 5: Real service

```dart
class TercenDataService implements DataService {
  final ServiceFactory _factory;
  final String? _taskId;
  final MockDataService _mockService;

  TercenDataService(this._factory, {String? taskId})
      : _taskId = taskId, _mockService = MockDataService();

  @override
  Future<List<YourModel>> loadData() async {
    try {
      if (_taskId == null || _taskId!.isEmpty) return _mockService.loadData();
      final cubeTask = await navigateToCubeQueryTask(_factory, _taskId!);
      final data = await _extractData(cubeTask);
      if (data.isEmpty) return _mockService.loadData();
      return data;
    } catch (e) {
      debugPrint('Tercen error: $e');
      await _printDiagnosticReport(_factory, cubeTask);
      return _mockService.loadData();
    }
  }
}
```

---

## Step 6: Build and deploy

```bash
flutter build web --wasm
git add build/web/ && git commit -m "Update web build" && git push
```

The skeleton `.gitignore` already preserves `build/web/`.

### Required files

index.html line 17 must stay commented: `<!--<base href="$FLUTTER_BASE_HREF"> -->`

operator.json must have:

```json
{"name": "Your Operator", "isWebApp": true, "serve": "build/web", "urls": ["https://github.com/tercen/your-repo"]}
```

Hot reload is broken for Tercen web apps. Always stop and restart with `flutter run -d chrome --web-port 8080`.

---

## Diagnostic report

Add this to every real service. Call it when data loading fails. Present the output to the user — do NOT try to fix the problem by adding code.

```dart
Future<void> _printDiagnosticReport(ServiceFactory factory, CubeQueryTask cubeTask) async {
  final q = cubeTask.query;
  print('=== TERCEN DIAGNOSTIC REPORT ===');
  print('Task: ${cubeTask.id} (${cubeTask.runtimeType})');
  for (final entry in {'qtHash': q.qtHash, 'columnHash': q.columnHash, 'rowHash': q.rowHash}.entries) {
    print('\n--- ${entry.key}: ${entry.value} ---');
    if (entry.value.isNotEmpty) {
      try {
        final s = await factory.tableSchemaService.get(entry.value);
        print('Rows: ${s.nRows}, Columns: ${s.columns.map((c) => c.name).join(', ')}');
      } catch (e) { print('ERROR: $e'); }
    } else { print('EMPTY'); }
  }
  print('\n--- relation tree ---');
  _printRel(cubeTask.toJson()['query']?['relation'] as Map?, 0, 3);
  print('=== END REPORT ===');
}

void _printRel(Map? r, int d, int max) {
  if (r == null || d >= max) return;
  final pad = '  ' * d;
  print('$pad${r['kind']}');
  if (r['kind'] == 'CompositeRelation') {
    _printRel(r['mainRelation'] as Map?, d + 1, max);
    for (final j in (r['joinOperators'] as List? ?? [])) {
      _printRel((j as Map)['rightRelation'] as Map?, d + 1, max);
    }
  } else if (r['relation'] != null) { _printRel(r['relation'] as Map?, d + 1, max); }
}
```

### Known patterns

| Pattern | Source | Method |
| ------- | ------ | ------ |
| Projections (.x, .y, .ri, .ci) | `query.qtHash` | `tableSchemaService.select()` |
| Column metadata | `query.columnHash` | `tableSchemaService.select()` |
| Row metadata | `query.rowHash` | `tableSchemaService.select()` |
| Three-table join | qtHash + columnHash + rowHash | Join by `.ci` and `.ri` |
| File document IDs | `query.relation` JSON | Navigate to InMemoryTable -> `.documentId` |
| Entity listing | Entity services | `findXxxByYyyStream(startKey, endKey)` |
| Credentials | Orchestrator postMessage | `init-context` → `createServiceFactoryForWebApp(tercenToken:)` |
| Inter-app events | postMessage | Envelope: `{type, source, target, payload}` |

If data doesn't match these patterns, report it. `SimpleRelation` in the tree is normal — it's a reference, not data.

---

## API reference

### CubeQuery fields (Flows A/B/C)

| `query` field | Contains |
| ------------- | -------- |
| `qtHash` | Cross-tab output table |
| `columnHash` | Column factor table (indexed by .ci) |
| `rowHash` | Row factor table (indexed by .ri) |
| `relation` | Input data relation tree |

| Constant | Value |
| -------- | ----- |
| `Relation.DocumentId` | `'.documentId'` |
| `Relation.DocumentIdAlias` | `'documentId'` |
| `relation.findDocumentId(alias)` | Resolves alias -> .documentId |

### OperatorContext (high-level — `sci_tercen_context`)

For cross-tab operator apps, `OperatorContext` wraps the three-hash pattern into a clean API. Add to pubspec.yaml:

```yaml
sci_tercen_context:
  git:
    url: https://github.com/tercen/sci_tercen_client
    ref: 1.13.0
    path: sci_tercen_context
sci_tercen_client:
  git:
    url: https://github.com/tercen/sci_tercen_client
    ref: 1.13.0
    path: sci_tercen_client
```

**Create context:**

```dart
import 'package:sci_tercen_context/sci_tercen_context.dart';

final ctx = await OperatorContext.create(
  serviceFactory: factory,
  taskId: taskId,
);
```

**Read data:**

| Method | Equivalent raw call | Returns |
| ------ | ------------------- | ------- |
| `ctx.select(names: ['.y', '.ci', '.ri'])` | `tableSchemaService.select(qtHash, ...)` | `Table` — main cross-tab data |
| `ctx.cselect()` | `tableSchemaService.select(columnHash, ...)` | `Table` — column annotations |
| `ctx.rselect()` | `tableSchemaService.select(rowHash, ...)` | `Table` — row annotations |
| `ctx.schema` | `tableSchemaService.get(qtHash)` | `Future<Schema>` — qtHash schema |
| `ctx.cschema` | `tableSchemaService.get(columnHash)` | `Future<Schema>` — column schema |
| `ctx.rschema` | `tableSchemaService.get(rowHash)` | `Future<Schema>` — row schema |
| `ctx.colors` | — | `Future<List<String>>` — color factor names |
| `ctx.namespace` | — | `Future<String>` — current namespace |

**Read operator properties:**

```dart
final stringVal = await ctx.opStringValue('Property Name', defaultValue: 'No');
final doubleVal = await ctx.opDoubleValue('Number of Items', defaultValue: 5);
```

**Save results:**

```dart
final nsMap = await ctx.addNamespace(['col1', 'col2']);
final table = Table()..nRows = nRows;
table.columns.add(AbstractOperatorContext.makeInt32Column('.ci', ciValues));
table.columns.add(AbstractOperatorContext.makeInt32Column('.ri', riValues));
table.columns.add(AbstractOperatorContext.makeFloat64Column(nsMap['col1']!, data));
await ctx.saveTable(table);
```

**Progress updates:**

```dart
await ctx.progress('Loading data...', actual: 0, total: 5);
```

### ServiceFactory — complete service catalog

`ServiceFactory` exposes **24 services**. Every service has base CRUD methods plus domain-specific finders.

**Base CRUD (all services):**

| Method | Signature | Returns |
| ------ | --------- | ------- |
| `get` | `get(String id)` | `Future<T>` |
| `list` | `list(List<String> ids)` | `Future<List<T>>` |
| `create` | `create(T object)` | `Future<T>` |
| `update` | `update(T object)` | `Future<String>` (rev) |
| `delete` | `delete(String id, String rev)` | `Future` |

**Finder methods use startKey/endKey.** The method name encodes the key order — see "The startKey/endKey pattern" in Step 4D.

---

**ProjectService** — `factory.projectService`

| Method | Keys | Returns |
| ------ | ---- | ------- |
| `findProjectByOwnerNameStream(startKeyOwner, endKeyOwner, startKeyName, endKeyName)` | `[owner, name]` | `Stream<Project>` |
| `findProjectByOwnerCreatedDateStream(startKeyOwner, endKeyOwner, startKeyCreatedDate, endKeyCreatedDate)` | `[owner, createdDate]` | `Stream<Project>` |

---

**WorkflowService** — `factory.workflowService`

| Method | Returns | Notes |
| ------ | ------- | ----- |
| `get(id)` | `Workflow` | `.steps` contains `List<Step>` (cast to `DataStep`, etc.) |
| `list(ids)` | `List<Workflow>` | Batch fetch |
| `copyApp(workflowId, projectId)` | `Workflow` | Copy workflow into a project |
| `create(workflow)` | `Workflow` | |
| `update(workflow)` | `String` (rev) | |

---

**ProjectDocumentService** — `factory.projectDocumentService`

| Method | Keys | Returns |
| ------ | ---- | ------- |
| `findWorkflowByProjectIdFolderStream(startKeyProjectId, endKeyProjectId, startKeyFolderId, endKeyFolderId)` | `[projectId, folderId]` | `Stream<Workflow>` |
| `findSchemaByProjectIdFolderStream(...)` | `[projectId, folderId]` | `Stream<Schema>` |
| `findFileDocumentByProjectIdFolderStream(...)` | `[projectId, folderId]` | `Stream<FileDocument>` |
| `findProjectObjectsByFolderAndName(startKey, endKey)` | `[projectId, folderId, name]` | `List<ProjectDocument>` |
| `findProjectDocumentByProjectIdOwnerStream(...)` | `[projectId, owner]` | `Stream<ProjectDocument>` |
| `findProjectDocumentByProjectIdCreatedDateStream(...)` | `[projectId, createdDate]` | `Stream<ProjectDocument>` |
| `findProjectDocumentByProjectIdLastModifiedDateStream(...)` | `[projectId, lastModifiedDate]` | `Stream<ProjectDocument>` |

---

**FolderService** — `factory.folderService`

| Method | Keys | Returns |
| ------ | ---- | ------- |
| `findFolderByParentFolderAndName(startKey, endKey)` | `[projectId, parentFolderId, name]` | `List<FolderDocument>` |

---

**DocumentService** — `factory.documentService`

| Method | Keys | Returns |
| ------ | ---- | ------- |
| `findOperatorByUrlAndVersion(startKey, endKey)` | `[url, version]` | `List<Operator>` |
| `findOperatorByOwnerLastModifiedDateStream(...)` | `[owner, lastModifiedDate]` | `Stream<Operator>` |

---

**TaskService** — `factory.taskService`

| Method | Returns | Notes |
| ------ | ------- | ----- |
| `get(id)` | `Task` | Cast to `CubeQueryTask`, `RunWebAppTask`, `RunComputationTask`, etc. |
| `create(task)` | `Task` | Submit computation |
| `getTasks(kinds)` | `List<Task>` | Filter by task kind |

Task types: `CubeQueryTask`, `RunWebAppTask`, `RunComputationTask`, `SaveComputationResultTask`, `RunWorkflowTask`, `ExportTableTask` (18 total).

`CubeQueryTask` has: `.query` (CubeQuery with qtHash/columnHash/rowHash/relation), `.schemaIds`.
`RunWebAppTask` has: `.operatorId`, `.cubeQueryTaskId`, `.url`.

---

**TableSchemaService** — `factory.tableSchemaService`

| Method | Signature | Returns |
| ------ | --------- | ------- |
| `get` | `get(String hash)` | `TableSchema` (.columns, .nRows) |
| `list` | `list(List<String> ids)` | `List<TableSchema>` |
| `select` | `select(String hash, List<String> columnNames, int offset, int limit)` | `InMemoryTable` (.columns[].name, .columns[].values) |
| `getFileMimetypeStream` | `getFileMimetypeStream(String schemaId, String filename)` | `Stream<List<int>>` — file content from schema |
| `findSchemaByDataDirectoryStream` | `(startKeyDataDirectory, endKeyDataDirectory)` | `Stream<Schema>` |

---

**FileService** — `factory.fileService`

| Method | Signature | Returns |
| ------ | --------- | ------- |
| `download` | `download(String documentId)` | `Stream<List<int>>` |
| `listZipContents` | `listZipContents(String documentId)` | `List<ZipEntry>` |
| `downloadZipEntry` | `downloadZipEntry(String documentId, String entryPath)` | `Stream<List<int>>` |
| `create` | `create(FileDocument doc)` | `FileDocument` |
| `findByDataUriStream` | `(startKeyDataUri, endKeyDataUri)` | `Stream<FileDocument>` |

---

**EventService** — `factory.eventService`

| Method | Returns | Notes |
| ------ | ------- | ----- |
| `listenTaskChannel(String taskId, bool startTask)` | `Stream<TaskEvent>` | Real-time task progress. `TaskProgressEvent` has `.message`. |

---

**UserService** — `factory.userService`

| Property | Returns |
| -------- | ------- |
| `session` | Current user session (`.user.name`, `.user.id`) |

---

**UserSecretService** — `factory.userSecretService`

| Method | Returns | Notes |
| ------ | ------- | ----- |
| `getGoogleAccessToken()` | `String?` | External service credentials |

---

**TeamService** — `factory.teamService`

Base CRUD + team-specific finders.

---

**Other services** (less commonly used): `ActivityService`, `CranLibraryService`, `GarbageCollectorService`, `LockService`, `OperatorService`, `PatchRecordService`, `PersistentService`, `QueryService`, `SubscriptionPlanService`, `WorkerService`.

### Key data models

| Model | Key fields |
| ----- | ---------- |
| `Project` | `.id`, `.name`, `.acl.owner` |
| `Workflow` | `.id`, `.name`, `.projectId`, `.steps` (List\<Step\>), `.links` |
| `DataStep` | `.id`, `.name`, `.computedRelation`, `.state`, `.parentDataStepId` |
| `CubeQuery` | `.qtHash`, `.columnHash`, `.rowHash`, `.relation`, `.colColumns`, `.rowColumns`, `.axisQueries`, `.filters` |
| `TableSchema` | `.id`, `.nRows`, `.columns` (List\<Column\> with `.name`, `.type`) |
| `InMemoryTable` | `.columns` (List\<Column\> with `.name`, `.values`) |
| `FileDocument` | `.id`, `.name`, `.dataUri`, `.size`, `.projectId` |
| `FolderDocument` | `.id`, `.name`, `.projectId` |
| `Operator` | `.id`, `.name`, `.properties`, `.operatorSpec` — subtypes: `ShinyOperator`, `DockerWebAppOperator`, `WebAppOperator`, `GitOperator` |

---

## Checklist

### All flows

- [ ] `createServiceFactoryForWebApp()` in main.dart with try/catch
- [ ] `<ServiceFactory>` explicit type on GetIt registration
- [ ] Data flow matches functional spec Section 2.2
- [ ] Real service falls back to mock on error
- [ ] Diagnostic report function included in every real service
- [ ] `flutter build web --wasm` succeeds
- [ ] `build/web/` committed
- [ ] operator.json correct
- [ ] index.html line 17 commented
- [ ] No `dart:html` or `http` package API calls
- [ ] Mock mode works (`--dart-define=USE_MOCKS=true`)

### Flows A/B/C specific

- [ ] taskId from `Uri.base.queryParameters['taskId']`
- [ ] Task navigation handles RunWebAppTask and CubeQueryTask

### Flow D specific

- [ ] App waits for `init-context` postMessage before initializing (no standalone credential resolution)
- [ ] `createServiceFactoryForWebApp(tercenToken: token)` uses token from `init-context` payload
- [ ] teamId and projectId extracted from `init-context` payload
- [ ] `app-ready` message sent to orchestrator after successful init
- [ ] Domain messages (e.g., `step-selected`) sent via `_postToOrchestrator()` with correct envelope
- [ ] Mock mode (`--dart-define=USE_MOCKS=true`) skips postMessage wait and uses mock data
- [ ] startKey/endKey range queries return expected data
- [ ] Entity service finder methods match the key order from the method name

---

## Mock removal

When Phase 3 is complete and the real service is working, **remove all mock code**:

1. Delete `lib/implementations/services/mock_data_service.dart`
2. Remove `USE_MOCKS` flag and mock branches from `main.dart`
3. Remove mock branches from `service_locator.dart` — make real service params required
4. The app runs only with real Tercen data via `init-context` from the orchestrator

Mock data exists only during Phase 2 as scaffolding. Once the real service replaces it, the mock is deleted — not kept as a fallback.

---

## Files created/modified

| File | Action |
| ---- | ------ |
| `lib/implementations/services/tercen_*_service.dart` | Create |
| `lib/implementations/services/mock_*_service.dart` | Delete |
| `lib/utils/*_resolver.dart` | Create |
| `lib/di/service_locator.dart` | Modify |
| `lib/main.dart` | Modify |
| `pubspec.yaml` | Verify SDK ref is latest |
