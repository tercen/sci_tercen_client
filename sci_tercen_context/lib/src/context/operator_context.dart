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

  /// The [CubeQueryTask] resolved from the fetched task. Used by [save]
  /// to link `fileResultId` to the correct task.
  CubeQueryTask? _cubeQueryTask;

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

    ctx._cubeQueryTask = cubeQueryTask;

    if (fetchedTask is CubeQueryTask && fetchedTask is! RunWebAppTask) {
      print('WARNING: Task is a direct CubeQueryTask (not wrapped in '
          'RunWebAppTask). If this is a web app operator that saves results, '
          'ensure operator.json includes "isViewOnly": false and '
          '"entryType": "app".');
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

    final cqt = _cubeQueryTask;

    // Check for existing fileResultId (only on ComputationTask subclass).
    if (cqt is ComputationTask && cqt.fileResultId.isNotEmpty) {
      // Re-upload to existing result file.
      final existingFile =
          await serviceFactory.fileService.get(cqt.fileResultId);
      await uploadResultFile(result,
          existingFile: existingFile, projectId: projectId, owner: owner);
    } else {
      // New result: upload file, link fileResultId to the task, run.
      final fileDoc =
          await uploadResultFile(result, projectId: projectId, owner: owner);

      if (cqt is ComputationTask) {
        // ComputationTask has a native fileResultId field.
        cqt.fileResultId = fileDoc.id;
        cqt.rev = await serviceFactory.taskService.update(cqt);
      } else if (cqt != null) {
        // CubeQueryTask: the Dart model lacks fileResultId, but the Tercen
        // server accepts it (R operators set it dynamically). Use a wrapper
        // that injects fileResultId into the serialized JSON.
        final wrapper = _CubeQueryTaskWithFileResult.from(cqt, fileDoc.id);
        wrapper.rev = await serviceFactory.taskService.update(wrapper);
        cqt.rev = wrapper.rev;
      }

      // Only update t separately if it's a different object (e.g. RunWebAppTask
      // with a resolved CubeQueryTask). When t and cqt are the same object,
      // updating t again would overwrite the fileResultId we just set.
      if (!identical(t, cqt)) {
        t.rev = await serviceFactory.taskService.update(t);
      }
      await serviceFactory.taskService.runTask(t.id);
      task = await serviceFactory.taskService.waitDone(t.id);

      if (task!.state is FailedState) {
        throw StateError('Task failed: ${(task!.state as FailedState).reason}');
      }
    }
  }
}

/// A [CubeQueryTask] wrapper that injects `fileResultId` into [toJson].
///
/// The Tercen server accepts `fileResultId` on CubeQueryTask (proved by R
/// operators which set it dynamically). The Dart model doesn't expose this
/// field on [CubeQueryTask] — it only exists on [ComputationTask]. This
/// wrapper bridges the gap by overriding [toJson] to include the field,
/// preserving the original KIND and all other fields.
class _CubeQueryTaskWithFileResult extends CubeQueryTask {
  final String _fileResultId;

  _CubeQueryTaskWithFileResult.from(CubeQueryTask source, this._fileResultId)
      : super.json(source.toJson());

  @override
  Map toJson() {
    final m = super.toJson();
    m['fileResultId'] = _fileResultId;
    return m;
  }
}
