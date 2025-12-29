part of sci_model_base;

class TypedObjectBase extends TypedValue {
  static const List<String> PROPERTY_NAMES = [Vocabulary.value_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  SciObject _value;

  TypedObjectBase() : _value = SciObject() {
    _value.parent = this;
  }

  TypedObjectBase.json(Map m)
      : _value = (m[Vocabulary.value_OP] as Map?) == null
            ? SciObject()
            : SciObjectBase.fromJson(m[Vocabulary.value_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TypedObject_CLASS, m);
    _value.parent = this;
  }

  static TypedObject createFromJson(Map m) => TypedObjectBase.fromJson(m);
  static TypedObject fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TypedObject_CLASS:
        return TypedObject.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TypedObject_CLASS;
  SciObject get value => _value;

  set value(SciObject $o) {
    if ($o == _value) return;
    _value.parent = null;
    $o.parent = this;
    var $old = _value;
    _value = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.value_OP, $old, _value));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.value_OP:
        return value;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.value_OP:
        value = $value as SciObject;
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
  TypedObject copy() => TypedObject.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TypedObject_CLASS;
    if (subKind != null && subKind != Vocabulary.TypedObject_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.value_OP] = value.toJson();
    return m;
  }
}
