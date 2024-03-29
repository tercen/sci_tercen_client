part of sci_model_base;

class ChartBarBase extends Chart {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  ChartBarBase();
  ChartBarBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ChartBar_CLASS, m);
  }

  static ChartBar createFromJson(Map m) => ChartBarBase.fromJson(m);
  static ChartBar _createFromJson(Map? m) =>
      m == null ? ChartBar() : ChartBarBase.fromJson(m);
  static ChartBar fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ChartBar_CLASS:
        return ChartBar.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ChartBar_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ChartBar copy() => ChartBar.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ChartBar_CLASS;
    if (subKind != null && subKind != Vocabulary.ChartBar_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
