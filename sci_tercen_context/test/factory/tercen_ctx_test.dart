import 'package:test/test.dart';
import 'package:sci_tercen_context/sci_tercen_context.dart';
import '../mocks/mock_service_factory.dart';

void main() {
  late MockServiceFactory mockFactory;

  setUp(() {
    mockFactory = MockServiceFactory();

    final testQuery = makeCubeQuery();
    final mainSchema = makeSchema('qt-hash', []);
    final colSchema = makeSchema('col-hash', []);
    final rowSchema = makeSchema('row-hash', []);

    mockFactory.tableSchemaService.addSchema('qt-hash', mainSchema);
    mockFactory.tableSchemaService.addSchema('col-hash', colSchema);
    mockFactory.tableSchemaService.addSchema('row-hash', rowSchema);
    mockFactory.workflowService.addCubeQuery('wf1', 'step1', testQuery);

    final cqt = CubeQueryTask();
    cqt.id = 'task-1';
    cqt.query = testQuery;
    mockFactory.taskService.addTask('task-1', cqt);
  });

  group('tercenCtx', () {
    test('returns OperatorContextDev when workflowId+stepId provided',
        () async {
      final ctx = await tercenCtx(
        serviceFactory: mockFactory,
        workflowId: 'wf1',
        stepId: 'step1',
      );

      expect(ctx, isA<OperatorContextDev>());
    });

    test('returns OperatorContext when taskId provided', () async {
      final ctx = await tercenCtx(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      expect(ctx, isA<OperatorContext>());
    });

    test('throws when neither workflowId nor taskId provided', () {
      expect(
        () => tercenCtx(serviceFactory: mockFactory),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws when workflowId provided without stepId', () {
      expect(
        () => tercenCtx(
          serviceFactory: mockFactory,
          workflowId: 'wf1',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
