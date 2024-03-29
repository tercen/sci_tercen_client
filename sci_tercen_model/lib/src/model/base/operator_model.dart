part of sci_model_base;

class OperatorModelBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  OperatorModelBase();
  OperatorModelBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorModel_CLASS, m);
  }

  static OperatorModel createFromJson(Map m) => OperatorModelBase.fromJson(m);
  static OperatorModel _createFromJson(Map? m) =>
      m == null ? OperatorModel() : OperatorModelBase.fromJson(m);
  static OperatorModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorModel_CLASS:
        return OperatorModel.json(m);
      case Vocabulary.GateOperatorModel_CLASS:
        return GateOperatorModel.json(m);
      case Vocabulary.AnnotationOperatorModel_CLASS:
        return AnnotationOperatorModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorModel_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  OperatorModel copy() => OperatorModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorModel_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
