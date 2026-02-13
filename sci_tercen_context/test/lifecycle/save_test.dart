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

  group('OperatorContext.save() (production)', () {
    test('uploads result, updates task, runs and waits (empty fileResultId)',
        () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final result = OperatorResult();
      result.tables.add(Table());

      await ctx.save(result);

      // File was uploaded
      expect(mockFactory.fileService.uploadCalls, hasLength(1));
      final uploadedFile = mockFactory.fileService.uploadCalls.first;
      expect(uploadedFile.name, 'result');
      expect(uploadedFile.projectId, 'proj-1');
      expect(uploadedFile.acl.owner, 'user-1');

      // Task was updated
      expect(mockFactory.taskService.updateCalls, hasLength(1));

      // Task was run and waited
      expect(mockFactory.taskService.runTaskCalls, hasLength(1));
      expect(mockFactory.taskService.waitDoneCalls, hasLength(1));
    });

    test('re-uploads to existing file when fileResultId is set', () async {
      final ct = ComputationTask();
      ct.id = 'task-2';
      ct.rev = '1';
      ct.query = testQuery;
      ct.projectId = 'proj-1';
      ct.owner = 'user-1';
      ct.fileResultId = 'existing-file';
      mockFactory.taskService.addTask('task-2', ct);

      // Add the existing file to the mock
      final existingFile = FileDocument();
      existingFile.id = 'existing-file';
      mockFactory.fileService.addFile('existing-file', existingFile);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-2',
      );

      await ctx.save(OperatorResult());

      // File was uploaded (re-upload to existing)
      expect(mockFactory.fileService.uploadCalls, hasLength(1));

      // Task was NOT updated/run/waited (re-upload path)
      expect(mockFactory.taskService.updateCalls, isEmpty);
      expect(mockFactory.taskService.runTaskCalls, isEmpty);
    });

    test('throws StateError when task is null', () async {
      // OperatorContextDev without a task set, but we make it abstract enough
      // to test the production context scenario by creating one
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      // Manually clear the task to simulate edge case
      ctx.task = null;

      expect(
        () => ctx.save(OperatorResult()),
        throwsA(isA<StateError>()),
      );
    });

    test('throws StateError when task finishes in FailedState', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-fail';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-fail', cqt);

      // Configure waitDone to return a failed task
      final failedTask = CubeQueryTask();
      failedTask.id = 'task-fail';
      final fs = FailedState();
      fs.reason = 'computation error';
      failedTask.state = fs;
      mockFactory.taskService.waitDoneResult = failedTask;

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-fail',
      );

      expect(
        () => ctx.save(OperatorResult()),
        throwsA(isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('computation error'),
        )),
      );
    });
  });

  group('OperatorContextDev.save() (dev mode)', () {
    test('creates ComputationTask when task is null', () async {
      final wf = Workflow();
      wf.id = 'wf1';
      wf.projectId = 'proj-1';
      wf.acl.owner = 'user-1';
      mockFactory.workflowService.addWorkflow('wf1', wf);
      mockFactory.workflowService.addCubeQuery('wf1', 'step1', testQuery);

      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      await ctx.save(OperatorResult());

      // Task was created
      expect(mockFactory.taskService.createCalls, hasLength(1));
      final created = mockFactory.taskService.createCalls.first;
      expect(created, isA<ComputationTask>());
      expect((created as ComputationTask).fileResultId, isNotEmpty);
      expect(created.projectId, 'proj-1');
      expect(created.owner, 'user-1');

      // Task was run and waited
      expect(mockFactory.taskService.runTaskCalls, hasLength(1));
      expect(mockFactory.taskService.waitDoneCalls, hasLength(1));
    });

    test('updates existing task when task is already set', () async {
      final wf = Workflow();
      wf.id = 'wf1';
      wf.projectId = 'proj-1';
      wf.acl.owner = 'user-1';
      mockFactory.workflowService.addWorkflow('wf1', wf);
      mockFactory.workflowService.addCubeQuery('wf1', 'step1', testQuery);

      final existingTask = ComputationTask();
      existingTask.id = 'existing-task';
      existingTask.rev = '1';
      existingTask.query = testQuery;
      mockFactory.taskService.addTask('existing-task', existingTask);

      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
        task: existingTask,
      );

      await ctx.save(OperatorResult());

      // Task was NOT created (existing task used)
      expect(mockFactory.taskService.createCalls, isEmpty);

      // Task was updated
      expect(mockFactory.taskService.updateCalls, hasLength(1));

      // Task was run and waited
      expect(mockFactory.taskService.runTaskCalls, hasLength(1));
      expect(mockFactory.taskService.waitDoneCalls, hasLength(1));
    });
  });

  group('saveTable()', () {
    test('wraps single table in OperatorResult and saves', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      await ctx.saveTable(Table());

      expect(mockFactory.fileService.uploadCalls, hasLength(1));
    });
  });

  group('saveTables()', () {
    test('wraps multiple tables in OperatorResult and saves', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      await ctx.saveTables([Table(), Table(), Table()]);

      expect(mockFactory.fileService.uploadCalls, hasLength(1));
    });
  });

  group('saveRelation()', () {
    test('wraps join operators in OperatorResult and saves', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      await ctx.saveRelation([JoinOperator()]);

      expect(mockFactory.fileService.uploadCalls, hasLength(1));
    });
  });
}
