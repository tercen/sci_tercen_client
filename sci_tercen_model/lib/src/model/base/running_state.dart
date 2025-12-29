part of sci_model_base;

class RunningStateBase extends State {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  RunningStateBase();
  RunningStateBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RunningState_CLASS, m);
  }

  static RunningState createFromJson(Map m) => RunningStateBase.fromJson(m);
  static RunningState fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RunningState_CLASS:
        return RunningState.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RunningState_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  RunningState copy() => RunningState.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RunningState_CLASS;
    if (subKind != null && subKind != Vocabulary.RunningState_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
