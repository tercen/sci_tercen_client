part of sci_model_base;

class CSVParserParamBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.separator_DP,
    Vocabulary.encoding_DP,
    Vocabulary.quote_DP,
    Vocabulary.hasHeaders_DP,
    Vocabulary.allowMalformed_DP,
    Vocabulary.comment_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _separator;
  String _encoding;
  String _quote;
  bool _hasHeaders;
  bool _allowMalformed;
  String _comment;

  CSVParserParamBase()
      : _separator = "",
        _encoding = "",
        _quote = "",
        _hasHeaders = true,
        _allowMalformed = true,
        _comment = "";
  CSVParserParamBase.json(Map m)
      : _separator = base.defaultValue(
            m[Vocabulary.separator_DP] as String?, base.String_DefaultFactory),
        _encoding = base.defaultValue(
            m[Vocabulary.encoding_DP] as String?, base.String_DefaultFactory),
        _quote = base.defaultValue(
            m[Vocabulary.quote_DP] as String?, base.String_DefaultFactory),
        _hasHeaders = base.defaultValue(
            m[Vocabulary.hasHeaders_DP] as bool?, base.bool_DefaultFactory),
        _allowMalformed = base.defaultValue(
            m[Vocabulary.allowMalformed_DP] as bool?, base.bool_DefaultFactory),
        _comment = base.defaultValue(
            m[Vocabulary.comment_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CSVParserParam_CLASS, m);
  }

  static CSVParserParam createFromJson(Map m) => CSVParserParamBase.fromJson(m);
  static CSVParserParam _createFromJson(Map? m) =>
      m == null ? CSVParserParam() : CSVParserParamBase.fromJson(m);
  static CSVParserParam fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CSVParserParam_CLASS:
        return CSVParserParam.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CSVParserParam_CLASS;
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

  String get encoding => _encoding;

  set encoding(String $o) {
    if ($o == _encoding) return;
    var $old = _encoding;
    _encoding = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.encoding_DP, $old, _encoding));
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

  bool get hasHeaders => _hasHeaders;

  set hasHeaders(bool $o) {
    if ($o == _hasHeaders) return;
    var $old = _hasHeaders;
    _hasHeaders = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.hasHeaders_DP, $old, _hasHeaders));
    }
  }

  bool get allowMalformed => _allowMalformed;

  set allowMalformed(bool $o) {
    if ($o == _allowMalformed) return;
    var $old = _allowMalformed;
    _allowMalformed = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.allowMalformed_DP, $old, _allowMalformed));
    }
  }

  String get comment => _comment;

  set comment(String $o) {
    if ($o == _comment) return;
    var $old = _comment;
    _comment = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.comment_DP, $old, _comment));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.separator_DP:
        return separator;
      case Vocabulary.encoding_DP:
        return encoding;
      case Vocabulary.quote_DP:
        return quote;
      case Vocabulary.hasHeaders_DP:
        return hasHeaders;
      case Vocabulary.allowMalformed_DP:
        return allowMalformed;
      case Vocabulary.comment_DP:
        return comment;
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
      case Vocabulary.encoding_DP:
        encoding = $value as String;
        return;
      case Vocabulary.quote_DP:
        quote = $value as String;
        return;
      case Vocabulary.hasHeaders_DP:
        hasHeaders = $value as bool;
        return;
      case Vocabulary.allowMalformed_DP:
        allowMalformed = $value as bool;
        return;
      case Vocabulary.comment_DP:
        comment = $value as String;
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
  CSVParserParam copy() => CSVParserParam.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CSVParserParam_CLASS;
    if (subKind != null && subKind != Vocabulary.CSVParserParam_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.separator_DP] = separator;
    m[Vocabulary.encoding_DP] = encoding;
    m[Vocabulary.quote_DP] = quote;
    m[Vocabulary.hasHeaders_DP] = hasHeaders;
    m[Vocabulary.allowMalformed_DP] = allowMalformed;
    m[Vocabulary.comment_DP] = comment;
    return m;
  }
}
