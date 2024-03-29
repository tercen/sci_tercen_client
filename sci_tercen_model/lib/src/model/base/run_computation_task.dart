part of sci_model_base;

class RunComputationTaskBase extends SaveComputationResultTask {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  RunComputationTaskBase();
  RunComputationTaskBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RunComputationTask_CLASS, m);
  }

  static RunComputationTask createFromJson(Map m) =>
      RunComputationTaskBase.fromJson(m);
  static RunComputationTask _createFromJson(Map? m) =>
      m == null ? RunComputationTask() : RunComputationTaskBase.fromJson(m);
  static RunComputationTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RunComputationTask_CLASS:
        return RunComputationTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RunComputationTask_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  RunComputationTask copy() => RunComputationTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RunComputationTask_CLASS;
    if (subKind != null && subKind != Vocabulary.RunComputationTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
