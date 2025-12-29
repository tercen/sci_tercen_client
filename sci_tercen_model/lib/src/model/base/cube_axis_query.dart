part of sci_model_base;

class CubeAxisQueryBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.pointSize_DP,
    Vocabulary.chartType_DP,
    Vocabulary.yAxis_OP,
    Vocabulary.yAxisSettings_OP,
    Vocabulary.xAxis_OP,
    Vocabulary.xAxisSettings_OP,
    Vocabulary.errors_OP,
    Vocabulary.labels_OP,
    Vocabulary.colors_OP,
    Vocabulary.preprocessors_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _pointSize;
  String _chartType;
  Factor _yAxis;
  AxisSettings _yAxisSettings;
  Factor _xAxis;
  AxisSettings _xAxisSettings;
  final base.ListChanged<Factor> errors;
  final base.ListChanged<Factor> labels;
  final base.ListChanged<Factor> colors;
  final base.ListChanged<PreProcessor> preprocessors;

  CubeAxisQueryBase()
      : _pointSize = 0,
        _chartType = "",
        _yAxis = Factor(),
        _yAxisSettings = AxisSettings(),
        _xAxis = Factor(),
        _xAxisSettings = AxisSettings(),
        errors = base.ListChanged<Factor>(),
        labels = base.ListChanged<Factor>(),
        colors = base.ListChanged<Factor>(),
        preprocessors = base.ListChanged<PreProcessor>() {
    _yAxis.parent = this;
    _yAxisSettings.parent = this;
    _xAxis.parent = this;
    _xAxisSettings.parent = this;
    errors.parent = this;
    labels.parent = this;
    colors.parent = this;
    preprocessors.parent = this;
  }

  CubeAxisQueryBase.json(Map m)
      : _pointSize = base.defaultValue(
            m[Vocabulary.pointSize_DP] as int?, base.int_DefaultFactory),
        _chartType = base.defaultValue(
            m[Vocabulary.chartType_DP] as String?, base.String_DefaultFactory),
        _yAxis = (m[Vocabulary.yAxis_OP] as Map?) == null
            ? Factor()
            : FactorBase.fromJson(m[Vocabulary.yAxis_OP] as Map),
        _yAxisSettings = (m[Vocabulary.yAxisSettings_OP] as Map?) == null
            ? AxisSettings()
            : AxisSettingsBase.fromJson(m[Vocabulary.yAxisSettings_OP] as Map),
        _xAxis = (m[Vocabulary.xAxis_OP] as Map?) == null
            ? Factor()
            : FactorBase.fromJson(m[Vocabulary.xAxis_OP] as Map),
        _xAxisSettings = (m[Vocabulary.xAxisSettings_OP] as Map?) == null
            ? AxisSettings()
            : AxisSettingsBase.fromJson(m[Vocabulary.xAxisSettings_OP] as Map),
        errors = base.ListChanged<Factor>.from(
            m[Vocabulary.errors_OP] as List?, FactorBase.createFromJson),
        labels = base.ListChanged<Factor>.from(
            m[Vocabulary.labels_OP] as List?, FactorBase.createFromJson),
        colors = base.ListChanged<Factor>.from(
            m[Vocabulary.colors_OP] as List?, FactorBase.createFromJson),
        preprocessors = base.ListChanged<PreProcessor>.from(
            m[Vocabulary.preprocessors_OP] as List?,
            PreProcessorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CubeAxisQuery_CLASS, m);
    _yAxis.parent = this;
    _yAxisSettings.parent = this;
    _xAxis.parent = this;
    _xAxisSettings.parent = this;
    errors.parent = this;
    labels.parent = this;
    colors.parent = this;
    preprocessors.parent = this;
  }

  static CubeAxisQuery createFromJson(Map m) => CubeAxisQueryBase.fromJson(m);
  static CubeAxisQuery fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CubeAxisQuery_CLASS:
        return CubeAxisQuery.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CubeAxisQuery_CLASS;
  int get pointSize => _pointSize;

  set pointSize(int $o) {
    if ($o == _pointSize) return;
    var $old = _pointSize;
    _pointSize = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.pointSize_DP, $old, _pointSize));
    }
  }

  String get chartType => _chartType;

  set chartType(String $o) {
    if ($o == _chartType) return;
    var $old = _chartType;
    _chartType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.chartType_DP, $old, _chartType));
    }
  }

  Factor get yAxis => _yAxis;

  set yAxis(Factor $o) {
    if ($o == _yAxis) return;
    _yAxis.parent = null;
    $o.parent = this;
    var $old = _yAxis;
    _yAxis = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.yAxis_OP, $old, _yAxis));
    }
  }

  AxisSettings get yAxisSettings => _yAxisSettings;

  set yAxisSettings(AxisSettings $o) {
    if ($o == _yAxisSettings) return;
    _yAxisSettings.parent = null;
    $o.parent = this;
    var $old = _yAxisSettings;
    _yAxisSettings = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.yAxisSettings_OP, $old, _yAxisSettings));
    }
  }

  Factor get xAxis => _xAxis;

  set xAxis(Factor $o) {
    if ($o == _xAxis) return;
    _xAxis.parent = null;
    $o.parent = this;
    var $old = _xAxis;
    _xAxis = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.xAxis_OP, $old, _xAxis));
    }
  }

  AxisSettings get xAxisSettings => _xAxisSettings;

  set xAxisSettings(AxisSettings $o) {
    if ($o == _xAxisSettings) return;
    _xAxisSettings.parent = null;
    $o.parent = this;
    var $old = _xAxisSettings;
    _xAxisSettings = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.xAxisSettings_OP, $old, _xAxisSettings));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.pointSize_DP:
        return pointSize;
      case Vocabulary.chartType_DP:
        return chartType;
      case Vocabulary.yAxis_OP:
        return yAxis;
      case Vocabulary.yAxisSettings_OP:
        return yAxisSettings;
      case Vocabulary.xAxis_OP:
        return xAxis;
      case Vocabulary.xAxisSettings_OP:
        return xAxisSettings;
      case Vocabulary.errors_OP:
        return errors;
      case Vocabulary.labels_OP:
        return labels;
      case Vocabulary.colors_OP:
        return colors;
      case Vocabulary.preprocessors_OP:
        return preprocessors;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.pointSize_DP:
        pointSize = $value as int;
        return;
      case Vocabulary.chartType_DP:
        chartType = $value as String;
        return;
      case Vocabulary.yAxis_OP:
        yAxis = $value as Factor;
        return;
      case Vocabulary.yAxisSettings_OP:
        yAxisSettings = $value as AxisSettings;
        return;
      case Vocabulary.xAxis_OP:
        xAxis = $value as Factor;
        return;
      case Vocabulary.xAxisSettings_OP:
        xAxisSettings = $value as AxisSettings;
        return;
      case Vocabulary.errors_OP:
        errors.setValues($value as Iterable<Factor>);
        return;
      case Vocabulary.labels_OP:
        labels.setValues($value as Iterable<Factor>);
        return;
      case Vocabulary.colors_OP:
        colors.setValues($value as Iterable<Factor>);
        return;
      case Vocabulary.preprocessors_OP:
        preprocessors.setValues($value as Iterable<PreProcessor>);
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

  CubeAxisQuery copy() => CubeAxisQuery.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CubeAxisQuery_CLASS;
    if (subKind != null && subKind != Vocabulary.CubeAxisQuery_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.pointSize_DP] = pointSize;
    m[Vocabulary.chartType_DP] = chartType;
    m[Vocabulary.yAxis_OP] = yAxis.toJson();
    m[Vocabulary.yAxisSettings_OP] = yAxisSettings.toJson();
    m[Vocabulary.xAxis_OP] = xAxis.toJson();
    m[Vocabulary.xAxisSettings_OP] = xAxisSettings.toJson();
    m[Vocabulary.errors_OP] = errors.toJson();
    m[Vocabulary.labels_OP] = labels.toJson();
    m[Vocabulary.colors_OP] = colors.toJson();
    m[Vocabulary.preprocessors_OP] = preprocessors.toJson();
    return m;
  }
}
