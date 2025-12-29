part of sci_model_base;

class TypedDoubleBase extends TypedValue {
  static const List<String> PROPERTY_NAMES = [Vocabulary.value_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  double _value;

  TypedDoubleBase() : _value = 0.0;
  TypedDoubleBase.json(Map m)
      : _value = base.defaultDouble(m[Vocabulary.value_DP] as num?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TypedDouble_CLASS, m);
  }

  static TypedDouble createFromJson(Map m) => TypedDoubleBase.fromJson(m);
  static TypedDouble fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TypedDouble_CLASS:
        return TypedDouble.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TypedDouble_CLASS;
  double get value => _value;

  set value(double $o) {
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
        value = $value as double;
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
  TypedDouble copy() => TypedDouble.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TypedDouble_CLASS;
    if (subKind != null && subKind != Vocabulary.TypedDouble_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.value_DP] = value;
    return m;
  }
}
