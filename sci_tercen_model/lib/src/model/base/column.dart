part of sci_model_base;

class ColumnBase extends ColumnSchema {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.cValues_OP,
    Vocabulary.values_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  CValues _cValues;
  dynamic _values;

  ColumnBase()
      : _values = null,
        _cValues = CValues() {
    _cValues.parent = this;
  }

  ColumnBase.json(Map m)
      : _values = base.defaultValue(
            m[Vocabulary.values_DP] as dynamic, base.dynamic_DefaultFactory),
        _cValues =
            CValuesBase._createFromJson(m[Vocabulary.cValues_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Column_CLASS, m);
    _cValues.parent = this;
  }

  static Column createFromJson(Map m) => ColumnBase.fromJson(m);
  static Column _createFromJson(Map? m) =>
      m == null ? Column() : ColumnBase.fromJson(m);
  static Column fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Column_CLASS:
        return Column.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Column_CLASS;
  dynamic get values => _values;

  set values(dynamic $o) {
    if ($o == _values) return;
    var $old = _values;
    _values = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.values_DP, $old, _values));
    }
  }

  CValues get cValues => _cValues;

  set cValues(CValues $o) {
    if ($o == _cValues) return;
    _cValues.parent = null;
    $o.parent = this;
    var $old = _cValues;
    _cValues = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cValues_OP, $old, _cValues));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.cValues_OP:
        return cValues;
      case Vocabulary.values_DP:
        return values;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.values_DP:
        values = $value as dynamic;
        return;
      case Vocabulary.cValues_OP:
        cValues = $value as CValues;
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
  Column copy() => Column.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Column_CLASS;
    if (subKind != null && subKind != Vocabulary.Column_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.cValues_OP] = cValues.toJson();
    m[Vocabulary.values_DP] = values;
    return m;
  }
}
