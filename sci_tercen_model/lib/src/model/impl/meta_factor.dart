part of sci_model;

class MetaFactor extends MetaFactorBase {
  MetaFactor() : super();
  MetaFactor.json(super.m) : super.json();

  @override
  String? get propertyName {
    if (parent == null) return null;
    dynamic baseParent = parent;
    if (baseParent is base.Base) {
      return super.propertyName;
    } else if (baseParent is List) {
      return '@[name="$name"]';
    }
    return null;
  }
}
