part of sci_model_base;

class TypedBoolBase extends TypedValue {
  static const List<String> PROPERTY_NAMES = [Vocabulary.value_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  bool _value;

  TypedBoolBase() : _value = true;
  TypedBoolBase.json(Map m)
      : _value = base.defaultValue(
            m[Vocabulary.value_DP] as bool?, base.bool_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TypedBool_CLASS, m);
  }

  static TypedBool createFromJson(Map m) => TypedBoolBase.fromJson(m);
  static TypedBool fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TypedBool_CLASS:
        return TypedBool.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TypedBool_CLASS;
  bool get value => _value;

  set value(bool $o) {
    if ($o == _value) return;
    var $old = _value;
    _value = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.value_DP, $old, _value));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.value_DP:
        return value;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.value_DP:
        value = $value as bool;
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
  TypedBool copy() => TypedBool.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TypedBool_CLASS;
    if (subKind != null && subKind != Vocabulary.TypedBool_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.value_DP] = value;
    return m;
  }
}
