import 'package:sci_tercen_client/sci_client.dart';

/// Retrieves an operator property value by name from the property values list.
///
/// Mirrors R's `op.value(name, type, default)`:
/// ```r
/// property = Find(function(pv) pv$name == name,
///                 self$query$operatorSettings$operatorRef$propertyValues)
/// if (is.null(property)) return(default)
/// return(type(property$value))
/// ```
T getOperatorPropertyValue<T>(
  List<PropertyValue> propertyValues, {
  required String name,
  required T Function(String) converter,
  required T defaultValue,
}) {
  for (final pv in propertyValues) {
    if (pv.name == name) {
      final val = pv.value;
      if (val.isEmpty) return defaultValue;
      return converter(val);
    }
  }
  return defaultValue;
}
