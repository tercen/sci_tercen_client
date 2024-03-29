part of sci_model_base;

class ChartHeatmapBase extends Chart {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  ChartHeatmapBase();
  ChartHeatmapBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ChartHeatmap_CLASS, m);
  }

  static ChartHeatmap createFromJson(Map m) => ChartHeatmapBase.fromJson(m);
  static ChartHeatmap _createFromJson(Map? m) =>
      m == null ? ChartHeatmap() : ChartHeatmapBase.fromJson(m);
  static ChartHeatmap fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ChartHeatmap_CLASS:
        return ChartHeatmap.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ChartHeatmap_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ChartHeatmap copy() => ChartHeatmap.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ChartHeatmap_CLASS;
    if (subKind != null && subKind != Vocabulary.ChartHeatmap_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
