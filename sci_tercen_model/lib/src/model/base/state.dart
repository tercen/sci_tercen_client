part of sci_model_base;

class StateBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  StateBase();
  StateBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.State_CLASS, m);
  }

  static State createFromJson(Map m) => StateBase.fromJson(m);
  static State fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.State_CLASS:
        return State.json(m);
      case Vocabulary.RunningState_CLASS:
        return RunningState.json(m);
      case Vocabulary.RunningDependentState_CLASS:
        return RunningDependentState.json(m);
      case Vocabulary.FailedState_CLASS:
        return FailedState.json(m);
      case Vocabulary.CanceledState_CLASS:
        return CanceledState.json(m);
      case Vocabulary.DoneState_CLASS:
        return DoneState.json(m);
      case Vocabulary.InitState_CLASS:
        return InitState.json(m);
      case Vocabulary.PendingState_CLASS:
        return PendingState.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.State_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  State copy() => State.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.State_CLASS;
    if (subKind != null && subKind != Vocabulary.State_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
