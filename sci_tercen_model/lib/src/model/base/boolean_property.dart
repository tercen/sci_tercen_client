part of sci_model_base;

class BooleanPropertyBase extends Property {
  static const List<String> PROPERTY_NAMES = [Vocabulary.defaultValue_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  bool _defaultValue;

  BooleanPropertyBase() : _defaultValue = true;
  BooleanPropertyBase.json(Map m)
      : _defaultValue = base.defaultValue(
            m[Vocabulary.defaultValue_DP] as bool?, base.bool_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.BooleanProperty_CLASS, m);
  }

  static BooleanProperty createFromJson(Map m) =>
      BooleanPropertyBase.fromJson(m);
  static BooleanProperty _createFromJson(Map? m) =>
      m == null ? BooleanProperty() : BooleanPropertyBase.fromJson(m);
  static BooleanProperty fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.BooleanProperty_CLASS:
        return BooleanProperty.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.BooleanProperty_CLASS;
  bool get defaultValue => _defaultValue;

  set defaultValue(bool $o) {
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
        defaultValue = $value as bool;
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
  BooleanProperty copy() => BooleanProperty.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.BooleanProperty_CLASS;
    if (subKind != null && subKind != Vocabulary.BooleanProperty_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.defaultValue_DP] = defaultValue;
    return m;
  }
}
