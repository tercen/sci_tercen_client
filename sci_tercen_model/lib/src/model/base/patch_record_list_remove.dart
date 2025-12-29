part of sci_model_base;

class PatchRecordListRemoveBase extends PatchRecordType {
  static const List<String> PROPERTY_NAMES = [Vocabulary.indexes_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChangedBase<int> indexes;

  PatchRecordListRemoveBase() : indexes = base.ListChangedBase<int>() {
    indexes.parent = this;
  }

  PatchRecordListRemoveBase.json(Map m)
      : indexes = base.ListChangedBase<int>(m[Vocabulary.indexes_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PatchRecordListRemove_CLASS, m);
    indexes.parent = this;
  }

  static PatchRecordListRemove createFromJson(Map m) =>
      PatchRecordListRemoveBase.fromJson(m);
  static PatchRecordListRemove fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PatchRecordListRemove_CLASS:
        return PatchRecordListRemove.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PatchRecordListRemove_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.indexes_DP:
        return indexes;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.indexes_DP:
        indexes.setValues($value as Iterable<int>);
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
  PatchRecordListRemove copy() => PatchRecordListRemove.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PatchRecordListRemove_CLASS;
    if (subKind != null && subKind != Vocabulary.PatchRecordListRemove_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.indexes_DP] = indexes;
    return m;
  }
}
