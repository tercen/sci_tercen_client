part of sci_model_base;

class FactorsPropertyBase extends StringProperty {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  FactorsPropertyBase();
  FactorsPropertyBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FactorsProperty_CLASS, m);
  }

  static FactorsProperty createFromJson(Map m) =>
      FactorsPropertyBase.fromJson(m);
  static FactorsProperty fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FactorsProperty_CLASS:
        return FactorsProperty.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FactorsProperty_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  FactorsProperty copy() => FactorsProperty.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FactorsProperty_CLASS;
    if (subKind != null && subKind != Vocabulary.FactorsProperty_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
