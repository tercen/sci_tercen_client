part of sci_model_base;

class TypedIntValueBase extends TypedValue {
  static const List<String> PROPERTY_NAMES = [Vocabulary.value_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _value;

  TypedIntValueBase() : _value = 0;
  TypedIntValueBase.json(Map m)
      : _value = base.defaultValue(
            m[Vocabulary.value_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TypedIntValue_CLASS, m);
  }

  static TypedIntValue createFromJson(Map m) => TypedIntValueBase.fromJson(m);
  static TypedIntValue fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TypedIntValue_CLASS:
        return TypedIntValue.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TypedIntValue_CLASS;
  int get value => _value;

  set value(int $o) {
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
        value = $value as int;
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
  TypedIntValue copy() => TypedIntValue.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TypedIntValue_CLASS;
    if (subKind != null && subKind != Vocabulary.TypedIntValue_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.value_DP] = value;
    return m;
  }
}
