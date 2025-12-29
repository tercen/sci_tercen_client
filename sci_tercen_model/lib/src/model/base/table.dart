part of sci_model_base;

class TableBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.nRows_DP,
    Vocabulary.properties_OP,
    Vocabulary.columns_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _nRows;
  TableProperties _properties;
  final base.ListChanged<Column> columns;

  TableBase()
      : _nRows = 0,
        _properties = TableProperties(),
        columns = base.ListChanged<Column>() {
    _properties.parent = this;
    columns.parent = this;
  }

  TableBase.json(Map m)
      : _nRows = base.defaultValue(
            m[Vocabulary.nRows_DP] as int?, base.int_DefaultFactory),
        _properties = (m[Vocabulary.properties_OP] as Map?) == null
            ? TableProperties()
            : TablePropertiesBase.fromJson(m[Vocabulary.properties_OP] as Map),
        columns = base.ListChanged<Column>.from(
            m[Vocabulary.columns_OP] as List?, ColumnBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Table_CLASS, m);
    _properties.parent = this;
    columns.parent = this;
  }

  static Table createFromJson(Map m) => TableBase.fromJson(m);
  static Table fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Table_CLASS:
        return Table.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Table_CLASS;
  int get nRows => _nRows;

  set nRows(int $o) {
    if ($o == _nRows) return;
    var $old = _nRows;
    _nRows = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nRows_DP, $old, _nRows));
    }
  }

  TableProperties get properties => _properties;

  set properties(TableProperties $o) {
    if ($o == _properties) return;
    _properties.parent = null;
    $o.parent = this;
    var $old = _properties;
    _properties = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.properties_OP, $old, _properties));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.nRows_DP:
        return nRows;
      case Vocabulary.properties_OP:
        return properties;
      case Vocabulary.columns_OP:
        return columns;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.nRows_DP:
        nRows = $value as int;
        return;
      case Vocabulary.properties_OP:
        properties = $value as TableProperties;
        return;
      case Vocabulary.columns_OP:
        columns.setValues($value as Iterable<Column>);
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
  Table copy() => Table.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Table_CLASS;
    if (subKind != null && subKind != Vocabulary.Table_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.nRows_DP] = nRows;
    m[Vocabulary.properties_OP] = properties.toJson();
    m[Vocabulary.columns_OP] = columns.toJson();
    return m;
  }
}
