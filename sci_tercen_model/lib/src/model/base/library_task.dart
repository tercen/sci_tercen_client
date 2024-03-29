part of sci_model_base;

class LibraryTaskBase extends Task {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  LibraryTaskBase();
  LibraryTaskBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.LibraryTask_CLASS, m);
  }

  static LibraryTask createFromJson(Map m) => LibraryTaskBase.fromJson(m);
  static LibraryTask _createFromJson(Map? m) =>
      m == null ? LibraryTask() : LibraryTaskBase.fromJson(m);
  static LibraryTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.LibraryTask_CLASS:
        return LibraryTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.LibraryTask_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  LibraryTask copy() => LibraryTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.LibraryTask_CLASS;
    if (subKind != null && subKind != Vocabulary.LibraryTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
