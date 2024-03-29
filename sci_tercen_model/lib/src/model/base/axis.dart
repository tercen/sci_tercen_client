part of sci_model_base;

class AxisBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.axisExtent_OP,
    Vocabulary.axisSettings_OP,
    Vocabulary.graphicalFactor_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Point _axisExtent;
  AxisSettings _axisSettings;
  GraphicalFactor _graphicalFactor;

  AxisBase()
      : _axisExtent = Point(),
        _axisSettings = AxisSettings(),
        _graphicalFactor = GraphicalFactor() {
    _axisExtent.parent = this;
    _axisSettings.parent = this;
    _graphicalFactor.parent = this;
  }

  AxisBase.json(Map m)
      : _axisExtent =
            PointBase._createFromJson(m[Vocabulary.axisExtent_OP] as Map?),
        _axisSettings = AxisSettingsBase._createFromJson(
            m[Vocabulary.axisSettings_OP] as Map?),
        _graphicalFactor = GraphicalFactorBase._createFromJson(
            m[Vocabulary.graphicalFactor_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Axis_CLASS, m);
    _axisExtent.parent = this;
    _axisSettings.parent = this;
    _graphicalFactor.parent = this;
  }

  static Axis createFromJson(Map m) => AxisBase.fromJson(m);
  static Axis _createFromJson(Map? m) =>
      m == null ? Axis() : AxisBase.fromJson(m);
  static Axis fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Axis_CLASS:
        return Axis.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Axis_CLASS;
  Point get axisExtent => _axisExtent;

  set axisExtent(Point $o) {
    if ($o == _axisExtent) return;
    _axisExtent.parent = null;
    $o.parent = this;
    var $old = _axisExtent;
    _axisExtent = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.axisExtent_OP, $old, _axisExtent));
    }
  }

  AxisSettings get axisSettings => _axisSettings;

  set axisSettings(AxisSettings $o) {
    if ($o == _axisSettings) return;
    _axisSettings.parent = null;
    $o.parent = this;
    var $old = _axisSettings;
    _axisSettings = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.axisSettings_OP, $old, _axisSettings));
    }
  }

  GraphicalFactor get graphicalFactor => _graphicalFactor;

  set graphicalFactor(GraphicalFactor $o) {
    if ($o == _graphicalFactor) return;
    _graphicalFactor.parent = null;
    $o.parent = this;
    var $old = _graphicalFactor;
    _graphicalFactor = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.graphicalFactor_OP, $old, _graphicalFactor));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.axisExtent_OP:
        return axisExtent;
      case Vocabulary.axisSettings_OP:
        return axisSettings;
      case Vocabulary.graphicalFactor_OP:
        return graphicalFactor;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.axisExtent_OP:
        axisExtent = $value as Point;
        return;
      case Vocabulary.axisSettings_OP:
        axisSettings = $value as AxisSettings;
        return;
      case Vocabulary.graphicalFactor_OP:
        graphicalFactor = $value as GraphicalFactor;
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
  Axis copy() => Axis.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Axis_CLASS;
    if (subKind != null && subKind != Vocabulary.Axis_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.axisExtent_OP] = axisExtent.toJson();
    m[Vocabulary.axisSettings_OP] = axisSettings.toJson();
    m[Vocabulary.graphicalFactor_OP] = graphicalFactor.toJson();
    return m;
  }
}
