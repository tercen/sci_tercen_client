part of sci_model_base;

class ChartPointBase extends ChartSize {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  ChartPointBase();
  ChartPointBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ChartPoint_CLASS, m);
  }

  static ChartPoint createFromJson(Map m) => ChartPointBase.fromJson(m);
  static ChartPoint _createFromJson(Map? m) =>
      m == null ? ChartPoint() : ChartPointBase.fromJson(m);
  static ChartPoint fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ChartPoint_CLASS:
        return ChartPoint.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ChartPoint_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ChartPoint copy() => ChartPoint.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ChartPoint_CLASS;
    if (subKind != null && subKind != Vocabulary.ChartPoint_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
