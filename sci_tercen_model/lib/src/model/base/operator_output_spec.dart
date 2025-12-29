part of sci_model_base;

class OperatorOutputSpecBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  OperatorOutputSpecBase();
  OperatorOutputSpecBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorOutputSpec_CLASS, m);
  }

  static OperatorOutputSpec createFromJson(Map m) =>
      OperatorOutputSpecBase.fromJson(m);
  static OperatorOutputSpec fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorOutputSpec_CLASS:
        return OperatorOutputSpec.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorOutputSpec_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  OperatorOutputSpec copy() => OperatorOutputSpec.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorOutputSpec_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorOutputSpec_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
