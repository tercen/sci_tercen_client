import 'dart:typed_data';

import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart';
import 'package:tson/string_list.dart';
import 'package:tson/tson.dart' as tson;

import '../helpers/async_lazy.dart';
import '../helpers/column_filter.dart';
import '../helpers/operator_property.dart';

/// Abstract operator context providing R/Python-style data access to Tercen.
///
/// Mirrors R's `AbstractOperatorContext` from the teRcen package.
/// Provides lazy-cached schema resolution, data selection (select, cselect,
/// rselect), metadata properties, and operator settings access.
///
/// Subclasses must implement [query] to provide the CubeQuery, either from
/// a task (production mode) or via workflowService (dev mode).
abstract class AbstractOperatorContext {
  /// The ServiceFactory providing access to all Tercen services.
  final ServiceFactoryBase serviceFactory;

  /// The task associated with this context (may be null in dev mode).
  Task? task;

  late final AsyncLazy<Schema> _schema;
  late final AsyncLazy<Schema> _cschema;
  late final AsyncLazy<Schema> _rschema;

  AbstractOperatorContext({required this.serviceFactory}) {
    _schema = AsyncLazy(() async {
      final q = await query;
      return serviceFactory.tableSchemaService.get(q.qtHash);
    });
    _cschema = AsyncLazy(() async {
      final q = await query;
      return serviceFactory.tableSchemaService.get(q.columnHash);
    });
    _rschema = AsyncLazy(() async {
      final q = await query;
      return serviceFactory.tableSchemaService.get(q.rowHash);
    });
  }

  // ============================================================
  // Abstract: Subclasses must provide the query
  // ============================================================

  /// The CubeQuery for this context.
  Future<CubeQuery> get query;

  // ============================================================
  // Schema access (lazy-cached)
  // ============================================================

  /// Main table schema, resolved from [CubeQuery.qtHash].
  Future<Schema> get schema => _schema.value;

  /// Column dimension schema, resolved from [CubeQuery.columnHash].
  Future<Schema> get cschema => _cschema.value;

  /// Row dimension schema, resolved from [CubeQuery.rowHash].
  Future<Schema> get rschema => _rschema.value;

  // ============================================================
  // Data selection
  // ============================================================

  /// Select columns from the main data table.
  ///
  /// When [names] is empty, selects all non-system columns
  /// (filters out int64/uint64 types, matching R behavior).
  Future<Table> select({
    List<String> names = const [],
    int offset = 0,
    int limit = -1,
  }) async {
    final s = await schema;
    return _selectFromSchema(s, names: names, offset: offset, limit: limit);
  }

  /// Select columns from the column dimension table.
  Future<Table> cselect({
    List<String> names = const [],
    int offset = 0,
    int limit = -1,
  }) async {
    final s = await cschema;
    return _selectFromSchema(s, names: names, offset: offset, limit: limit);
  }

  /// Select columns from the row dimension table.
  Future<Table> rselect({
    List<String> names = const [],
    int offset = 0,
    int limit = -1,
  }) async {
    final s = await rschema;
    return _selectFromSchema(s, names: names, offset: offset, limit: limit);
  }

  /// Select pairwise data from the main schema.
  Future<Table> selectPairwise({
    List<String> names = const [],
    int offset = 0,
    int limit = -1,
  }) async {
    final s = await schema;
    var cnames = names;
    if (cnames.isEmpty) {
      cnames = filterSelectableColumnNames(s.columns.toList());
    }
    final effectiveLimit = limit < 0 ? s.nRows : limit;
    return serviceFactory.tableSchemaService
        .selectPairwise(s.id, cnames, offset, effectiveLimit);
  }

  Future<Table> _selectFromSchema(
    Schema schema, {
    List<String> names = const [],
    int offset = 0,
    int limit = -1,
  }) {
    var cnames = names;
    if (cnames.isEmpty) {
      cnames = filterSelectableColumnNames(schema.columns.toList());
    }
    final effectiveLimit = limit < 0 ? schema.nRows : limit;
    return serviceFactory.tableSchemaService
        .select(schema.id, cnames, offset, effectiveLimit);
  }

