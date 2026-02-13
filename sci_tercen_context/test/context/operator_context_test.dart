import 'package:test/test.dart';
import 'package:sci_tercen_context/sci_tercen_context.dart';
import '../mocks/mock_service_factory.dart';

void main() {
  late MockServiceFactory mockFactory;
  late CubeQuery testQuery;

  setUp(() {
    mockFactory = MockServiceFactory();

    final mainSchema = makeSchema('qt-hash', [
      makeColumnSchema('.y', 'double'),
      makeColumnSchema('value', 'string'),
    ]);
    final colSchema = makeSchema('col-hash', [
      makeColumnSchema('colFactor', 'string'),
    ]);
    final rowSchema = makeSchema('row-hash', [
      makeColumnSchema('rowFactor', 'string'),
    ]);

    testQuery = makeCubeQuery(
      qtHash: 'qt-hash',
      columnHash: 'col-hash',
      rowHash: 'row-hash',
    );

    mockFactory.tableSchemaService.addSchema('qt-hash', mainSchema);
    mockFactory.tableSchemaService.addSchema('col-hash', colSchema);
    mockFactory.tableSchemaService.addSchema('row-hash', rowSchema);
  });

  group('OperatorContext', () {
    test('creates from CubeQueryTask', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final q = await ctx.query;
      expect(q.qtHash, 'qt-hash');
      expect(ctx.taskId, 'task-1');
    });

    test('creates from RunWebAppTask via cubeQueryTaskId', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'cqt-1';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('cqt-1', cqt);

      final webTask = RunWebAppTask();
      webTask.id = 'web-1';
      webTask.cubeQueryTaskId = 'cqt-1';
      mockFactory.taskService.addTask('web-1', webTask);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'web-1',
      );

      final q = await ctx.query;
      expect(q.qtHash, 'qt-hash');
      expect(ctx.task, isA<RunWebAppTask>());
    });

    test('throws when task type is unsupported', () async {
      // A plain Task (not CubeQueryTask or RunWebAppTask)
      final task = Task();
      task.id = 'plain-1';
      mockFactory.taskService.addTask('plain-1', task);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'plain-1',
      );

      expect(() => ctx.query, throwsA(isA<StateError>()));
    });

    test('data selection works after creation', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-2';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-2', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-2',
      );

      final names = await ctx.names;
      expect(names, ['.y', 'value']);
    });
  });
}
