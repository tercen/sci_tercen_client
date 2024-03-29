part of sci_model_base;

class SummaryBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.tableSummary_OP,
    Vocabulary.computedTableSummary_OP,
    Vocabulary.queryTableSummary_OP,
    Vocabulary.taskSummary_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  TableSummary _tableSummary;
  TableSummary _computedTableSummary;
  TableSummary _queryTableSummary;
  TaskSummary _taskSummary;

  SummaryBase()
      : _tableSummary = TableSummary(),
        _computedTableSummary = TableSummary(),
        _queryTableSummary = TableSummary(),
        _taskSummary = TaskSummary() {
    _tableSummary.parent = this;
    _computedTableSummary.parent = this;
    _queryTableSummary.parent = this;
    _taskSummary.parent = this;
  }

  SummaryBase.json(Map m)
      : _tableSummary = TableSummaryBase._createFromJson(
            m[Vocabulary.tableSummary_OP] as Map?),
        _computedTableSummary = TableSummaryBase._createFromJson(
            m[Vocabulary.computedTableSummary_OP] as Map?),
        _queryTableSummary = TableSummaryBase._createFromJson(
            m[Vocabulary.queryTableSummary_OP] as Map?),
        _taskSummary = TaskSummaryBase._createFromJson(
            m[Vocabulary.taskSummary_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Summary_CLASS, m);
    _tableSummary.parent = this;
    _computedTableSummary.parent = this;
    _queryTableSummary.parent = this;
    _taskSummary.parent = this;
  }

  static Summary createFromJson(Map m) => SummaryBase.fromJson(m);
  static Summary _createFromJson(Map? m) =>
      m == null ? Summary() : SummaryBase.fromJson(m);
  static Summary fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Summary_CLASS:
        return Summary.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Summary_CLASS;
  TableSummary get tableSummary => _tableSummary;

  set tableSummary(TableSummary $o) {
    if ($o == _tableSummary) return;
    _tableSummary.parent = null;
    $o.parent = this;
    var $old = _tableSummary;
    _tableSummary = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.tableSummary_OP, $old, _tableSummary));
    }
  }

  TableSummary get computedTableSummary => _computedTableSummary;

  set computedTableSummary(TableSummary $o) {
    if ($o == _computedTableSummary) return;
    _computedTableSummary.parent = null;
    $o.parent = this;
    var $old = _computedTableSummary;
    _computedTableSummary = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(this,
          Vocabulary.computedTableSummary_OP, $old, _computedTableSummary));
    }
  }

  TableSummary get queryTableSummary => _queryTableSummary;

  set queryTableSummary(TableSummary $o) {
    if ($o == _queryTableSummary) return;
    _queryTableSummary.parent = null;
    $o.parent = this;
    var $old = _queryTableSummary;
    _queryTableSummary = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.queryTableSummary_OP, $old, _queryTableSummary));
    }
  }

  TaskSummary get taskSummary => _taskSummary;

  set taskSummary(TaskSummary $o) {
    if ($o == _taskSummary) return;
    _taskSummary.parent = null;
    $o.parent = this;
    var $old = _taskSummary;
    _taskSummary = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.taskSummary_OP, $old, _taskSummary));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.tableSummary_OP:
        return tableSummary;
      case Vocabulary.computedTableSummary_OP:
        return computedTableSummary;
      case Vocabulary.queryTableSummary_OP:
        return queryTableSummary;
      case Vocabulary.taskSummary_OP:
        return taskSummary;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.tableSummary_OP:
        tableSummary = $value as TableSummary;
        return;
      case Vocabulary.computedTableSummary_OP:
        computedTableSummary = $value as TableSummary;
        return;
      case Vocabulary.queryTableSummary_OP:
        queryTableSummary = $value as TableSummary;
        return;
      case Vocabulary.taskSummary_OP:
        taskSummary = $value as TaskSummary;
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
  Summary copy() => Summary.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Summary_CLASS;
    if (subKind != null && subKind != Vocabulary.Summary_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.tableSummary_OP] = tableSummary.toJson();
    m[Vocabulary.computedTableSummary_OP] = computedTableSummary.toJson();
    m[Vocabulary.queryTableSummary_OP] = queryTableSummary.toJson();
    m[Vocabulary.taskSummary_OP] = taskSummary.toJson();
    return m;
  }
}
