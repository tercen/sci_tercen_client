part of sci_model_base;

class FormulaPropertyBase extends StringProperty {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  FormulaPropertyBase();
  FormulaPropertyBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FormulaProperty_CLASS, m);
  }

  static FormulaProperty createFromJson(Map m) =>
      FormulaPropertyBase.fromJson(m);
  static FormulaProperty fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FormulaProperty_CLASS:
        return FormulaProperty.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FormulaProperty_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  FormulaProperty copy() => FormulaProperty.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FormulaProperty_CLASS;
    if (subKind != null && subKind != Vocabulary.FormulaProperty_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
