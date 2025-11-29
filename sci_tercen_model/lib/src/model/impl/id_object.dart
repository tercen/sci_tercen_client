part of sci_model;

class IdObject extends IdObjectBase {
  IdObject() : super();
  IdObject.json(super.m) : super.json();

  @override
  String? get propertyName {
    if (parent == null) return null;
    dynamic baseParent = parent;
    if (baseParent is base.Base) {
      return super.propertyName;
    } else if (baseParent is List) {
      return "@[id=$id]";
    }
    return null;
  }
}
