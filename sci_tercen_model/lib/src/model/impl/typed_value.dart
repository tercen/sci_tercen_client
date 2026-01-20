part of sci_model;

class TypedValue extends TypedValueBase {
  TypedValue() : super();
  TypedValue.json(Map m) : super.json(m);

  /// Converts this TypedValue to its JSON representation for use in legacy patch data.
  /// Returns the full JSON map that can be decoded by SciObject.decode().
  Map toValueJson() => toJson();
}
