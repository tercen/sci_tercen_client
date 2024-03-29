part of sci_model_base;

class StringPropertyBase extends Property {
  static const List<String> PROPERTY_NAMES = [Vocabulary.defaultValue_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _defaultValue;

  StringPropertyBase() : _defaultValue = "";
  StringPropertyBase.json(Map m)
      : _defaultValue = base.defaultValue(
            m[Vocabulary.defaultValue_DP] as String?,
            base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.StringProperty_CLASS, m);
  }

  static StringProperty createFromJson(Map m) => StringPropertyBase.fromJson(m);
  static StringProperty _createFromJson(Map? m) =>
      m == null ? StringProperty() : StringPropertyBase.fromJson(m);
  static StringProperty fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.StringProperty_CLASS:
        return StringProperty.json(m);
      case Vocabulary.EnumeratedProperty_CLASS:
        return EnumeratedProperty.json(m);
      case Vocabulary.FactorsProperty_CLASS:
        return FactorsProperty.json(m);
      case Vocabulary.FormulaProperty_CLASS:
        return FormulaProperty.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.StringProperty_CLASS;
  String get defaultValue => _defaultValue;

  set defaultValue(String $o) {
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
        defaultValue = $value as String;
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
  StringProperty copy() => StringProperty.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.StringProperty_CLASS;
    if (subKind != null && subKind != Vocabulary.StringProperty_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.defaultValue_DP] = defaultValue;
    return m;
  }
}
