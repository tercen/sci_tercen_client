import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart';

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
}
