part of sci_model_base;

class ModelStepBase extends Step {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  ModelStepBase();
  ModelStepBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ModelStep_CLASS, m);
  }

  static ModelStep createFromJson(Map m) => ModelStepBase.fromJson(m);
  static ModelStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ModelStep_CLASS:
        return ModelStep.json(m);
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
      case Vocabulary.RelationStep_CLASS:
        return RelationStep.json(m);
      case Vocabulary.ExportStep_CLASS:
        return ExportStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ModelStep_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ModelStep copy() => ModelStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ModelStep_CLASS;
    if (subKind != null && subKind != Vocabulary.ModelStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
