part of sci_model_base;

class NamespaceStepBase extends RelationStep {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  NamespaceStepBase();
  NamespaceStepBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.NamespaceStep_CLASS, m);
  }

  static NamespaceStep createFromJson(Map m) => NamespaceStepBase.fromJson(m);
  static NamespaceStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.NamespaceStep_CLASS:
        return NamespaceStep.json(m);
      case Vocabulary.DataStep_CLASS:
        return DataStep.json(m);
      case Vocabulary.MeltStep_CLASS:
        return MeltStep.json(m);
      case Vocabulary.JoinStep_CLASS:
        return JoinStep.json(m);
      case Vocabulary.WizardStep_CLASS:
        return WizardStep.json(m);
      case Vocabulary.CrossTabStep_CLASS:
        return CrossTabStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.NamespaceStep_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  NamespaceStep copy() => NamespaceStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.NamespaceStep_CLASS;
    if (subKind != null && subKind != Vocabulary.NamespaceStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
