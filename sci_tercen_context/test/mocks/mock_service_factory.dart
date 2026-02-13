import 'package:sci_tercen_client/sci_client.dart' hide ServiceFactory;
import 'package:sci_tercen_client/sci_client_service_factory.dart' as svc;
import 'package:sci_base/sci_service.dart' as api;

// ============================================================
// Mock TableSchemaService
// ============================================================
class MockTableSchemaService implements svc.TableSchemaService {
  final Map<String, Schema> _schemas = {};
  final Map<String, Table> _tables = {};
  final Map<String, Table> _pairwiseTables = {};

  void addSchema(String id, Schema schema) => _schemas[id] = schema;
  void addTable(String id, Table table) => _tables[id] = table;
  void addPairwiseTable(String id, Table table) => _pairwiseTables[id] = table;

  @override
  Future<Schema> get(String id,
      {bool useFactory = true, api.AclContext? aclContext}) async {
    final schema = _schemas[id];
    if (schema == null) throw Exception('Schema not found: $id');
    return schema;
  }

  @override
  Future<Table> select(
      String tableId, List<String> cnames, int offset, int limit,
      {api.AclContext? aclContext}) async {
    return _tables[tableId] ?? Table();
  }

  @override
  Future<Table> selectPairwise(
      String tableId, List<String> cnames, int offset, int limit,
      {api.AclContext? aclContext}) async {
    return _pairwiseTables[tableId] ?? Table();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

// ============================================================
// Mock WorkflowService
// ============================================================
class MockWorkflowService implements svc.WorkflowService {
  final Map<String, CubeQuery> _cubeQueries = {};
  final Map<String, Workflow> _workflows = {};

  void addCubeQuery(String workflowId, String stepId, CubeQuery query) {
    _cubeQueries['$workflowId:$stepId'] = query;
  }

  void addWorkflow(String id, Workflow workflow) => _workflows[id] = workflow;

  @override
  Future<CubeQuery> getCubeQuery(String workflowId, String stepId,
      {api.AclContext? aclContext}) async {
    final key = '$workflowId:$stepId';
    final q = _cubeQueries[key];
    if (q == null) throw Exception('CubeQuery not found: $key');
    return q;
  }

  @override
  Future<Workflow> get(String id,
      {bool useFactory = true, api.AclContext? aclContext}) async {
    final wf = _workflows[id];
    if (wf == null) throw Exception('Workflow not found: $id');
    return wf;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

// ============================================================
// Mock TaskService
// ============================================================
class MockTaskService implements svc.TaskService {
  final Map<String, Task> _tasks = {};
  final List<String> runTaskCalls = [];
  final List<String> waitDoneCalls = [];
  final List<Task> updateCalls = [];
  final List<Task> createCalls = [];
  int _idCounter = 0;

  /// Task returned by waitDone (override to simulate failure).
  Task? waitDoneResult;

  void addTask(String id, Task task) => _tasks[id] = task;

  @override
  Future<Task> get(String id,
      {bool useFactory = true, api.AclContext? aclContext}) async {
    final task = _tasks[id];
    if (task == null) throw Exception('Task not found: $id');
    return task;
  }

  @override
  Future<Task> create(Task object, {api.AclContext? aclContext}) async {
    createCalls.add(object);
    object.id = 'created-${_idCounter++}';
    object.rev = '1';
    _tasks[object.id] = object;
    return object;
  }

  @override
  Future<String> update(Task object, {api.AclContext? aclContext}) async {
    updateCalls.add(object);
    final newRev = '${int.parse(object.rev.isEmpty ? '0' : object.rev) + 1}';
    object.rev = newRev;
    return newRev;
  }

  @override
  Future<dynamic> runTask(String taskId, {api.AclContext? aclContext}) async {
    runTaskCalls.add(taskId);
  }

  @override
  Future<Task> waitDone(String taskId, {api.AclContext? aclContext}) async {
    waitDoneCalls.add(taskId);
    if (waitDoneResult != null) return waitDoneResult!;
    final task = _tasks[taskId];
    if (task != null) {
      task.state = DoneState();
      return task;
    }
    final done = Task();
    done.id = taskId;
    done.state = DoneState();
    return done;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

// ============================================================
// Mock EventService
// ============================================================
class MockEventService implements svc.EventService {
  final List<({String channel, Event event})> sentEvents = [];

  @override
  Future<dynamic> sendChannel(String channel, Event evt,
      {api.AclContext? aclContext}) async {
    sentEvents.add((channel: channel, event: evt));
  }

  @override
  Future<dynamic> sendPersistentChannel(String channel, Event evt,
      {api.AclContext? aclContext}) async {
    sentEvents.add((channel: channel, event: evt));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

// ============================================================
// Mock FileService
// ============================================================
class MockFileService implements svc.FileService {
  final Map<String, FileDocument> _files = {};
  final List<FileDocument> uploadCalls = [];
  int _idCounter = 0;

  void addFile(String id, FileDocument file) => _files[id] = file;

  @override
  Future<FileDocument> upload(FileDocument file, Stream<List> bytes,
      {api.AclContext? aclContext}) async {
    // Consume the stream
    await bytes.toList();
    uploadCalls.add(file);
    if (file.id.isEmpty) {
      file.id = 'file-${_idCounter++}';
    }
    _files[file.id] = file;
    return file;
  }

  @override
  Future<FileDocument> get(String id,
      {bool useFactory = true, api.AclContext? aclContext}) async {
    final file = _files[id];
    if (file == null) throw Exception('File not found: $id');
    return file;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

// ============================================================
// Mock WorkerService
// ============================================================
class MockWorkerService implements svc.WorkerService {
  final List<({String taskId, List<Pair> env})> updateTaskEnvCalls = [];

  @override
  Future<List<Pair>> updateTaskEnv(String taskId, List<Pair> env,
      {api.AclContext? aclContext}) async {
    updateTaskEnvCalls.add((taskId: taskId, env: env));
    return env;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

// ============================================================
// Mock ServiceFactory
// ============================================================
class MockServiceFactory implements svc.ServiceFactoryBase {
  @override
  final MockTableSchemaService tableSchemaService;
  @override
  final MockWorkflowService workflowService;
  @override
  final MockTaskService taskService;
  @override
  final MockEventService eventService;
  @override
  final MockFileService fileService;
  @override
  final MockWorkerService workerService;

  MockServiceFactory()
      : tableSchemaService = MockTableSchemaService(),
        workflowService = MockWorkflowService(),
        taskService = MockTaskService(),
        eventService = MockEventService(),
        fileService = MockFileService(),
        workerService = MockWorkerService();

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

// ============================================================
// Test helpers for building model objects
// ============================================================

/// Creates a ColumnSchema with the given name and type.
ColumnSchema makeColumnSchema(String name, String type) {
  var cs = ColumnSchema();
  cs.name = name;
  cs.type = type;
  return cs;
}

/// Creates a Schema with given id and columns.
Schema makeSchema(String id, List<ColumnSchema> columns, {int nRows = 100}) {
  var s = Schema();
  s.id = id;
  s.nRows = nRows;
  for (final c in columns) {
    s.columns.add(c);
  }
  return s;
}

/// Creates a Factor with the given name.
Factor makeFactor(String name, {String type = ''}) {
  var f = Factor();
  f.name = name;
  f.type = type;
  return f;
}

/// Creates a PropertyValue with name and value.
PropertyValue makePropertyValue(String name, String value) {
  var pv = PropertyValue();
  pv.name = name;
  pv.value = value;
  return pv;
}

/// Creates a CubeQuery with the given hashes and optional axis queries.
CubeQuery makeCubeQuery({
  String qtHash = 'qt-hash',
  String columnHash = 'col-hash',
  String rowHash = 'row-hash',
  String namespace = 'ns',
  List<CubeAxisQuery>? axisQueries,
  List<PropertyValue>? propertyValues,
}) {
  var q = CubeQuery();
  q.qtHash = qtHash;
  q.columnHash = columnHash;
  q.rowHash = rowHash;
  q.operatorSettings.namespace = namespace;
  if (axisQueries != null) {
    for (final aq in axisQueries) {
      q.axisQueries.add(aq);
    }
  }
  if (propertyValues != null) {
    for (final pv in propertyValues) {
      q.operatorSettings.operatorRef.propertyValues.add(pv);
    }
  }
  return q;
}

/// Creates a CubeAxisQuery with optional factors.
CubeAxisQuery makeAxisQuery({
  String xAxisName = '',
  String yAxisName = '',
  List<Factor>? colors,
  List<Factor>? labels,
  List<Factor>? errors,
  String chartType = '',
  int pointSize = 0,
}) {
  var aq = CubeAxisQuery();
  if (xAxisName.isNotEmpty) aq.xAxis = makeFactor(xAxisName);
  if (yAxisName.isNotEmpty) aq.yAxis = makeFactor(yAxisName);
  if (colors != null) {
    for (final c in colors) {
      aq.colors.add(c);
    }
  }
  if (labels != null) {
    for (final l in labels) {
      aq.labels.add(l);
    }
  }
  if (errors != null) {
    for (final e in errors) {
      aq.errors.add(e);
    }
  }
  aq.chartType = chartType;
  aq.pointSize = pointSize;
  return aq;
}
