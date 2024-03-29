part of sci_model_base;

class FileDocumentBase extends ProjectDocument {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.dataUri_DP,
    Vocabulary.metadata_OP,
    Vocabulary.size_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _dataUri;
  FileMetadata _metadata;
  int _size;

  FileDocumentBase()
      : _dataUri = "",
        _size = 0,
        _metadata = FileMetadata() {
    _metadata.parent = this;
  }

  FileDocumentBase.json(Map m)
      : _dataUri = base.defaultValue(
            m[Vocabulary.dataUri_DP] as String?, base.String_DefaultFactory),
        _size = base.defaultValue(
            m[Vocabulary.size_DP] as int?, base.int_DefaultFactory),
        _metadata =
            FileMetadataBase._createFromJson(m[Vocabulary.metadata_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FileDocument_CLASS, m);
    _metadata.parent = this;
  }

  static FileDocument createFromJson(Map m) => FileDocumentBase.fromJson(m);
  static FileDocument _createFromJson(Map? m) =>
      m == null ? FileDocument() : FileDocumentBase.fromJson(m);
  static FileDocument fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FileDocument_CLASS:
        return FileDocument.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FileDocument_CLASS;
  String get dataUri => _dataUri;

  set dataUri(String $o) {
    if ($o == _dataUri) return;
    var $old = _dataUri;
    _dataUri = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.dataUri_DP, $old, _dataUri));
    }
  }

  int get size => _size;

  set size(int $o) {
    if ($o == _size) return;
    var $old = _size;
    _size = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.size_DP, $old, _size));
    }
  }

  FileMetadata get metadata => _metadata;

  set metadata(FileMetadata $o) {
    if ($o == _metadata) return;
    _metadata.parent = null;
    $o.parent = this;
    var $old = _metadata;
    _metadata = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.metadata_OP, $old, _metadata));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.dataUri_DP:
        return dataUri;
      case Vocabulary.metadata_OP:
        return metadata;
      case Vocabulary.size_DP:
        return size;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.dataUri_DP:
        dataUri = $value as String;
        return;
      case Vocabulary.size_DP:
        size = $value as int;
        return;
      case Vocabulary.metadata_OP:
        metadata = $value as FileMetadata;
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
  FileDocument copy() => FileDocument.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FileDocument_CLASS;
    if (subKind != null && subKind != Vocabulary.FileDocument_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.dataUri_DP] = dataUri;
    m[Vocabulary.metadata_OP] = metadata.toJson();
    m[Vocabulary.size_DP] = size;
    return m;
  }
}
