import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart';

import '../helpers/async_lazy.dart';
import 'abstract_operator_context.dart';

/// Production mode operator context.
///
/// Created from a [taskId]. The CubeQuery is obtained from the task.
///
/// Handles task hierarchy: if the fetched task is a [RunWebAppTask],
/// it navigates to the associated [CubeQueryTask] via [cubeQueryTaskId].
///
/// Mirrors R's `OperatorContext` from teRcen.
class OperatorContext extends AbstractOperatorContext {
  late final AsyncLazy<CubeQuery> _query;

  OperatorContext._({required super.serviceFactory});

  /// Creates an [OperatorContext] by fetching the task with [taskId].
  static Future<OperatorContext> create({
    required ServiceFactoryBase serviceFactory,
    required String taskId,
  }) async {
    final ctx = OperatorContext._(serviceFactory: serviceFactory);

    final fetchedTask = await serviceFactory.taskService.get(taskId);
    ctx.task = fetchedTask;

    CubeQueryTask? cubeQueryTask;
    if (fetchedTask is CubeQueryTask) {
      cubeQueryTask = fetchedTask;
    } else if (fetchedTask is RunWebAppTask) {
      if (fetchedTask.cubeQueryTaskId.isNotEmpty) {
        final resolved =
            await serviceFactory.taskService.get(fetchedTask.cubeQueryTaskId);
        if (resolved is CubeQueryTask) {
          cubeQueryTask = resolved;
        }
      }
    }

    ctx._query = AsyncLazy(() async {
      if (cubeQueryTask != null) {
        return cubeQueryTask.query;
      }
      throw StateError(
        'Cannot resolve CubeQuery from task type: ${fetchedTask.runtimeType}',
      );
    });

    return ctx;
  }

  @override
  Future<CubeQuery> get query => _query.value;

  @override
  Future<void> save(OperatorResult result) async {
    final t = task;
    if (t == null) {
      throw StateError('Cannot save: no task associated with context');
    }

    // Get projectId and owner from the task.
    // All supported task types (CubeQueryTask, RunWebAppTask) extend ProjectTask.
    final projectId = t is ProjectTask ? t.projectId : '';
    final owner = t.owner;

    if (t is ComputationTask && t.fileResultId.isNotEmpty) {
      // Re-upload to existing result file.
      final existingFile = await serviceFactory.fileService.get(t.fileResultId);
      await uploadResultFile(result,
          existingFile: existingFile, projectId: projectId, owner: owner);
    } else {
      // Web app scenario: create new file, link to task, run computation.
      final fileDoc =
          await uploadResultFile(result, projectId: projectId, owner: owner);

      if (t is ComputationTask) {
        t.fileResultId = fileDoc.id;
      }
      t.rev = await serviceFactory.taskService.update(t);
      await serviceFactory.taskService.runTask(t.id);
      task = await serviceFactory.taskService.waitDone(t.id);

      if (task!.state is FailedState) {
        throw StateError('Task failed: ${(task!.state as FailedState).reason}');
      }
    }
  }
}
