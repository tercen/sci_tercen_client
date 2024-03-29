part of sci_model_base;

class WorkflowBase extends ProjectDocument {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.links_OP,
    Vocabulary.steps_OP,
    Vocabulary.offset_OP,
    Vocabulary.scale_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Link> links;
  final base.ListChanged<Step> steps;
  Point _offset;
  double _scale;

  WorkflowBase()
      : _scale = 0.0,
        links = base.ListChanged<Link>(),
        steps = base.ListChanged<Step>(),
        _offset = Point() {
    links.parent = this;
    steps.parent = this;
    _offset.parent = this;
  }

  WorkflowBase.json(Map m)
      : _scale = base.defaultDouble(m[Vocabulary.scale_DP] as num?),
        links = base.ListChanged<Link>.from(
            m[Vocabulary.links_OP] as List?, LinkBase.createFromJson),
        steps = base.ListChanged<Step>.from(
            m[Vocabulary.steps_OP] as List?, StepBase.createFromJson),
        _offset = PointBase._createFromJson(m[Vocabulary.offset_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Workflow_CLASS, m);
    links.parent = this;
    steps.parent = this;
    _offset.parent = this;
  }

  static Workflow createFromJson(Map m) => WorkflowBase.fromJson(m);
  static Workflow _createFromJson(Map? m) =>
      m == null ? Workflow() : WorkflowBase.fromJson(m);
  static Workflow fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Workflow_CLASS:
        return Workflow.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Workflow_CLASS;
  double get scale => _scale;

  set scale(double $o) {
    if ($o == _scale) return;
    var $old = _scale;
    _scale = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.scale_DP, $old, _scale));
    }
  }

  Point get offset => _offset;

  set offset(Point $o) {
    if ($o == _offset) return;
    _offset.parent = null;
    $o.parent = this;
    var $old = _offset;
    _offset = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.offset_OP, $old, _offset));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.links_OP:
        return links;
      case Vocabulary.steps_OP:
        return steps;
      case Vocabulary.offset_OP:
        return offset;
      case Vocabulary.scale_DP:
        return scale;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.scale_DP:
        scale = $value as double;
        return;
      case Vocabulary.links_OP:
        links.setValues($value as Iterable<Link>);
        return;
      case Vocabulary.steps_OP:
        steps.setValues($value as Iterable<Step>);
        return;
      case Vocabulary.offset_OP:
        offset = $value as Point;
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
  Workflow copy() => Workflow.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Workflow_CLASS;
    if (subKind != null && subKind != Vocabulary.Workflow_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.links_OP] = links.toJson();
    m[Vocabulary.steps_OP] = steps.toJson();
    m[Vocabulary.offset_OP] = offset.toJson();
    m[Vocabulary.scale_DP] = scale;
    return m;
  }
}
