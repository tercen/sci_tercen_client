part of sci_model_base;

class DoublePropertyBase extends Property {
  static const List<String> PROPERTY_NAMES = [Vocabulary.defaultValue_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  double _defaultValue;

  DoublePropertyBase() : _defaultValue = 0.0;
  DoublePropertyBase.json(Map m)
      : _defaultValue =
            base.defaultDouble(m[Vocabulary.defaultValue_DP] as num?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.DoubleProperty_CLASS, m);
  }

  static DoubleProperty createFromJson(Map m) => DoublePropertyBase.fromJson(m);
  static DoubleProperty fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.DoubleProperty_CLASS:
        return DoubleProperty.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.DoubleProperty_CLASS;
  double get defaultValue => _defaultValue;

  set defaultValue(double $o) {
    if ($o == _defaultValue) return;
    var $old = _defaultValue;
    _defaultValue = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.defaultValue_DP, $old, _defaultValue));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.defaultValue_DP:
        return defaultValue;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.defaultValue_DP:
        defaultValue = $value as double;
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
  DoubleProperty copy() => DoubleProperty.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.DoubleProperty_CLASS;
    if (subKind != null && subKind != Vocabulary.DoubleProperty_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.defaultValue_DP] = defaultValue;
    return m;
  }
}
