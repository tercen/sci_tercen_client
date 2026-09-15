part of sci_model_base;

class PatchRecordListClearBase extends PatchRecordType {
  static const List<String> PROPERTY_NAMES = [Vocabulary.items_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  static const List<base.PropertyConstraint> CONSTRAINTS = [];
  final base.ListChanged<TypedValue> items;

  PatchRecordListClearBase() : items = base.ListChanged<TypedValue>() {
    items.parent = this;
  }

  PatchRecordListClearBase.json(Map m)
      : items = base.ListChanged<TypedValue>.from(
            m[Vocabulary.items_OP] as List?, TypedValueBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PatchRecordListClear_CLASS, m);
    items.parent = this;
  }

  static PatchRecordListClear createFromJson(Map m) =>
      PatchRecordListClearBase.fromJson(m);
  static PatchRecordListClear fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PatchRecordListClear_CLASS:
        return PatchRecordListClear.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PatchRecordListClear_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.items_OP:
        return items;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.items_OP:
        items.setValues($value as Iterable<TypedValue>);
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
  PatchRecordListClear copy() => PatchRecordListClear.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PatchRecordListClear_CLASS;
    if (subKind != null && subKind != Vocabulary.PatchRecordListClear_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.items_OP] = items.toJson();
    return m;
  }
}
