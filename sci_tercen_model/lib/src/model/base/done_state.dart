part of sci_model_base;

class DoneStateBase extends State {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  DoneStateBase();
  DoneStateBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.DoneState_CLASS, m);
  }

  static DoneState createFromJson(Map m) => DoneStateBase.fromJson(m);
  static DoneState fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.DoneState_CLASS:
        return DoneState.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.DoneState_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  DoneState copy() => DoneState.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.DoneState_CLASS;
    if (subKind != null && subKind != Vocabulary.DoneState_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
