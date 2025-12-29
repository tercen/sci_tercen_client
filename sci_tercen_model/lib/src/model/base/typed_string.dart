part of sci_model_base;

class TypedStringBase extends TypedValue {
  static const List<String> PROPERTY_NAMES = [Vocabulary.value_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _value;

  TypedStringBase() : _value = "";
  TypedStringBase.json(Map m)
      : _value = base.defaultValue(
            m[Vocabulary.value_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TypedString_CLASS, m);
  }

  static TypedString createFromJson(Map m) => TypedStringBase.fromJson(m);
  static TypedString fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TypedString_CLASS:
        return TypedString.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TypedString_CLASS;
  String get value => _value;

  set value(String $o) {
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
        value = $value as String;
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
  TypedString copy() => TypedString.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TypedString_CLASS;
    if (subKind != null && subKind != Vocabulary.TypedString_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.value_DP] = value;
    return m;
  }
}
