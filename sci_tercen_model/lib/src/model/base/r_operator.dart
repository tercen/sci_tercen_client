part of sci_model_base;

class ROperatorBase extends GitOperator {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  ROperatorBase();
  ROperatorBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ROperator_CLASS, m);
  }

  static ROperator createFromJson(Map m) => ROperatorBase.fromJson(m);
  static ROperator _createFromJson(Map? m) =>
      m == null ? ROperator() : ROperatorBase.fromJson(m);
  static ROperator fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ROperator_CLASS:
        return ROperator.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ROperator_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ROperator copy() => ROperator.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ROperator_CLASS;
    if (subKind != null && subKind != Vocabulary.ROperator_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
