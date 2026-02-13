/// Tercen operator context library.
///
/// Provides R/Python-style context abstraction for the Tercen platform.
/// Use [tercenCtx] to create a context in dev or production mode, then
/// call [AbstractOperatorContext.select], [AbstractOperatorContext.cselect],
/// and [AbstractOperatorContext.rselect] to access data.
library sci_tercen_context;

export 'package:sci_tercen_client/sci_client.dart';
export 'package:sci_tercen_client/sci_client_service_factory.dart'
    show ServiceFactoryBase;

export 'src/context/abstract_operator_context.dart';
export 'src/context/operator_context.dart';
export 'src/context/operator_context_dev.dart';
export 'src/factory/tercen_ctx.dart';
export 'src/helpers/async_lazy.dart';
export 'src/helpers/column_filter.dart';
export 'src/helpers/operator_property.dart';
