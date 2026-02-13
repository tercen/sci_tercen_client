import 'package:test/test.dart';
import 'package:sci_tercen_context/sci_tercen_context.dart';
import '../mocks/mock_service_factory.dart';

void main() {
  late MockServiceFactory mockFactory;
  late CubeQuery testQuery;

  setUp(() {
    mockFactory = MockServiceFactory();

    testQuery = makeCubeQuery();
    mockFactory.tableSchemaService
        .addSchema('qt-hash', makeSchema('qt-hash', []));
    mockFactory.tableSchemaService
        .addSchema('col-hash', makeSchema('col-hash', []));
    mockFactory.tableSchemaService
        .addSchema('row-hash', makeSchema('row-hash', []));
  });

  group('requestResources()', () {
    test('sends cpu pair when nCpus provided', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final result = await ctx.requestResources(nCpus: 4);

      expect(mockFactory.workerService.updateTaskEnvCalls, hasLength(1));
      final call = mockFactory.workerService.updateTaskEnvCalls.first;
      expect(call.taskId, 'task-1');
      expect(call.env, hasLength(1));
      expect(call.env.first.key, 'cpu');
      expect(call.env.first.value, '4');
      expect(result, hasLength(1));
    });

    test('sends ram pair when ram provided', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      await ctx.requestResources(ram: '8G');

      final call = mockFactory.workerService.updateTaskEnvCalls.first;
      expect(call.env, hasLength(1));
      expect(call.env.first.key, 'ram');
      expect(call.env.first.value, '8G');
    });

    test('sends multiple pairs when multiple resources requested', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      await ctx.requestResources(nCpus: 2, ram: '4G', ramPerCpu: '2G');

      final call = mockFactory.workerService.updateTaskEnvCalls.first;
      expect(call.env, hasLength(3));
      final keys = call.env.map((p) => p.key).toList();
      expect(keys, containsAll(['cpu', 'ram', 'ram_per_cpu']));
    });

    test('returns empty list when task is null', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );
      mockFactory.workflowService.addCubeQuery('wf1', 'step1', testQuery);

      final result = await ctx.requestResources(nCpus: 4);

      expect(result, isEmpty);
      expect(mockFactory.workerService.updateTaskEnvCalls, isEmpty);
    });
  });
}
