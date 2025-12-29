part of sci_model_base;

class PatchRecordListInsertBase extends PatchRecordType {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.index_DP,
    Vocabulary.value_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _index;
  TypedValue _value;

  PatchRecordListInsertBase()
      : _index = 0,
        _value = TypedValue() {
    _value.parent = this;
  }

  PatchRecordListInsertBase.json(Map m)
      : _index = base.defaultValue(
            m[Vocabulary.index_DP] as int?, base.int_DefaultFactory),
        _value = (m[Vocabulary.value_OP] as Map?) == null
            ? TypedValue()
            : TypedValueBase.fromJson(m[Vocabulary.value_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PatchRecordListInsert_CLASS, m);
    _value.parent = this;
  }

  static PatchRecordListInsert createFromJson(Map m) =>
      PatchRecordListInsertBase.fromJson(m);
  static PatchRecordListInsert fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PatchRecordListInsert_CLASS:
        return PatchRecordListInsert.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PatchRecordListInsert_CLASS;
  int get index => _index;

  set index(int $o) {
    if ($o == _index) return;
    var $old = _index;
    _index = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.index_DP, $old, _index));
    }
  }

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

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.index_DP:
        return index;
      case Vocabulary.value_OP:
        return value;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.index_DP:
        index = $value as int;
        return;
      case Vocabulary.value_OP:
        value = $value as TypedValue;
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
  PatchRecordListInsert copy() => PatchRecordListInsert.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PatchRecordListInsert_CLASS;
    if (subKind != null && subKind != Vocabulary.PatchRecordListInsert_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.index_DP] = index;
    m[Vocabulary.value_OP] = value.toJson();
    return m;
  }
}
