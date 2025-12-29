part of sci_model_base;

class GateNodeBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.nodeId_DP,
    Vocabulary.name_DP,
    Vocabulary.crosstab_OP,
    Vocabulary.children_OP,
    Vocabulary.statistics_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _nodeId;
  String _name;
  Crosstab _crosstab;
  final base.ListChanged<GateNode> children;
  final base.ListChanged<StatisticNode> statistics;

  GateNodeBase()
      : _nodeId = "",
        _name = "",
        _crosstab = Crosstab(),
        children = base.ListChanged<GateNode>(),
        statistics = base.ListChanged<StatisticNode>() {
    _crosstab.parent = this;
    children.parent = this;
    statistics.parent = this;
  }

  GateNodeBase.json(Map m)
      : _nodeId = base.defaultValue(
            m[Vocabulary.nodeId_DP] as String?, base.String_DefaultFactory),
        _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _crosstab = (m[Vocabulary.crosstab_OP] as Map?) == null
            ? Crosstab()
            : CrosstabBase.fromJson(m[Vocabulary.crosstab_OP] as Map),
        children = base.ListChanged<GateNode>.from(
            m[Vocabulary.children_OP] as List?, GateNodeBase.createFromJson),
        statistics = base.ListChanged<StatisticNode>.from(
            m[Vocabulary.statistics_OP] as List?,
            StatisticNodeBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GateNode_CLASS, m);
    _crosstab.parent = this;
    children.parent = this;
    statistics.parent = this;
  }

  static GateNode createFromJson(Map m) => GateNodeBase.fromJson(m);
  static GateNode fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GateNode_CLASS:
        return GateNode.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GateNode_CLASS;
  String get nodeId => _nodeId;

  set nodeId(String $o) {
    if ($o == _nodeId) return;
    var $old = _nodeId;
    _nodeId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nodeId_DP, $old, _nodeId));
    }
  }

  String get name => _name;

  set name(String $o) {
    if ($o == _name) return;
    var $old = _name;
    _name = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.name_DP, $old, _name));
    }
  }

  Crosstab get crosstab => _crosstab;

  set crosstab(Crosstab $o) {
    if ($o == _crosstab) return;
    _crosstab.parent = null;
    $o.parent = this;
    var $old = _crosstab;
    _crosstab = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.crosstab_OP, $old, _crosstab));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.nodeId_DP:
        return nodeId;
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.crosstab_OP:
        return crosstab;
      case Vocabulary.children_OP:
        return children;
      case Vocabulary.statistics_OP:
        return statistics;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.nodeId_DP:
        nodeId = $value as String;
        return;
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.crosstab_OP:
        crosstab = $value as Crosstab;
        return;
      case Vocabulary.children_OP:
        children.setValues($value as Iterable<GateNode>);
        return;
      case Vocabulary.statistics_OP:
        statistics.setValues($value as Iterable<StatisticNode>);
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
  GateNode copy() => GateNode.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GateNode_CLASS;
    if (subKind != null && subKind != Vocabulary.GateNode_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.nodeId_DP] = nodeId;
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.crosstab_OP] = crosstab.toJson();
    m[Vocabulary.children_OP] = children.toJson();
    m[Vocabulary.statistics_OP] = statistics.toJson();
    return m;
  }
}