  // ============================================================
  // Metadata properties
  // ============================================================

  /// Column names from the main schema.
  Future<List<String>> get names async {
    final s = await schema;
    return s.columns.map((c) => c.name).toList();
  }

  /// Column names from the column dimension schema.
  Future<List<String>> get cnames async {
    final s = await cschema;
    return s.columns.map((c) => c.name).toList();
  }

  /// Column names from the row dimension schema.
  Future<List<String>> get rnames async {
    final s = await rschema;
    return s.columns.map((c) => c.name).toList();
  }

  /// Color factor names from all axis queries.
  Future<List<String>> get colors async {
    final q = await query;
    return q.axisQueries.expand((aq) => aq.colors).map((f) => f.name).toList();
  }

  /// Label factor names from all axis queries.
  Future<List<String>> get labels async {
    final q = await query;
    return q.axisQueries.expand((aq) => aq.labels).map((f) => f.name).toList();
  }

  /// Error factor names from all axis queries.
  Future<List<String>> get errors async {
    final q = await query;
    return q.axisQueries.expand((aq) => aq.errors).map((f) => f.name).toList();
  }

  /// X-axis factor names (unique, non-empty).
  Future<List<String>> get xAxis async {
    final q = await query;
    return q.axisQueries
        .map((aq) => aq.xAxis.name)
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList();
  }

  /// Y-axis factor names (unique, non-empty).
  Future<List<String>> get yAxis async {
    final q = await query;
    return q.axisQueries
        .map((aq) => aq.yAxis.name)
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList();
  }

  /// Whether column names and row names overlap (pairwise/scatter mode).
  Future<bool> get isPairwise async {
    final cn = (await cnames).where((n) => n.isNotEmpty).toSet();
    final rn = (await rnames).where((n) => n.isNotEmpty).toSet();
    return cn.intersection(rn).isNotEmpty;
  }

  /// Whether the main schema has a `.x` column.
  Future<bool> get hasXAxis async {
    final s = await schema;
    return s.columns.any((c) => c.name == '.x');
  }

  /// Whether the main schema has a `.x` column of type `double`.
  Future<bool> get hasNumericXAxis async {
    final s = await schema;
    for (final c in s.columns) {
      if (c.name == '.x') return c.type == 'double';
    }
    return false;
  }

  /// Chart types from axis queries.
  Future<List<String>> get chartTypes async {
    final q = await query;
    return q.axisQueries.map((aq) => aq.chartType).toList();
  }

  /// Point sizes from axis queries.
  Future<List<int>> get pointSizes async {
    final q = await query;
    return q.axisQueries.map((aq) => aq.pointSize).toList();
  }

  /// The operator namespace from operatorSettings.
  Future<String> get namespace async {
    final q = await query;
    return q.operatorSettings.namespace;
  }

  // ============================================================
  // Operator settings access
  // ============================================================

  /// Retrieve an operator property value by name.
  ///
  /// Mirrors R's `op.value(name, type, default)`.
  Future<T> opValue<T>({
    required String name,
    required T Function(String) converter,
    required T defaultValue,
  }) async {
    final q = await query;
    return getOperatorPropertyValue<T>(
      q.operatorSettings.operatorRef.propertyValues.toList(),
      name: name,
      converter: converter,
      defaultValue: defaultValue,
    );
  }

  /// Get a string operator property.
  Future<String> opStringValue(String name, {String defaultValue = ''}) =>
      opValue(name: name, converter: (s) => s, defaultValue: defaultValue);

  /// Get a double operator property.
  Future<double> opDoubleValue(String name, {double defaultValue = 0.0}) =>
      opValue(name: name, converter: double.parse, defaultValue: defaultValue);

  /// Get an int operator property.
  Future<int> opIntValue(String name, {int defaultValue = 0}) =>
      opValue(name: name, converter: int.parse, defaultValue: defaultValue);

  /// Get a bool operator property.
  Future<bool> opBoolValue(String name, {bool defaultValue = false}) => opValue(
        name: name,
        converter: (s) => s.toLowerCase() == 'true',
        defaultValue: defaultValue,
      );

