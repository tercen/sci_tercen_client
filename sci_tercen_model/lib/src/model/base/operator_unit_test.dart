part of sci_model_base;

class OperatorUnitTestBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.namespace_DP,
    Vocabulary.propertyValues_OP,
    Vocabulary.inputFileUris_DP,
    Vocabulary.inputDataUri_DP,
    Vocabulary.outputDataUri_DP,
    Vocabulary.columns_DP,
    Vocabulary.rows_DP,
    Vocabulary.colors_DP,
    Vocabulary.labels_DP,
    Vocabulary.yAxis_DP,
    Vocabulary.xAxis_DP,
    Vocabulary.absTol_DP,
    Vocabulary.relTol_DP,
    Vocabulary.equalityMethod_DP,
    Vocabulary.r2_DP,
    Vocabulary.skipColumns_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  String _namespace;
  final base.ListChanged<PropertyValue> propertyValues;
  final base.ListChangedBase<String> inputFileUris;
  String _inputDataUri;
  final base.ListChangedBase<String> outputDataUri;
  final base.ListChangedBase<String> columns;
  final base.ListChangedBase<String> rows;
  final base.ListChangedBase<String> colors;
  final base.ListChangedBase<String> labels;
  String _yAxis;
  String _xAxis;
  double _absTol;
  double _relTol;
  String _equalityMethod;
  double _r2;
  final base.ListChangedBase<String> skipColumns;

  OperatorUnitTestBase()
      : _name = "",
        _namespace = "",
        inputFileUris = base.ListChangedBase<String>(),
        _inputDataUri = "",
        outputDataUri = base.ListChangedBase<String>(),
        columns = base.ListChangedBase<String>(),
        rows = base.ListChangedBase<String>(),
        colors = base.ListChangedBase<String>(),
        labels = base.ListChangedBase<String>(),
        _yAxis = "",
        _xAxis = "",
        _absTol = 0.0,
        _relTol = 0.0,
        _equalityMethod = "",
        _r2 = 0.0,
        skipColumns = base.ListChangedBase<String>(),
        propertyValues = base.ListChanged<PropertyValue>() {
    inputFileUris.parent = this;
    outputDataUri.parent = this;
    columns.parent = this;
    rows.parent = this;
    colors.parent = this;
    labels.parent = this;
    skipColumns.parent = this;
    propertyValues.parent = this;
  }

  OperatorUnitTestBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _namespace = base.defaultValue(
            m[Vocabulary.namespace_DP] as String?, base.String_DefaultFactory),
        inputFileUris = base.ListChangedBase<String>(
            m[Vocabulary.inputFileUris_DP] as List?),
        _inputDataUri = base.defaultValue(
            m[Vocabulary.inputDataUri_DP] as String?,
            base.String_DefaultFactory),
        outputDataUri = base.ListChangedBase<String>(
            m[Vocabulary.outputDataUri_DP] as List?),
        columns =
            base.ListChangedBase<String>(m[Vocabulary.columns_DP] as List?),
        rows = base.ListChangedBase<String>(m[Vocabulary.rows_DP] as List?),
        colors = base.ListChangedBase<String>(m[Vocabulary.colors_DP] as List?),
        labels = base.ListChangedBase<String>(m[Vocabulary.labels_DP] as List?),
        _yAxis = base.defaultValue(
            m[Vocabulary.yAxis_DP] as String?, base.String_DefaultFactory),
        _xAxis = base.defaultValue(
            m[Vocabulary.xAxis_DP] as String?, base.String_DefaultFactory),
        _absTol = base.defaultDouble(m[Vocabulary.absTol_DP] as num?),
        _relTol = base.defaultDouble(m[Vocabulary.relTol_DP] as num?),
        _equalityMethod = base.defaultValue(
            m[Vocabulary.equalityMethod_DP] as String?,
            base.String_DefaultFactory),
        _r2 = base.defaultDouble(m[Vocabulary.r2_DP] as num?),
        skipColumns =
            base.ListChangedBase<String>(m[Vocabulary.skipColumns_DP] as List?),
        propertyValues = base.ListChanged<PropertyValue>.from(
            m[Vocabulary.propertyValues_OP] as List?,
            PropertyValueBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorUnitTest_CLASS, m);
    inputFileUris.parent = this;
    outputDataUri.parent = this;
    columns.parent = this;
    rows.parent = this;
    colors.parent = this;
    labels.parent = this;
    skipColumns.parent = this;
    propertyValues.parent = this;
  }

  static OperatorUnitTest createFromJson(Map m) =>
      OperatorUnitTestBase.fromJson(m);
  static OperatorUnitTest _createFromJson(Map? m) =>
      m == null ? OperatorUnitTest() : OperatorUnitTestBase.fromJson(m);
  static OperatorUnitTest fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorUnitTest_CLASS:
        return OperatorUnitTest.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorUnitTest_CLASS;
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

  String get namespace => _namespace;

  set namespace(String $o) {
    if ($o == _namespace) return;
    var $old = _namespace;
    _namespace = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.namespace_DP, $old, _namespace));
    }
  }

  String get inputDataUri => _inputDataUri;

  set inputDataUri(String $o) {
    if ($o == _inputDataUri) return;
    var $old = _inputDataUri;
    _inputDataUri = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.inputDataUri_DP, $old, _inputDataUri));
    }
  }

  String get yAxis => _yAxis;

  set yAxis(String $o) {
    if ($o == _yAxis) return;
    var $old = _yAxis;
    _yAxis = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.yAxis_DP, $old, _yAxis));
    }
  }

  String get xAxis => _xAxis;

  set xAxis(String $o) {
    if ($o == _xAxis) return;
    var $old = _xAxis;
    _xAxis = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.xAxis_DP, $old, _xAxis));
    }
  }

  double get absTol => _absTol;

  set absTol(double $o) {
    if ($o == _absTol) return;
    var $old = _absTol;
    _absTol = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.absTol_DP, $old, _absTol));
    }
  }

  double get relTol => _relTol;

  set relTol(double $o) {
    if ($o == _relTol) return;
    var $old = _relTol;
    _relTol = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.relTol_DP, $old, _relTol));
    }
  }

  String get equalityMethod => _equalityMethod;

  set equalityMethod(String $o) {
    if ($o == _equalityMethod) return;
    var $old = _equalityMethod;
    _equalityMethod = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.equalityMethod_DP, $old, _equalityMethod));
    }
  }

  double get r2 => _r2;

  set r2(double $o) {
    if ($o == _r2) return;
    var $old = _r2;
    _r2 = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.r2_DP, $old, _r2));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.namespace_DP:
        return namespace;
      case Vocabulary.propertyValues_OP:
        return propertyValues;
      case Vocabulary.inputFileUris_DP:
        return inputFileUris;
      case Vocabulary.inputDataUri_DP:
        return inputDataUri;
      case Vocabulary.outputDataUri_DP:
        return outputDataUri;
      case Vocabulary.columns_DP:
        return columns;
      case Vocabulary.rows_DP:
        return rows;
      case Vocabulary.colors_DP:
        return colors;
      case Vocabulary.labels_DP:
        return labels;
      case Vocabulary.yAxis_DP:
        return yAxis;
      case Vocabulary.xAxis_DP:
        return xAxis;
      case Vocabulary.absTol_DP:
        return absTol;
      case Vocabulary.relTol_DP:
        return relTol;
      case Vocabulary.equalityMethod_DP:
        return equalityMethod;
      case Vocabulary.r2_DP:
        return r2;
      case Vocabulary.skipColumns_DP:
        return skipColumns;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.namespace_DP:
        namespace = $value as String;
        return;
      case Vocabulary.inputFileUris_DP:
        inputFileUris.setValues($value as Iterable<String>);
        return;
      case Vocabulary.inputDataUri_DP:
        inputDataUri = $value as String;
        return;
      case Vocabulary.outputDataUri_DP:
        outputDataUri.setValues($value as Iterable<String>);
        return;
      case Vocabulary.columns_DP:
        columns.setValues($value as Iterable<String>);
        return;
      case Vocabulary.rows_DP:
        rows.setValues($value as Iterable<String>);
        return;
      case Vocabulary.colors_DP:
        colors.setValues($value as Iterable<String>);
        return;
      case Vocabulary.labels_DP:
        labels.setValues($value as Iterable<String>);
        return;
      case Vocabulary.yAxis_DP:
        yAxis = $value as String;
        return;
      case Vocabulary.xAxis_DP:
        xAxis = $value as String;
        return;
      case Vocabulary.absTol_DP:
        absTol = $value as double;
        return;
      case Vocabulary.relTol_DP:
        relTol = $value as double;
        return;
      case Vocabulary.equalityMethod_DP:
        equalityMethod = $value as String;
        return;
      case Vocabulary.r2_DP:
        r2 = $value as double;
        return;
      case Vocabulary.skipColumns_DP:
        skipColumns.setValues($value as Iterable<String>);
        return;
      case Vocabulary.propertyValues_OP:
        propertyValues.setValues($value as Iterable<PropertyValue>);
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
  OperatorUnitTest copy() => OperatorUnitTest.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorUnitTest_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorUnitTest_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.namespace_DP] = namespace;
    m[Vocabulary.propertyValues_OP] = propertyValues.toJson();
    m[Vocabulary.inputFileUris_DP] = inputFileUris;
    m[Vocabulary.inputDataUri_DP] = inputDataUri;
    m[Vocabulary.outputDataUri_DP] = outputDataUri;
    m[Vocabulary.columns_DP] = columns;
    m[Vocabulary.rows_DP] = rows;
    m[Vocabulary.colors_DP] = colors;
    m[Vocabulary.labels_DP] = labels;
    m[Vocabulary.yAxis_DP] = yAxis;
    m[Vocabulary.xAxis_DP] = xAxis;
    m[Vocabulary.absTol_DP] = absTol;
    m[Vocabulary.relTol_DP] = relTol;
    m[Vocabulary.equalityMethod_DP] = equalityMethod;
    m[Vocabulary.r2_DP] = r2;
    m[Vocabulary.skipColumns_DP] = skipColumns;
    return m;
  }
}
