part of sci_model_base;

class ShinyOperatorBase extends WebAppOperator {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  ShinyOperatorBase();
  ShinyOperatorBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ShinyOperator_CLASS, m);
  }

  static ShinyOperator createFromJson(Map m) => ShinyOperatorBase.fromJson(m);
  static ShinyOperator fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ShinyOperator_CLASS:
        return ShinyOperator.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ShinyOperator_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ShinyOperator copy() => ShinyOperator.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ShinyOperator_CLASS;
    if (subKind != null && subKind != Vocabulary.ShinyOperator_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
