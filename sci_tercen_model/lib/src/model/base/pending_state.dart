part of sci_model_base;

class PendingStateBase extends State {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  PendingStateBase();
  PendingStateBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PendingState_CLASS, m);
  }

  static PendingState createFromJson(Map m) => PendingStateBase.fromJson(m);
  static PendingState fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PendingState_CLASS:
        return PendingState.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PendingState_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  PendingState copy() => PendingState.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PendingState_CLASS;
    if (subKind != null && subKind != Vocabulary.PendingState_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
