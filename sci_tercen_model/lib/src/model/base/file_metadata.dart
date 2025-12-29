part of sci_model_base;

class FileMetadataBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.contentType_DP,
    Vocabulary.cacheControl_DP,
    Vocabulary.contentEncoding_DP,
    Vocabulary.contentLanguage_DP,
    Vocabulary.md5Hash_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _contentType;
  String _cacheControl;
  String _contentEncoding;
  String _contentLanguage;
  String _md5Hash;

  FileMetadataBase()
      : _contentType = "",
        _cacheControl = "",
        _contentEncoding = "",
        _contentLanguage = "",
        _md5Hash = "";
  FileMetadataBase.json(Map m)
      : _contentType = base.defaultValue(
            m[Vocabulary.contentType_DP] as String?,
            base.String_DefaultFactory),
        _cacheControl = base.defaultValue(
            m[Vocabulary.cacheControl_DP] as String?,
            base.String_DefaultFactory),
        _contentEncoding = base.defaultValue(
            m[Vocabulary.contentEncoding_DP] as String?,
            base.String_DefaultFactory),
        _contentLanguage = base.defaultValue(
            m[Vocabulary.contentLanguage_DP] as String?,
            base.String_DefaultFactory),
        _md5Hash = base.defaultValue(
            m[Vocabulary.md5Hash_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FileMetadata_CLASS, m);
  }

  static FileMetadata createFromJson(Map m) => FileMetadataBase.fromJson(m);
  static FileMetadata fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FileMetadata_CLASS:
        return FileMetadata.json(m);
      case Vocabulary.CSVFileMetadata_CLASS:
        return CSVFileMetadata.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FileMetadata_CLASS;
  String get contentType => _contentType;

  set contentType(String $o) {
    if ($o == _contentType) return;
    var $old = _contentType;
    _contentType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.contentType_DP, $old, _contentType));
    }
  }

  String get cacheControl => _cacheControl;

  set cacheControl(String $o) {
    if ($o == _cacheControl) return;
    var $old = _cacheControl;
    _cacheControl = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cacheControl_DP, $old, _cacheControl));
    }
  }

  String get contentEncoding => _contentEncoding;

  set contentEncoding(String $o) {
    if ($o == _contentEncoding) return;
    var $old = _contentEncoding;
    _contentEncoding = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.contentEncoding_DP, $old, _contentEncoding));
    }
  }

  String get contentLanguage => _contentLanguage;

  set contentLanguage(String $o) {
    if ($o == _contentLanguage) return;
    var $old = _contentLanguage;
    _contentLanguage = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.contentLanguage_DP, $old, _contentLanguage));
    }
  }

  String get md5Hash => _md5Hash;

  set md5Hash(String $o) {
    if ($o == _md5Hash) return;
    var $old = _md5Hash;
    _md5Hash = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.md5Hash_DP, $old, _md5Hash));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.contentType_DP:
        return contentType;
      case Vocabulary.cacheControl_DP:
        return cacheControl;
      case Vocabulary.contentEncoding_DP:
        return contentEncoding;
      case Vocabulary.contentLanguage_DP:
        return contentLanguage;
      case Vocabulary.md5Hash_DP:
        return md5Hash;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.contentType_DP:
        contentType = $value as String;
        return;
      case Vocabulary.cacheControl_DP:
        cacheControl = $value as String;
        return;
      case Vocabulary.contentEncoding_DP:
        contentEncoding = $value as String;
        return;
      case Vocabulary.contentLanguage_DP:
        contentLanguage = $value as String;
        return;
      case Vocabulary.md5Hash_DP:
        md5Hash = $value as String;
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
  FileMetadata copy() => FileMetadata.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FileMetadata_CLASS;
    if (subKind != null && subKind != Vocabulary.FileMetadata_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.contentType_DP] = contentType;
    m[Vocabulary.cacheControl_DP] = cacheControl;
    m[Vocabulary.contentEncoding_DP] = contentEncoding;
    m[Vocabulary.contentLanguage_DP] = contentLanguage;
    m[Vocabulary.md5Hash_DP] = md5Hash;
    return m;
  }
}
