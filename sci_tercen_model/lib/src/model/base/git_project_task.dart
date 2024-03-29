part of sci_model_base;

class GitProjectTaskBase extends Task {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  GitProjectTaskBase();
  GitProjectTaskBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GitProjectTask_CLASS, m);
  }

  static GitProjectTask createFromJson(Map m) => GitProjectTaskBase.fromJson(m);
  static GitProjectTask _createFromJson(Map? m) =>
      m == null ? GitProjectTask() : GitProjectTaskBase.fromJson(m);
  static GitProjectTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GitProjectTask_CLASS:
        return GitProjectTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GitProjectTask_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  GitProjectTask copy() => GitProjectTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GitProjectTask_CLASS;
    if (subKind != null && subKind != Vocabulary.GitProjectTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
