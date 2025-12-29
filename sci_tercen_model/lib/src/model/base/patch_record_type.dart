part of sci_model_base;

class PatchRecordTypeBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  PatchRecordTypeBase();
  PatchRecordTypeBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PatchRecordType_CLASS, m);
  }

  static PatchRecordType createFromJson(Map m) =>
      PatchRecordTypeBase.fromJson(m);
  static PatchRecordType fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PatchRecordType_CLASS:
        return PatchRecordType.json(m);
      case Vocabulary.PatchRecordListRemove_CLASS:
        return PatchRecordListRemove.json(m);
      case Vocabulary.PatchRecordListAdd_CLASS:
        return PatchRecordListAdd.json(m);
      case Vocabulary.PatchRecordListClear_CLASS:
        return PatchRecordListClear.json(m);
      case Vocabulary.PatchRecordListInsert_CLASS:
        return PatchRecordListInsert.json(m);
      case Vocabulary.PatchRecordSet_CLASS:
        return PatchRecordSet.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PatchRecordType_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  PatchRecordType copy() => PatchRecordType.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PatchRecordType_CLASS;
    if (subKind != null && subKind != Vocabulary.PatchRecordType_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
