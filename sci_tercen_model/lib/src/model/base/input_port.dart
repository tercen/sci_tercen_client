part of sci_model_base;

class InputPortBase extends Port {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  InputPortBase();
  InputPortBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.InputPort_CLASS, m);
  }

  static InputPort createFromJson(Map m) => InputPortBase.fromJson(m);
  static InputPort fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.InputPort_CLASS:
        return InputPort.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.InputPort_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  InputPort copy() => InputPort.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.InputPort_CLASS;
    if (subKind != null && subKind != Vocabulary.InputPort_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
