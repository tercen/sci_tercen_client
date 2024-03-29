part of sci_model_base;

class OperatorInputSpecBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  OperatorInputSpecBase();
  OperatorInputSpecBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorInputSpec_CLASS, m);
  }

  static OperatorInputSpec createFromJson(Map m) =>
      OperatorInputSpecBase.fromJson(m);
  static OperatorInputSpec _createFromJson(Map? m) =>
      m == null ? OperatorInputSpec() : OperatorInputSpecBase.fromJson(m);
  static OperatorInputSpec fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorInputSpec_CLASS:
        return OperatorInputSpec.json(m);
      case Vocabulary.CrosstabSpec_CLASS:
        return CrosstabSpec.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorInputSpec_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  OperatorInputSpec copy() => OperatorInputSpec.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorInputSpec_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorInputSpec_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
