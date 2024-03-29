part of sci_model_base;

class ColumnPairBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.lColumns_DP,
    Vocabulary.rColumns_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChangedBase<String> lColumns;
  final base.ListChangedBase<String> rColumns;

  ColumnPairBase()
      : lColumns = base.ListChangedBase<String>(),
        rColumns = base.ListChangedBase<String>() {
    lColumns.parent = this;
    rColumns.parent = this;
  }

  ColumnPairBase.json(Map m)
      : lColumns =
            base.ListChangedBase<String>(m[Vocabulary.lColumns_DP] as List?),
        rColumns =
            base.ListChangedBase<String>(m[Vocabulary.rColumns_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ColumnPair_CLASS, m);
    lColumns.parent = this;
    rColumns.parent = this;
  }

  static ColumnPair createFromJson(Map m) => ColumnPairBase.fromJson(m);
  static ColumnPair _createFromJson(Map? m) =>
      m == null ? ColumnPair() : ColumnPairBase.fromJson(m);
  static ColumnPair fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ColumnPair_CLASS:
        return ColumnPair.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ColumnPair_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.lColumns_DP:
        return lColumns;
      case Vocabulary.rColumns_DP:
        return rColumns;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.lColumns_DP:
        lColumns.setValues($value as Iterable<String>);
        return;
      case Vocabulary.rColumns_DP:
        rColumns.setValues($value as Iterable<String>);
        return;
      default:
        super.set($name, $value);
    }
  }

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ColumnPair copy() => ColumnPair.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ColumnPair_CLASS;
    if (subKind != null && subKind != Vocabulary.ColumnPair_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.lColumns_DP] = lColumns;
    m[Vocabulary.rColumns_DP] = rColumns;
    return m;
  }
}
