part of sci_model_base;

class InitStateBase extends State {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  InitStateBase();
  InitStateBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.InitState_CLASS, m);
  }

  static InitState createFromJson(Map m) => InitStateBase.fromJson(m);
  static InitState _createFromJson(Map? m) =>
      m == null ? InitState() : InitStateBase.fromJson(m);
  static InitState fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.InitState_CLASS:
        return InitState.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.InitState_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  InitState copy() => InitState.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.InitState_CLASS;
    if (subKind != null && subKind != Vocabulary.InitState_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
