import 'package:sci_tercen_client/sci_client_service_factory.dart';

import '../context/abstract_operator_context.dart';
import '../context/operator_context.dart';
import '../context/operator_context_dev.dart';

/// Creates a Tercen operator context.
///
/// Mirrors R's `tercenCtx()` factory function.
///
/// **Dev mode** (workflowId + stepId):
/// ```dart
/// final ctx = await tercenCtx(
///   serviceFactory: factory,
///   workflowId: 'wf123',
///   stepId: 'step456',
/// );
/// ```
///
/// **Production mode** (taskId):
/// ```dart
/// final ctx = await tercenCtx(
///   serviceFactory: factory,
///   taskId: 'task789',
/// );
/// ```
Future<AbstractOperatorContext> tercenCtx({
  required ServiceFactoryBase serviceFactory,
  String? workflowId,
  String? stepId,
  String? taskId,
}) async {
  if (workflowId != null) {
    if (stepId == null) {
      throw ArgumentError('stepId is required when workflowId is provided');
    }
    return OperatorContextDev(
      serviceFactory: serviceFactory,
      workflowId: workflowId,
      stepId: stepId,
    );
  }

  if (taskId != null) {
    return OperatorContext.create(
      serviceFactory: serviceFactory,
      taskId: taskId,
    );
  }

  throw ArgumentError(
    'Either workflowId+stepId (dev mode) or taskId (production mode) '
    'is required',
  );
}
