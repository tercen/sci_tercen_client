part of sci_model_base;

class PatchRecordSetBase extends PatchRecordType {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.value_OP,
    Vocabulary.oldValue_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  static const List<base.PropertyConstraint> CONSTRAINTS = [];
  TypedValue _value;
  TypedValue _oldValue;

  PatchRecordSetBase()
      : _value = TypedValue(),
        _oldValue = TypedValue() {
    _value.parent = this;
    _oldValue.parent = this;
  }

  PatchRecordSetBase.json(Map m)
      : _value = (m[Vocabulary.value_OP] as Map?) == null
            ? TypedValue()
            : TypedValueBase.fromJson(m[Vocabulary.value_OP] as Map),
        _oldValue = (m[Vocabulary.oldValue_OP] as Map?) == null
            ? TypedValue()
            : TypedValueBase.fromJson(m[Vocabulary.oldValue_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PatchRecordSet_CLASS, m);
    _value.parent = this;
    _oldValue.parent = this;
  }

  static PatchRecordSet createFromJson(Map m) => PatchRecordSetBase.fromJson(m);
  static PatchRecordSet fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PatchRecordSet_CLASS:
        return PatchRecordSet.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PatchRecordSet_CLASS;
  TypedValue get value => _value;

  set value(TypedValue $o) {
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

  TypedValue get oldValue => _oldValue;

  set oldValue(TypedValue $o) {
    if ($o == _oldValue) return;
    _oldValue.parent = null;
    $o.parent = this;
    var $old = _oldValue;
    _oldValue = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.oldValue_OP, $old, _oldValue));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.value_OP:
        return value;
      case Vocabulary.oldValue_OP:
        return oldValue;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.value_OP:
        value = $value as TypedValue;
        return;
      case Vocabulary.oldValue_OP:
        oldValue = $value as TypedValue;
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
  Iterable<base.PropertyConstraint> constraints() =>
      super.constraints().followedBy(CONSTRAINTS);

  @override
  PatchRecordSet copy() => PatchRecordSet.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PatchRecordSet_CLASS;
    if (subKind != null && subKind != Vocabulary.PatchRecordSet_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.value_OP] = value.toJson();
    m[Vocabulary.oldValue_OP] = oldValue.toJson();
    return m;
  }
}
