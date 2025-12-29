part of sci_model_base;

class ImportGitDatasetTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.url_OP,
    Vocabulary.version_DP,
    Vocabulary.gitToken_DP,
    Vocabulary.schemaId_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.schemaId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("TableSchema", Vocabulary.schemaId_DP, isComposite: false)
  ];
  Url _url;
  String _version;
  String _gitToken;
  String _schemaId;

  ImportGitDatasetTaskBase()
      : _version = "",
        _gitToken = "",
        _schemaId = "",
        _url = Url() {
    _url.parent = this;
  }

  ImportGitDatasetTaskBase.json(Map m)
      : _version = base.defaultValue(
            m[Vocabulary.version_DP] as String?, base.String_DefaultFactory),
        _gitToken = base.defaultValue(
            m[Vocabulary.gitToken_DP] as String?, base.String_DefaultFactory),
        _schemaId = base.defaultValue(
            m[Vocabulary.schemaId_DP] as String?, base.String_DefaultFactory),
        _url = (m[Vocabulary.url_OP] as Map?) == null
            ? Url()
            : UrlBase.fromJson(m[Vocabulary.url_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ImportGitDatasetTask_CLASS, m);
    _url.parent = this;
  }

  static ImportGitDatasetTask createFromJson(Map m) =>
      ImportGitDatasetTaskBase.fromJson(m);
  static ImportGitDatasetTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ImportGitDatasetTask_CLASS:
        return ImportGitDatasetTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ImportGitDatasetTask_CLASS;
  String get version => _version;

  set version(String $o) {
    if ($o == _version) return;
    var $old = _version;
    _version = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.version_DP, $old, _version));
    }
  }

  String get gitToken => _gitToken;

  set gitToken(String $o) {
    if ($o == _gitToken) return;
    var $old = _gitToken;
    _gitToken = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.gitToken_DP, $old, _gitToken));
    }
  }

  String get schemaId => _schemaId;

  set schemaId(String $o) {
    if ($o == _schemaId) return;
    var $old = _schemaId;
    _schemaId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.schemaId_DP, $old, _schemaId));
    }
  }

  Url get url => _url;

  set url(Url $o) {
    if ($o == _url) return;
    _url.parent = null;
    $o.parent = this;
    var $old = _url;
    _url = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.url_OP, $old, _url));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.url_OP:
        return url;
      case Vocabulary.version_DP:
        return version;
      case Vocabulary.gitToken_DP:
        return gitToken;
      case Vocabulary.schemaId_DP:
        return schemaId;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.version_DP:
        version = $value as String;
        return;
      case Vocabulary.gitToken_DP:
        gitToken = $value as String;
        return;
      case Vocabulary.schemaId_DP:
        schemaId = $value as String;
        return;
      case Vocabulary.url_OP:
        url = $value as Url;
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
  ImportGitDatasetTask copy() => ImportGitDatasetTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ImportGitDatasetTask_CLASS;
    if (subKind != null && subKind != Vocabulary.ImportGitDatasetTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.url_OP] = url.toJson();
    m[Vocabulary.version_DP] = version;
    m[Vocabulary.gitToken_DP] = gitToken;
    m[Vocabulary.schemaId_DP] = schemaId;
    return m;
  }
}
