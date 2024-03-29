part of sci_model_base;

class ChartLineBase extends ChartSize {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  ChartLineBase();
  ChartLineBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ChartLine_CLASS, m);
  }

  static ChartLine createFromJson(Map m) => ChartLineBase.fromJson(m);
  static ChartLine _createFromJson(Map? m) =>
      m == null ? ChartLine() : ChartLineBase.fromJson(m);
  static ChartLine fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ChartLine_CLASS:
        return ChartLine.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ChartLine_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ChartLine copy() => ChartLine.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ChartLine_CLASS;
    if (subKind != null && subKind != Vocabulary.ChartLine_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
