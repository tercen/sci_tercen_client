import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart';

import '../helpers/async_lazy.dart';
import 'abstract_operator_context.dart';

/// Development mode operator context.
///
/// Initialized with [workflowId] + [stepId]. Fetches the CubeQuery via
/// `workflowService.getCubeQuery()`.
///
/// Mirrors R's `OperatorContextDev` from teRcen.
class OperatorContextDev extends AbstractOperatorContext {
  final String workflowId;
  final String stepId;

  late final AsyncLazy<CubeQuery> _query;
  late final AsyncLazy<Workflow> _workflow;

  OperatorContextDev({
    required ServiceFactoryBase serviceFactory,
    required this.workflowId,
    required this.stepId,
    Task? task,
  }) : super(serviceFactory: serviceFactory) {
    super.task = task;
    _query = AsyncLazy(() async {
      if (task is CubeQueryTask) {
        return task.query;
      }
      return serviceFactory.workflowService.getCubeQuery(workflowId, stepId);
    });
    _workflow = AsyncLazy(() => serviceFactory.workflowService.get(workflowId));
  }

  @override
  Future<CubeQuery> get query => _query.value;

  /// The workflow object (lazy-cached).
  Future<Workflow> get workflow => _workflow.value;

  @override
  Future<void> save(OperatorResult result) async {
    final wf = await workflow;
    final projectId = wf.projectId;
    final owner = wf.acl.owner;

    final fileDoc =
        await uploadResultFile(result, projectId: projectId, owner: owner);

    if (task == null) {
      // No task yet — create a ComputationTask.
      final newTask = ComputationTask();
      newTask.state = InitState();
      newTask.owner = owner;
      newTask.projectId = projectId;
      newTask.query = await query;
      newTask.fileResultId = fileDoc.id;
      task = await serviceFactory.taskService.create(newTask);
    } else {
      if (task is ComputationTask) {
        (task as ComputationTask).fileResultId = fileDoc.id;
      }
      task!.rev = await serviceFactory.taskService.update(task!);
    }

    await serviceFactory.taskService.runTask(task!.id);
    task = await serviceFactory.taskService.waitDone(task!.id);

    if (task!.state is FailedState) {
      throw StateError('Task failed: ${(task!.state as FailedState).reason}');
    }
  }
}
