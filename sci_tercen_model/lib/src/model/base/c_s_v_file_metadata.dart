part of sci_model_base;

class CSVFileMetadataBase extends FileMetadata {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.separator_DP,
    Vocabulary.quote_DP,
    Vocabulary.headers_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _separator;
  String _quote;
  bool _headers;

  CSVFileMetadataBase()
      : _separator = "",
        _quote = "",
        _headers = true;
  CSVFileMetadataBase.json(Map m)
      : _separator = base.defaultValue(
            m[Vocabulary.separator_DP] as String?, base.String_DefaultFactory),
        _quote = base.defaultValue(
            m[Vocabulary.quote_DP] as String?, base.String_DefaultFactory),
        _headers = base.defaultValue(
            m[Vocabulary.headers_DP] as bool?, base.bool_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CSVFileMetadata_CLASS, m);
  }

  static CSVFileMetadata createFromJson(Map m) =>
      CSVFileMetadataBase.fromJson(m);
  static CSVFileMetadata _createFromJson(Map? m) =>
      m == null ? CSVFileMetadata() : CSVFileMetadataBase.fromJson(m);
  static CSVFileMetadata fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CSVFileMetadata_CLASS:
        return CSVFileMetadata.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CSVFileMetadata_CLASS;
  String get separator => _separator;

  set separator(String $o) {
    if ($o == _separator) return;
    var $old = _separator;
    _separator = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.separator_DP, $old, _separator));
    }
  }

  String get quote => _quote;

  set quote(String $o) {
    if ($o == _quote) return;
    var $old = _quote;
    _quote = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.quote_DP, $old, _quote));
    }
  }

  bool get headers => _headers;

  set headers(bool $o) {
    if ($o == _headers) return;
    var $old = _headers;
    _headers = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.headers_DP, $old, _headers));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.separator_DP:
        return separator;
      case Vocabulary.quote_DP:
        return quote;
      case Vocabulary.headers_DP:
        return headers;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.separator_DP:
        separator = $value as String;
        return;
      case Vocabulary.quote_DP:
        quote = $value as String;
        return;
      case Vocabulary.headers_DP:
        headers = $value as bool;
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
  CSVFileMetadata copy() => CSVFileMetadata.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CSVFileMetadata_CLASS;
    if (subKind != null && subKind != Vocabulary.CSVFileMetadata_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.separator_DP] = separator;
    m[Vocabulary.quote_DP] = quote;
    m[Vocabulary.headers_DP] = headers;
    return m;
  }
}
