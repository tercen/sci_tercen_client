part of sci_model_base;

class OutputPortBase extends Port {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  OutputPortBase();
  OutputPortBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OutputPort_CLASS, m);
  }

  static OutputPort createFromJson(Map m) => OutputPortBase.fromJson(m);
  static OutputPort fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OutputPort_CLASS:
        return OutputPort.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OutputPort_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  OutputPort copy() => OutputPort.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OutputPort_CLASS;
    if (subKind != null && subKind != Vocabulary.OutputPort_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
