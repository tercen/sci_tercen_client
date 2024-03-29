part of sci_model_base;

class CrosstabBase extends StepModel {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.axis_OP,
    Vocabulary.columnTable_OP,
    Vocabulary.filters_OP,
    Vocabulary.operatorSettings_OP,
    Vocabulary.rowTable_OP,
    Vocabulary.taskId_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.taskId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("CubeQueryTask", Vocabulary.taskId_DP, isComposite: true)
  ];
  XYAxisList _axis;
  CrosstabTable _columnTable;
  Filters _filters;
  OperatorSettings _operatorSettings;
  CrosstabTable _rowTable;
  String _taskId;

  CrosstabBase()
      : _taskId = "",
        _axis = XYAxisList(),
        _columnTable = CrosstabTable(),
        _filters = Filters(),
        _operatorSettings = OperatorSettings(),
        _rowTable = CrosstabTable() {
    _axis.parent = this;
    _columnTable.parent = this;
    _filters.parent = this;
    _operatorSettings.parent = this;
    _rowTable.parent = this;
  }

  CrosstabBase.json(Map m)
      : _taskId = base.defaultValue(
            m[Vocabulary.taskId_DP] as String?, base.String_DefaultFactory),
        _axis = XYAxisListBase._createFromJson(m[Vocabulary.axis_OP] as Map?),
        _columnTable = CrosstabTableBase._createFromJson(
            m[Vocabulary.columnTable_OP] as Map?),
        _filters =
            FiltersBase._createFromJson(m[Vocabulary.filters_OP] as Map?),
        _operatorSettings = OperatorSettingsBase._createFromJson(
            m[Vocabulary.operatorSettings_OP] as Map?),
        _rowTable = CrosstabTableBase._createFromJson(
            m[Vocabulary.rowTable_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Crosstab_CLASS, m);
    _axis.parent = this;
    _columnTable.parent = this;
    _filters.parent = this;
    _operatorSettings.parent = this;
    _rowTable.parent = this;
  }

  static Crosstab createFromJson(Map m) => CrosstabBase.fromJson(m);
  static Crosstab _createFromJson(Map? m) =>
      m == null ? Crosstab() : CrosstabBase.fromJson(m);
  static Crosstab fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Crosstab_CLASS:
        return Crosstab.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Crosstab_CLASS;
  String get taskId => _taskId;

  set taskId(String $o) {
    if ($o == _taskId) return;
    var $old = _taskId;
    _taskId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.taskId_DP, $old, _taskId));
    }
  }

  XYAxisList get axis => _axis;

  set axis(XYAxisList $o) {
    if ($o == _axis) return;
    _axis.parent = null;
    $o.parent = this;
    var $old = _axis;
    _axis = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.axis_OP, $old, _axis));
    }
  }

  CrosstabTable get columnTable => _columnTable;

  set columnTable(CrosstabTable $o) {
    if ($o == _columnTable) return;
    _columnTable.parent = null;
    $o.parent = this;
    var $old = _columnTable;
    _columnTable = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.columnTable_OP, $old, _columnTable));
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

  CrosstabTable get rowTable => _rowTable;

  set rowTable(CrosstabTable $o) {
    if ($o == _rowTable) return;
    _rowTable.parent = null;
    $o.parent = this;
    var $old = _rowTable;
    _rowTable = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.rowTable_OP, $old, _rowTable));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.axis_OP:
        return axis;
      case Vocabulary.columnTable_OP:
        return columnTable;
      case Vocabulary.filters_OP:
        return filters;
      case Vocabulary.operatorSettings_OP:
        return operatorSettings;
      case Vocabulary.rowTable_OP:
        return rowTable;
      case Vocabulary.taskId_DP:
        return taskId;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.taskId_DP:
        taskId = $value as String;
        return;
      case Vocabulary.axis_OP:
        axis = $value as XYAxisList;
        return;
      case Vocabulary.columnTable_OP:
        columnTable = $value as CrosstabTable;
        return;
      case Vocabulary.filters_OP:
        filters = $value as Filters;
        return;
      case Vocabulary.operatorSettings_OP:
        operatorSettings = $value as OperatorSettings;
        return;
      case Vocabulary.rowTable_OP:
        rowTable = $value as CrosstabTable;
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
  Crosstab copy() => Crosstab.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Crosstab_CLASS;
    if (subKind != null && subKind != Vocabulary.Crosstab_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.axis_OP] = axis.toJson();
    m[Vocabulary.columnTable_OP] = columnTable.toJson();
    m[Vocabulary.filters_OP] = filters.toJson();
    m[Vocabulary.operatorSettings_OP] = operatorSettings.toJson();
    m[Vocabulary.rowTable_OP] = rowTable.toJson();
    m[Vocabulary.taskId_DP] = taskId;
    return m;
  }
}
