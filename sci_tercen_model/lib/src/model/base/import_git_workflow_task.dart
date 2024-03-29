part of sci_model_base;

class ImportGitWorkflowTaskBase extends ImportWorkflowTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.url_OP,
    Vocabulary.version_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Url _url;
  String _version;

  ImportGitWorkflowTaskBase()
      : _version = "",
        _url = Url() {
    _url.parent = this;
  }

  ImportGitWorkflowTaskBase.json(Map m)
      : _version = base.defaultValue(
            m[Vocabulary.version_DP] as String?, base.String_DefaultFactory),
        _url = UrlBase._createFromJson(m[Vocabulary.url_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ImportGitWorkflowTask_CLASS, m);
    _url.parent = this;
  }

  static ImportGitWorkflowTask createFromJson(Map m) =>
      ImportGitWorkflowTaskBase.fromJson(m);
  static ImportGitWorkflowTask _createFromJson(Map? m) => m == null
      ? ImportGitWorkflowTask()
      : ImportGitWorkflowTaskBase.fromJson(m);
  static ImportGitWorkflowTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ImportGitWorkflowTask_CLASS:
        return ImportGitWorkflowTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ImportGitWorkflowTask_CLASS;
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
  ImportGitWorkflowTask copy() => ImportGitWorkflowTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ImportGitWorkflowTask_CLASS;
    if (subKind != null && subKind != Vocabulary.ImportGitWorkflowTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.url_OP] = url.toJson();
    m[Vocabulary.version_DP] = version;
    return m;
  }
}
