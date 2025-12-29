part of sci_model_base;

class CanceledStateBase extends State {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  CanceledStateBase();
  CanceledStateBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CanceledState_CLASS, m);
  }

  static CanceledState createFromJson(Map m) => CanceledStateBase.fromJson(m);
  static CanceledState fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CanceledState_CLASS:
        return CanceledState.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CanceledState_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  CanceledState copy() => CanceledState.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CanceledState_CLASS;
    if (subKind != null && subKind != Vocabulary.CanceledState_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
