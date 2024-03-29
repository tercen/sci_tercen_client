part of sci_model_base;

class StepModelBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  StepModelBase();
  StepModelBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.StepModel_CLASS, m);
  }

  static StepModel createFromJson(Map m) => StepModelBase.fromJson(m);
  static StepModel _createFromJson(Map? m) =>
      m == null ? StepModel() : StepModelBase.fromJson(m);
  static StepModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.StepModel_CLASS:
        return StepModel.json(m);
      case Vocabulary.TableStepModel_CLASS:
        return TableStepModel.json(m);
      case Vocabulary.Crosstab_CLASS:
        return Crosstab.json(m);
      case Vocabulary.JoinStepModel_CLASS:
        return JoinStepModel.json(m);
      case Vocabulary.WizardStepModel_CLASS:
        return WizardStepModel.json(m);
      case Vocabulary.MeltStepModel_CLASS:
        return MeltStepModel.json(m);
      case Vocabulary.ExportModel_CLASS:
        return ExportModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.StepModel_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  StepModel copy() => StepModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.StepModel_CLASS;
    if (subKind != null && subKind != Vocabulary.StepModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