  // ============================================================
  // Namespace helper
  // ============================================================

  /// Add namespace prefix to column names for result output.
  ///
  /// Columns starting with `.` are left unchanged (system columns).
  Future<Map<String, String>> addNamespace(List<String> columnNames) async {
    final ns = await namespace;
    return {
      for (final name in columnNames)
        name: name.startsWith('.') ? name : '$ns.$name',
    };
  }

  /// The task ID, or null if no task is set.
  String? get taskId => task?.id;

  // ============================================================
  // Task lifecycle: log and progress
  // ============================================================

  /// Log a message to the task's event channel.
  ///
  /// Mirrors R's `ctx$log(message)`. No-op if no task is set.
  Future<void> log(String message) async {
    final t = task;
    if (t == null || t.channelId.isEmpty) return;
    final evt = TaskLogEvent();
    evt.taskId = t.id;
    evt.message = message;
    await serviceFactory.eventService.sendChannel(t.channelId, evt);
  }

  /// Report progress to the task's event channel.
  ///
  /// Mirrors R's `ctx$progress(message, actual, total)`. No-op if no task is set.
  Future<void> progress(String message,
      {required int actual, required int total}) async {
    final t = task;
    if (t == null || t.channelId.isEmpty) return;
    final evt = TaskProgressEvent();
    evt.taskId = t.id;
    evt.message = message;
    evt.actual = actual;
    evt.total = total;
    await serviceFactory.eventService.sendChannel(t.channelId, evt);
  }

  // ============================================================
  // Task lifecycle: save
  // ============================================================

  /// Save an [OperatorResult] back to Tercen.
  ///
  /// Subclasses implement mode-specific upload and task lifecycle logic.
  /// Use [saveTable] or [saveTables] for convenience.
  Future<void> save(OperatorResult result);

  /// Save a single [Table] as an operator result.
  Future<void> saveTable(Table table) async {
    final result = OperatorResult();
    result.tables.add(table);
    return save(result);
  }

  /// Save multiple [Table]s as an operator result.
  Future<void> saveTables(List<Table> tables) async {
    final result = OperatorResult();
    for (final t in tables) {
      result.tables.add(t);
    }
    return save(result);
  }

  /// Save [JoinOperator]s with associated tables as an operator result.
  ///
  /// Mirrors R's `ctx$save_relation()`.
  Future<void> saveRelation(List<JoinOperator> joinOperators) async {
    final result = OperatorResult();
    for (final jop in joinOperators) {
      result.joinOperators.add(jop);
    }
    return save(result);
  }

  /// Serialize an [OperatorResult] to TSON and upload via fileService.
  ///
  /// If [existingFile] is provided, re-uploads to that file.
  /// Otherwise creates a new [FileDocument].
  ///
  /// Automatically normalizes column values to ensure correct TSON
  /// binary type markers (Int32List, Float64List, CStringList).
  Future<FileDocument> uploadResultFile(
    OperatorResult result, {
    FileDocument? existingFile,
    required String projectId,
    required String owner,
  }) async {
    _normalizeColumnValues(result);
    final bytes = tson.encode(result.toJson()) as List<int>;
    final stream = Stream.fromIterable([bytes]);

    if (existingFile != null) {
      return serviceFactory.fileService.upload(existingFile, stream);
    }

    final fileDoc = FileDocument();
    fileDoc.name = 'result';
    fileDoc.projectId = projectId;
    fileDoc.acl.owner = owner;
    fileDoc.metadata.contentType = 'application/octet-stream';
    return serviceFactory.fileService.upload(fileDoc, stream);
  }

  // ============================================================
  // Resource management
  // ============================================================

