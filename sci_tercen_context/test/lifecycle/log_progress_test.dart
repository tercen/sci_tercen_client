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

  group('log()', () {
    test('sends TaskLogEvent to task channelId', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.channelId = 'channel-1';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      await ctx.log('hello world');

      expect(mockFactory.eventService.sentEvents, hasLength(1));
      final sent = mockFactory.eventService.sentEvents.first;
      expect(sent.channel, 'channel-1');
      expect(sent.event, isA<TaskLogEvent>());
      final evt = sent.event as TaskLogEvent;
      expect(evt.message, 'hello world');
      expect(evt.taskId, 'task-1');
    });

    test('is no-op when task is null', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );
      mockFactory.workflowService.addCubeQuery('wf1', 'step1', testQuery);

      await ctx.log('should not send');

      expect(mockFactory.eventService.sentEvents, isEmpty);
    });

    test('is no-op when channelId is empty', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-2';
      cqt.channelId = '';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-2', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-2',
      );

      await ctx.log('should not send');

      expect(mockFactory.eventService.sentEvents, isEmpty);
    });
  });

  group('progress()', () {
    test('sends TaskProgressEvent to task channelId', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.channelId = 'channel-1';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      await ctx.progress('Processing...', actual: 50, total: 100);

      expect(mockFactory.eventService.sentEvents, hasLength(1));
      final sent = mockFactory.eventService.sentEvents.first;
      expect(sent.channel, 'channel-1');
      expect(sent.event, isA<TaskProgressEvent>());
      final evt = sent.event as TaskProgressEvent;
      expect(evt.message, 'Processing...');
      expect(evt.actual, 50);
      expect(evt.total, 100);
      expect(evt.taskId, 'task-1');
    });

    test('is no-op when task is null', () async {
      final ctx = OperatorContextDev(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );
      mockFactory.workflowService.addCubeQuery('wf1', 'step1', testQuery);

      await ctx.progress('nope', actual: 1, total: 10);

      expect(mockFactory.eventService.sentEvents, isEmpty);
    });

    test('sends multiple progress events', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.channelId = 'ch-1';
      cqt.query = testQuery;
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      await ctx.progress('Step 1', actual: 0, total: 3);
      await ctx.progress('Step 2', actual: 1, total: 3);
      await ctx.progress('Step 3', actual: 2, total: 3);

      expect(mockFactory.eventService.sentEvents, hasLength(3));
    });
  });
}
