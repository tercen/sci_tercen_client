part of sci_model_base;

class SaveComputationResultTaskBase extends ComputationTask {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  SaveComputationResultTaskBase();
  SaveComputationResultTaskBase.json(Map m) : super.json(m) {
    subKind =
        base.subKindForClass(Vocabulary.SaveComputationResultTask_CLASS, m);
  }

  static SaveComputationResultTask createFromJson(Map m) =>
      SaveComputationResultTaskBase.fromJson(m);
  static SaveComputationResultTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.SaveComputationResultTask_CLASS:
        return SaveComputationResultTask.json(m);
      case Vocabulary.RunComputationTask_CLASS:
        return RunComputationTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.SaveComputationResultTask_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  SaveComputationResultTask copy() => SaveComputationResultTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.SaveComputationResultTask_CLASS;
    if (subKind != null &&
        subKind != Vocabulary.SaveComputationResultTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
