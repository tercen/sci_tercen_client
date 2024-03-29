part of sci_model_base;

class CubeQueryBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.relation_OP,
    Vocabulary.colColumns_OP,
    Vocabulary.rowColumns_OP,
    Vocabulary.axisQueries_OP,
    Vocabulary.filters_OP,
    Vocabulary.operatorSettings_OP,
    Vocabulary.qtHash_DP,
    Vocabulary.columnHash_DP,
    Vocabulary.rowHash_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Relation _relation;
  final base.ListChanged<Factor> colColumns;
  final base.ListChanged<Factor> rowColumns;
  final base.ListChanged<CubeAxisQuery> axisQueries;
  Filters _filters;
  OperatorSettings _operatorSettings;
  String _qtHash;
  String _columnHash;
  String _rowHash;

  CubeQueryBase()
      : _qtHash = "",
        _columnHash = "",
        _rowHash = "",
        _relation = Relation(),
        colColumns = base.ListChanged<Factor>(),
        rowColumns = base.ListChanged<Factor>(),
        axisQueries = base.ListChanged<CubeAxisQuery>(),
        _filters = Filters(),
        _operatorSettings = OperatorSettings() {
    _relation.parent = this;
    colColumns.parent = this;
    rowColumns.parent = this;
    axisQueries.parent = this;
    _filters.parent = this;
    _operatorSettings.parent = this;
  }

  CubeQueryBase.json(Map m)
      : _qtHash = base.defaultValue(
            m[Vocabulary.qtHash_DP] as String?, base.String_DefaultFactory),
        _columnHash = base.defaultValue(
            m[Vocabulary.columnHash_DP] as String?, base.String_DefaultFactory),
        _rowHash = base.defaultValue(
            m[Vocabulary.rowHash_DP] as String?, base.String_DefaultFactory),
        _relation =
            RelationBase._createFromJson(m[Vocabulary.relation_OP] as Map?),
        colColumns = base.ListChanged<Factor>.from(
            m[Vocabulary.colColumns_OP] as List?, FactorBase.createFromJson),
        rowColumns = base.ListChanged<Factor>.from(
            m[Vocabulary.rowColumns_OP] as List?, FactorBase.createFromJson),
        axisQueries = base.ListChanged<CubeAxisQuery>.from(
            m[Vocabulary.axisQueries_OP] as List?,
            CubeAxisQueryBase.createFromJson),
        _filters =
            FiltersBase._createFromJson(m[Vocabulary.filters_OP] as Map?),
        _operatorSettings = OperatorSettingsBase._createFromJson(
            m[Vocabulary.operatorSettings_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CubeQuery_CLASS, m);
    _relation.parent = this;
    colColumns.parent = this;
    rowColumns.parent = this;
    axisQueries.parent = this;
    _filters.parent = this;
    _operatorSettings.parent = this;
  }

  static CubeQuery createFromJson(Map m) => CubeQueryBase.fromJson(m);
  static CubeQuery _createFromJson(Map? m) =>
      m == null ? CubeQuery() : CubeQueryBase.fromJson(m);
  static CubeQuery fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CubeQuery_CLASS:
        return CubeQuery.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CubeQuery_CLASS;
  String get qtHash => _qtHash;

  set qtHash(String $o) {
    if ($o == _qtHash) return;
    var $old = _qtHash;
    _qtHash = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.qtHash_DP, $old, _qtHash));
    }
  }

  String get columnHash => _columnHash;

  set columnHash(String $o) {
    if ($o == _columnHash) return;
    var $old = _columnHash;
    _columnHash = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.columnHash_DP, $old, _columnHash));
    }
  }

  String get rowHash => _rowHash;

  set rowHash(String $o) {
    if ($o == _rowHash) return;
    var $old = _rowHash;
    _rowHash = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.rowHash_DP, $old, _rowHash));
    }
  }

  Relation get relation => _relation;

  set relation(Relation $o) {
    if ($o == _relation) return;
    _relation.parent = null;
    $o.parent = this;
    var $old = _relation;
    _relation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.relation_OP, $old, _relation));
    }
  }

  Filters get filters => _filters;

  set filters(Filters $o) {
    if ($o == _filters) return;
    _filters.parent = null;
    $o.parent = this;
    var $old = _filters;
    _filters = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.filters_OP, $old, _filters));
    }
  }

  OperatorSettings get operatorSettings => _operatorSettings;

  set operatorSettings(OperatorSettings $o) {
    if ($o == _operatorSettings) return;
    _operatorSettings.parent = null;
    $o.parent = this;
    var $old = _operatorSettings;
    _operatorSettings = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.operatorSettings_OP, $old, _operatorSettings));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.relation_OP:
        return relation;
      case Vocabulary.colColumns_OP:
        return colColumns;
      case Vocabulary.rowColumns_OP:
        return rowColumns;
      case Vocabulary.axisQueries_OP:
        return axisQueries;
      case Vocabulary.filters_OP:
        return filters;
      case Vocabulary.operatorSettings_OP:
        return operatorSettings;
      case Vocabulary.qtHash_DP:
        return qtHash;
      case Vocabulary.columnHash_DP:
        return columnHash;
      case Vocabulary.rowHash_DP:
        return rowHash;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.qtHash_DP:
        qtHash = $value as String;
        return;
      case Vocabulary.columnHash_DP:
        columnHash = $value as String;
        return;
      case Vocabulary.rowHash_DP:
        rowHash = $value as String;
        return;
      case Vocabulary.relation_OP:
        relation = $value as Relation;
        return;
      case Vocabulary.colColumns_OP:
        colColumns.setValues($value as Iterable<Factor>);
        return;
      case Vocabulary.rowColumns_OP:
        rowColumns.setValues($value as Iterable<Factor>);
        return;
      case Vocabulary.axisQueries_OP:
        axisQueries.setValues($value as Iterable<CubeAxisQuery>);
        return;
      case Vocabulary.filters_OP:
        filters = $value as Filters;
        return;
      case Vocabulary.operatorSettings_OP:
        operatorSettings = $value as OperatorSettings;
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
  CubeQuery copy() => CubeQuery.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CubeQuery_CLASS;
    if (subKind != null && subKind != Vocabulary.CubeQuery_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relation_OP] = relation.toJson();
    m[Vocabulary.colColumns_OP] = colColumns.toJson();
    m[Vocabulary.rowColumns_OP] = rowColumns.toJson();
    m[Vocabulary.axisQueries_OP] = axisQueries.toJson();
    m[Vocabulary.filters_OP] = filters.toJson();
    m[Vocabulary.operatorSettings_OP] = operatorSettings.toJson();
    m[Vocabulary.qtHash_DP] = qtHash;
    m[Vocabulary.columnHash_DP] = columnHash;
    m[Vocabulary.rowHash_DP] = rowHash;
    return m;
  }
}
