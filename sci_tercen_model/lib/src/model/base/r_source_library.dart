part of sci_model_base;

class RSourceLibraryBase extends RLibrary {
  static const List<String> PROPERTY_NAMES = [Vocabulary.fileId_DP];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.fileId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("FileDocument", Vocabulary.fileId_DP, isComposite: true)
  ];
  String _fileId;

  RSourceLibraryBase() : _fileId = "";
  RSourceLibraryBase.json(Map m)
      : _fileId = base.defaultValue(
            m[Vocabulary.fileId_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RSourceLibrary_CLASS, m);
  }

  static RSourceLibrary createFromJson(Map m) => RSourceLibraryBase.fromJson(m);
  static RSourceLibrary _createFromJson(Map? m) =>
      m == null ? RSourceLibrary() : RSourceLibraryBase.fromJson(m);
  static RSourceLibrary fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RSourceLibrary_CLASS:
        return RSourceLibrary.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RSourceLibrary_CLASS;
  String get fileId => _fileId;

  set fileId(String $o) {
    if ($o == _fileId) return;
    var $old = _fileId;
    _fileId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.fileId_DP, $old, _fileId));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.fileId_DP:
        return fileId;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.fileId_DP:
        fileId = $value as String;
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
  RSourceLibrary copy() => RSourceLibrary.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RSourceLibrary_CLASS;
    if (subKind != null && subKind != Vocabulary.RSourceLibrary_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.fileId_DP] = fileId;
    return m;
  }
}
