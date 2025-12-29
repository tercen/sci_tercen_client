part of sci_model_base;

class RelationStepBase extends ModelStep {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  RelationStepBase();
  RelationStepBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RelationStep_CLASS, m);
  }

  static RelationStep createFromJson(Map m) => RelationStepBase.fromJson(m);
  static RelationStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RelationStep_CLASS:
        return RelationStep.json(m);
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
      case Vocabulary.GroupStep_CLASS:
        return GroupStep.json(m);
      case Vocabulary.InStep_CLASS:
        return InStep.json(m);
      case Vocabulary.OutStep_CLASS:
        return OutStep.json(m);
      case Vocabulary.TableStep_CLASS:
        return TableStep.json(m);
      case Vocabulary.NamespaceStep_CLASS:
        return NamespaceStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RelationStep_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  RelationStep copy() => RelationStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RelationStep_CLASS;
    if (subKind != null && subKind != Vocabulary.RelationStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
