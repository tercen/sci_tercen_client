part of sci_model_base;

class PatchRecordListAddBase extends PatchRecordType {
  static const List<String> PROPERTY_NAMES = [Vocabulary.value_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<TypedValue> value;

  PatchRecordListAddBase() : value = base.ListChanged<TypedValue>() {
    value.parent = this;
  }

  PatchRecordListAddBase.json(Map m)
      : value = base.ListChanged<TypedValue>.from(
            m[Vocabulary.value_OP] as List?, TypedValueBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PatchRecordListAdd_CLASS, m);
    value.parent = this;
  }

  static PatchRecordListAdd createFromJson(Map m) =>
      PatchRecordListAddBase.fromJson(m);
  static PatchRecordListAdd fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PatchRecordListAdd_CLASS:
        return PatchRecordListAdd.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PatchRecordListAdd_CLASS;

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
        value.setValues($value as Iterable<TypedValue>);
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
  PatchRecordListAdd copy() => PatchRecordListAdd.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PatchRecordListAdd_CLASS;
    if (subKind != null && subKind != Vocabulary.PatchRecordListAdd_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.value_OP] = value.toJson();
    return m;
  }
}
