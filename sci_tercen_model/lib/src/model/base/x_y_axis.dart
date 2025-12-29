part of sci_model_base;

class XYAxisBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.chart_OP,
    Vocabulary.colors_OP,
    Vocabulary.errors_OP,
    Vocabulary.labels_OP,
    Vocabulary.xAxis_OP,
    Vocabulary.yAxis_OP,
    Vocabulary.taskId_DP,
    Vocabulary.preprocessors_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.taskId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("CubeQueryTask", Vocabulary.taskId_DP, isComposite: true)
  ];
  Chart _chart;
  Colors _colors;
  Errors _errors;
  Labels _labels;
  Axis _xAxis;
  Axis _yAxis;
  String _taskId;
  final base.ListChanged<PreProcessor> preprocessors;

  XYAxisBase()
      : _taskId = "",
        _chart = Chart(),
        _colors = Colors(),
        _errors = Errors(),
        _labels = Labels(),
        _xAxis = Axis(),
        _yAxis = Axis(),
        preprocessors = base.ListChanged<PreProcessor>() {
    _chart.parent = this;
    _colors.parent = this;
    _errors.parent = this;
    _labels.parent = this;
    _xAxis.parent = this;
    _yAxis.parent = this;
    preprocessors.parent = this;
  }

  XYAxisBase.json(Map m)
      : _taskId = base.defaultValue(
            m[Vocabulary.taskId_DP] as String?, base.String_DefaultFactory),
        _chart = (m[Vocabulary.chart_OP] as Map?) == null
            ? Chart()
            : ChartBase.fromJson(m[Vocabulary.chart_OP] as Map),
        _colors = (m[Vocabulary.colors_OP] as Map?) == null
            ? Colors()
            : ColorsBase.fromJson(m[Vocabulary.colors_OP] as Map),
        _errors = (m[Vocabulary.errors_OP] as Map?) == null
            ? Errors()
            : ErrorsBase.fromJson(m[Vocabulary.errors_OP] as Map),
        _labels = (m[Vocabulary.labels_OP] as Map?) == null
            ? Labels()
            : LabelsBase.fromJson(m[Vocabulary.labels_OP] as Map),
        _xAxis = (m[Vocabulary.xAxis_OP] as Map?) == null
            ? Axis()
            : AxisBase.fromJson(m[Vocabulary.xAxis_OP] as Map),
        _yAxis = (m[Vocabulary.yAxis_OP] as Map?) == null
            ? Axis()
            : AxisBase.fromJson(m[Vocabulary.yAxis_OP] as Map),
        preprocessors = base.ListChanged<PreProcessor>.from(
            m[Vocabulary.preprocessors_OP] as List?,
            PreProcessorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.XYAxis_CLASS, m);
    _chart.parent = this;
    _colors.parent = this;
    _errors.parent = this;
    _labels.parent = this;
    _xAxis.parent = this;
    _yAxis.parent = this;
    preprocessors.parent = this;
  }

  static XYAxis createFromJson(Map m) => XYAxisBase.fromJson(m);
  static XYAxis fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.XYAxis_CLASS:
        return XYAxis.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.XYAxis_CLASS;
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

  Chart get chart => _chart;

  set chart(Chart $o) {
    if ($o == _chart) return;
    _chart.parent = null;
    $o.parent = this;
    var $old = _chart;
    _chart = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.chart_OP, $old, _chart));
    }
  }

  Colors get colors => _colors;

  set colors(Colors $o) {
    if ($o == _colors) return;
    _colors.parent = null;
    $o.parent = this;
    var $old = _colors;
    _colors = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.colors_OP, $old, _colors));
    }
  }

  Errors get errors => _errors;

  set errors(Errors $o) {
    if ($o == _errors) return;
    _errors.parent = null;
    $o.parent = this;
    var $old = _errors;
    _errors = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.errors_OP, $old, _errors));
    }
  }

  Labels get labels => _labels;

  set labels(Labels $o) {
    if ($o == _labels) return;
    _labels.parent = null;
    $o.parent = this;
    var $old = _labels;
    _labels = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.labels_OP, $old, _labels));
    }
  }

  Axis get xAxis => _xAxis;

  set xAxis(Axis $o) {
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

  Axis get yAxis => _yAxis;

  set yAxis(Axis $o) {
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

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.chart_OP:
        return chart;
      case Vocabulary.colors_OP:
        return colors;
      case Vocabulary.errors_OP:
        return errors;
      case Vocabulary.labels_OP:
        return labels;
      case Vocabulary.xAxis_OP:
        return xAxis;
      case Vocabulary.yAxis_OP:
        return yAxis;
      case Vocabulary.taskId_DP:
        return taskId;
      case Vocabulary.preprocessors_OP:
        return preprocessors;
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
      case Vocabulary.chart_OP:
        chart = $value as Chart;
        return;
      case Vocabulary.colors_OP:
        colors = $value as Colors;
        return;
      case Vocabulary.errors_OP:
        errors = $value as Errors;
        return;
      case Vocabulary.labels_OP:
        labels = $value as Labels;
        return;
      case Vocabulary.xAxis_OP:
        xAxis = $value as Axis;
        return;
      case Vocabulary.yAxis_OP:
        yAxis = $value as Axis;
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

  @override
  XYAxis copy() => XYAxis.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.XYAxis_CLASS;
    if (subKind != null && subKind != Vocabulary.XYAxis_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.chart_OP] = chart.toJson();
    m[Vocabulary.colors_OP] = colors.toJson();
    m[Vocabulary.errors_OP] = errors.toJson();
    m[Vocabulary.labels_OP] = labels.toJson();
    m[Vocabulary.xAxis_OP] = xAxis.toJson();
    m[Vocabulary.yAxis_OP] = yAxis.toJson();
    m[Vocabulary.taskId_DP] = taskId;
    m[Vocabulary.preprocessors_OP] = preprocessors.toJson();
    return m;
  }
}
