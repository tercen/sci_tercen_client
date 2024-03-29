part of sci_model_base;

class ColumnSchemaMetaDataBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.sort_DP,
    Vocabulary.ascending_DP,
    Vocabulary.quartiles_DP,
    Vocabulary.properties_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChangedBase<String> sort;
  bool _ascending;
  final base.ListChangedBase<String> quartiles;
  final base.ListChanged<Pair> properties;

  ColumnSchemaMetaDataBase()
      : sort = base.ListChangedBase<String>(),
        _ascending = true,
        quartiles = base.ListChangedBase<String>(),
        properties = base.ListChanged<Pair>() {
    sort.parent = this;
    quartiles.parent = this;
    properties.parent = this;
  }

  ColumnSchemaMetaDataBase.json(Map m)
      : sort = base.ListChangedBase<String>(m[Vocabulary.sort_DP] as List?),
        _ascending = base.defaultValue(
            m[Vocabulary.ascending_DP] as bool?, base.bool_DefaultFactory),
        quartiles =
            base.ListChangedBase<String>(m[Vocabulary.quartiles_DP] as List?),
        properties = base.ListChanged<Pair>.from(
            m[Vocabulary.properties_OP] as List?, PairBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ColumnSchemaMetaData_CLASS, m);
    sort.parent = this;
    quartiles.parent = this;
    properties.parent = this;
  }

  static ColumnSchemaMetaData createFromJson(Map m) =>
      ColumnSchemaMetaDataBase.fromJson(m);
  static ColumnSchemaMetaData _createFromJson(Map? m) =>
      m == null ? ColumnSchemaMetaData() : ColumnSchemaMetaDataBase.fromJson(m);
  static ColumnSchemaMetaData fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ColumnSchemaMetaData_CLASS:
        return ColumnSchemaMetaData.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ColumnSchemaMetaData_CLASS;
  bool get ascending => _ascending;

  set ascending(bool $o) {
    if ($o == _ascending) return;
    var $old = _ascending;
    _ascending = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.ascending_DP, $old, _ascending));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.sort_DP:
        return sort;
      case Vocabulary.ascending_DP:
        return ascending;
      case Vocabulary.quartiles_DP:
        return quartiles;
      case Vocabulary.properties_OP:
        return properties;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.sort_DP:
        sort.setValues($value as Iterable<String>);
        return;
      case Vocabulary.ascending_DP:
        ascending = $value as bool;
        return;
      case Vocabulary.quartiles_DP:
        quartiles.setValues($value as Iterable<String>);
        return;
      case Vocabulary.properties_OP:
        properties.setValues($value as Iterable<Pair>);
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
  ColumnSchemaMetaData copy() => ColumnSchemaMetaData.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ColumnSchemaMetaData_CLASS;
    if (subKind != null && subKind != Vocabulary.ColumnSchemaMetaData_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.sort_DP] = sort;
    m[Vocabulary.ascending_DP] = ascending;
    m[Vocabulary.quartiles_DP] = quartiles;
    m[Vocabulary.properties_OP] = properties.toJson();
    return m;
  }
}
