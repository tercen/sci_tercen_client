part of sci_model_base;

class FolderDocumentBase extends ProjectDocument {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  FolderDocumentBase();
  FolderDocumentBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FolderDocument_CLASS, m);
  }

  static FolderDocument createFromJson(Map m) => FolderDocumentBase.fromJson(m);
  static FolderDocument _createFromJson(Map? m) =>
      m == null ? FolderDocument() : FolderDocumentBase.fromJson(m);
  static FolderDocument fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FolderDocument_CLASS:
        return FolderDocument.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FolderDocument_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  FolderDocument copy() => FolderDocument.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FolderDocument_CLASS;
    if (subKind != null && subKind != Vocabulary.FolderDocument_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
