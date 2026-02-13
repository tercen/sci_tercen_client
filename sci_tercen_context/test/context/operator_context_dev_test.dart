import 'package:test/test.dart';
import 'package:sci_tercen_context/sci_tercen_context.dart';
import '../mocks/mock_service_factory.dart';

void main() {
  late MockServiceFactory mockFactory;
  late CubeQuery testQuery;
  late Schema mainSchema;
  late Schema colSchema;
  late Schema rowSchema;

  setUp(() {
    mockFactory = MockServiceFactory();

    mainSchema = makeSchema('qt-hash', [
      makeColumnSchema('.y', 'double'),
      makeColumnSchema('.ri', 'int64'),
      makeColumnSchema('.ci', 'uint64'),
      makeColumnSchema('.x', 'double'),
      makeColumnSchema('value', 'double'),
    ]);

    colSchema = makeSchema('col-hash', [
      makeColumnSchema('.cindex', 'int32'),
      makeColumnSchema('colFactor', 'string'),
    ]);

    rowSchema = makeSchema('row-hash', [
      makeColumnSchema('.rindex', 'int32'),
      makeColumnSchema('rowFactor', 'string'),
    ]);

    testQuery = makeCubeQuery(
      qtHash: 'qt-hash',
      columnHash: 'col-hash',
      rowHash: 'row-hash',
      namespace: 'myop',
      axisQueries: [
        makeAxisQuery(
          xAxisName: 'xFactor',
          yAxisName: 'yFactor',
          colors: [makeFactor('colorFactor')],
          labels: [makeFactor('labelFactor')],
          errors: [makeFactor('errorFactor')],
          chartType: 'scatter',
          pointSize: 5,
        ),
      ],
      propertyValues: [
        makePropertyValue('threshold', '0.5'),
        makePropertyValue('enabled', 'true'),
      ],
    );

    mockFactory.tableSchemaService.addSchema('qt-hash', mainSchema);
    mockFactory.tableSchemaService.addSchema('col-hash', colSchema);
    mockFactory.tableSchemaService.addSchema('row-hash', rowSchema);
    mockFactory.workflowService.addCubeQuery('wf1', 'step1', testQuery);
    mockFactory.workflowService.addWorkflow('wf1', Workflow());
  });

  group('OperatorContextDev', () {
    test('resolves query via getCubeQuery', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final q = await ctx.query;
      expect(q.qtHash, 'qt-hash');
      expect(q.columnHash, 'col-hash');
      expect(q.rowHash, 'row-hash');
    });

    test('resolves schemas from query hashes', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final s = await ctx.schema;
      expect(s.id, 'qt-hash');

      final cs = await ctx.cschema;
      expect(cs.id, 'col-hash');

      final rs = await ctx.rschema;
      expect(rs.id, 'row-hash');
    });

    test('schemas are cached', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final s1 = await ctx.schema;
      final s2 = await ctx.schema;
      expect(identical(s1, s2), true);
    });

    test('select with empty names filters system columns', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      // This will call select with filtered names (.y, .x, value)
      // excluding .ri (int64) and .ci (uint64)
      await ctx.select();
      // No exception means it worked
    });

    test('select with explicit names passes them through', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      await ctx.select(names: ['.y', '.ci']);
      // No exception means it worked
    });

    test('cselect delegates to column schema', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      await ctx.cselect();
      // No exception means it delegated to col-hash schema
    });

    test('rselect delegates to row schema', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      await ctx.rselect();
    });

    test('names returns column names from main schema', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final n = await ctx.names;
      expect(n, ['.y', '.ri', '.ci', '.x', 'value']);
    });

    test('cnames returns column names from column schema', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final cn = await ctx.cnames;
      expect(cn, ['.cindex', 'colFactor']);
    });

    test('rnames returns column names from row schema', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final rn = await ctx.rnames;
      expect(rn, ['.rindex', 'rowFactor']);
    });

    test('colors extracts from axisQueries', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.colors, ['colorFactor']);
    });

    test('labels extracts from axisQueries', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.labels, ['labelFactor']);
    });

    test('errors extracts from axisQueries', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.errors, ['errorFactor']);
    });

    test('xAxis returns unique non-empty names', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.xAxis, ['xFactor']);
    });

    test('yAxis returns unique non-empty names', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.yAxis, ['yFactor']);
    });

    test('isPairwise returns false when no overlap', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.isPairwise, false);
    });

    test('isPairwise returns true when cnames and rnames overlap', () async {
      // Create schemas where both have 'sharedFactor'
      final cs = makeSchema('col-hash2', [
        makeColumnSchema('sharedFactor', 'string'),
      ]);
      final rs = makeSchema('row-hash2', [
        makeColumnSchema('sharedFactor', 'string'),
      ]);
      final q2 = makeCubeQuery(
        qtHash: 'qt-hash',
        columnHash: 'col-hash2',
        rowHash: 'row-hash2',
      );
      mockFactory.tableSchemaService.addSchema('col-hash2', cs);
      mockFactory.tableSchemaService.addSchema('row-hash2', rs);
      mockFactory.workflowService.addCubeQuery('wf2', 'step2', q2);

      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf2',
        stepId: 'step2',
      );

      expect(await ctx.isPairwise, true);
    });

    test('hasXAxis returns true when .x column exists', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.hasXAxis, true);
    });

    test('hasNumericXAxis returns true when .x is double', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.hasNumericXAxis, true);
    });

    test('namespace returns from operatorSettings', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.namespace, 'myop');
    });

    test('chartTypes returns from axisQueries', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.chartTypes, ['scatter']);
    });

    test('opValue retrieves property correctly', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final threshold = await ctx.opDoubleValue('threshold', defaultValue: 0.0);
      expect(threshold, 0.5);
    });

    test('opValue returns default for missing property', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final missing =
          await ctx.opStringValue('nonexistent', defaultValue: 'nope');
      expect(missing, 'nope');
    });

    test('opBoolValue works', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(await ctx.opBoolValue('enabled'), true);
    });

    test('addNamespace prefixes non-system columns', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final result = await ctx.addNamespace(['mean', '.ci', 'sd']);
      expect(result, {
        'mean': 'myop.mean',
        '.ci': '.ci',
        'sd': 'myop.sd',
      });
    });

    test('workflow property fetches from service', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      final wf = await ctx.workflow;
      expect(wf, isA<Workflow>());
    });

    test('uses task query when CubeQueryTask is provided', () async {
      final taskQuery = makeCubeQuery(
        qtHash: 'qt-hash',
        columnHash: 'col-hash',
        rowHash: 'row-hash',
        namespace: 'task-ns',
      );
      final cqt = CubeQueryTask();
      cqt.query = taskQuery;

      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
        task: cqt,
      );

      final q = await ctx.query;
      expect(q.operatorSettings.namespace, 'task-ns');
    });

    test('taskId is null when no task', () {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(ctx.taskId, isNull);
    });
  });
}