  /// Request compute resources (CPU, RAM) for the current task.
  ///
  /// Mirrors R's `ctx$requestResources(nCpus, ram, ram_per_cpu)`.
  /// Returns the updated environment pairs, or empty list if no task is set.
  Future<List<Pair>> requestResources(
      {int? nCpus, String? ram, String? ramPerCpu}) async {
    final t = task;
    if (t == null) return [];

    final env = <Pair>[];
    if (nCpus != null) {
      final p = Pair();
      p.key = 'cpu';
      p.value = nCpus.toString();
      env.add(p);
    }
    if (ram != null) {
      final p = Pair();
      p.key = 'ram';
      p.value = ram;
      env.add(p);
    }
    if (ramPerCpu != null) {
      final p = Pair();
      p.key = 'ram_per_cpu';
      p.value = ramPerCpu;
      env.add(p);
    }

    return serviceFactory.workerService.updateTaskEnv(t.id, env);
  }

  // ============================================================
  // TSON normalization
  // ============================================================

  /// Normalize every [Column] in the result for correct TSON serialization.
  ///
  /// Performs three normalizations:
  /// 1. **TypedData**: Sets [Column.values] to the correct binary type
  ///    ([Int32List], [Float64List], [CStringList]) from [Column.cValues].
  /// 2. **Column type**: Infers [ColumnSchema.type] from [Column.cValues]
  ///    when it is empty (e.g. `I32Values` → `"int32"`).
  /// 3. **Row count**: Sets [ColumnSchema.nRows] from the data length, and
  ///    sets [Table.nRows] from the first column if unset.
  ///
  /// Without these, the TSON encoder produces wrong binary markers and the
  /// Tercen pipeline cannot register output columns as available factors.
  void _normalizeColumnValues(OperatorResult result) {
    for (final table in result.tables) {
      for (final col in table.columns) {
        final cv = col.cValues;
        if (cv is I32Values) {
          final data = cv.values.toList();
          col.values = Int32List.fromList(data);
          if (col.type.isEmpty) col.type = 'int32';
          if (col.nRows == 0) col.nRows = data.length;
        } else if (cv is F64Values) {
          final data = cv.values.toList();
          col.values = Float64List.fromList(data);
          if (col.type.isEmpty) col.type = 'double';
          if (col.nRows == 0) col.nRows = data.length;
        } else if (cv is StrValues) {
          final data = cv.values.toList();
          col.values = CStringList.fromList(data);
          if (col.type.isEmpty) col.type = 'string';
          if (col.nRows == 0) col.nRows = data.length;
        }
      }
      // Set table.nRows from first column if unset.
      if (table.nRows == 0 && table.columns.isNotEmpty) {
        table.nRows = table.columns.first.nRows;
      }
    }
  }

  // ============================================================
  // Table-building helpers
  // ============================================================

  /// Create a [Column] with int32 values, correctly wired for TSON.
  ///
  /// Sets [Column.values] (Int32List), [Column.cValues] (I32Values),
  /// [ColumnSchema.type] (`"int32"`), and [ColumnSchema.nRows].
  static Column makeInt32Column(String name, List<int> data) {
    final col = Column();
    col.name = name;
    col.type = 'int32';
    col.nRows = data.length;
    col.values = Int32List.fromList(data);
    final vals = I32Values();
    vals.values.addAll(data);
    col.cValues = vals;
    return col;
  }

  /// Create a [Column] with float64 values, correctly wired for TSON.
  ///
  /// Sets [Column.values] (Float64List), [Column.cValues] (F64Values),
  /// [ColumnSchema.type] (`"double"`), and [ColumnSchema.nRows].
  static Column makeFloat64Column(String name, List<double> data) {
    final col = Column();
    col.name = name;
    col.type = 'double';
    col.nRows = data.length;
    col.values = Float64List.fromList(data);
    final vals = F64Values();
    vals.values.addAll(data);
    col.cValues = vals;
    return col;
  }

  /// Create a [Column] with string values, correctly wired for TSON.
  ///
  /// Sets [Column.values] (CStringList), [Column.cValues] (StrValues),
  /// [ColumnSchema.type] (`"string"`), and [ColumnSchema.nRows].
  static Column makeStringColumn(String name, List<String> data) {
    final col = Column();
    col.name = name;
    col.type = 'string';
    col.nRows = data.length;
    col.values = CStringList.fromList(data);
    final vals = StrValues();
    vals.values.addAll(data);
    col.cValues = vals;
    return col;
  }
}
