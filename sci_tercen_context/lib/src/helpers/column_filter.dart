import 'package:sci_tercen_client/sci_client.dart';

/// Filters column names from a schema, excluding system/index types.
///
/// Matches R behavior in `operator-context.R`:
/// ```r
/// where = sapply(schema$columns, function(c) (c$type != 'uint64' && c$type != 'int64'))
/// cnames = lapply(schema$columns[where], function(c) c$name)
/// ```
List<String> filterSelectableColumnNames(List<ColumnSchema> columns) {
  return columns
      .where((c) => c.type != 'int64' && c.type != 'uint64')
      .map((c) => c.name)
      .toList();
}
