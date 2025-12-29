part of sci_model_base;

class GarbageObjectBase extends PersistentObject {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  GarbageObjectBase();
  GarbageObjectBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GarbageObject_CLASS, m);
  }

  static GarbageObject createFromJson(Map m) => GarbageObjectBase.fromJson(m);
  static GarbageObject fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GarbageObject_CLASS:
        return GarbageObject.json(m);
      case Vocabulary.GarbageTasks_CLASS:
        return GarbageTasks.json(m);
      case Vocabulary.GarbageTasks2_CLASS:
        return GarbageTasks2.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GarbageObject_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  GarbageObject copy() => GarbageObject.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GarbageObject_CLASS;
    if (subKind != null && subKind != Vocabulary.GarbageObject_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
