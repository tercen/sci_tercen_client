part of sci_model_base;

class CreateGitOperatorTaskBase extends Task {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.url_OP,
    Vocabulary.version_DP,
    Vocabulary.operatorId_DP,
    Vocabulary.gitToken_DP,
    Vocabulary.testRequired_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.operatorId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Operator", Vocabulary.operatorId_DP, isComposite: false)
  ];
  Url _url;
  String _version;
  String _operatorId;
  String _gitToken;
  bool _testRequired;

  CreateGitOperatorTaskBase()
      : _version = "",
        _operatorId = "",
        _gitToken = "",
        _testRequired = true,
        _url = Url() {
    _url.parent = this;
  }

  CreateGitOperatorTaskBase.json(Map m)
      : _version = base.defaultValue(
            m[Vocabulary.version_DP] as String?, base.String_DefaultFactory),
        _operatorId = base.defaultValue(
            m[Vocabulary.operatorId_DP] as String?, base.String_DefaultFactory),
        _gitToken = base.defaultValue(
            m[Vocabulary.gitToken_DP] as String?, base.String_DefaultFactory),
        _testRequired = base.defaultValue(
            m[Vocabulary.testRequired_DP] as bool?, base.bool_DefaultFactory),
        _url = UrlBase._createFromJson(m[Vocabulary.url_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CreateGitOperatorTask_CLASS, m);
    _url.parent = this;
  }

  static CreateGitOperatorTask createFromJson(Map m) =>
      CreateGitOperatorTaskBase.fromJson(m);
  static CreateGitOperatorTask _createFromJson(Map? m) => m == null
      ? CreateGitOperatorTask()
      : CreateGitOperatorTaskBase.fromJson(m);
  static CreateGitOperatorTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CreateGitOperatorTask_CLASS:
        return CreateGitOperatorTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CreateGitOperatorTask_CLASS;
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

  String get operatorId => _operatorId;

  set operatorId(String $o) {
    if ($o == _operatorId) return;
    var $old = _operatorId;
    _operatorId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.operatorId_DP, $old, _operatorId));
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

  bool get testRequired => _testRequired;

  set testRequired(bool $o) {
    if ($o == _testRequired) return;
    var $old = _testRequired;
    _testRequired = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.testRequired_DP, $old, _testRequired));
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
      case Vocabulary.operatorId_DP:
        return operatorId;
      case Vocabulary.gitToken_DP:
        return gitToken;
      case Vocabulary.testRequired_DP:
        return testRequired;
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
      case Vocabulary.operatorId_DP:
        operatorId = $value as String;
        return;
      case Vocabulary.gitToken_DP:
        gitToken = $value as String;
        return;
      case Vocabulary.testRequired_DP:
        testRequired = $value as bool;
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
  CreateGitOperatorTask copy() => CreateGitOperatorTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CreateGitOperatorTask_CLASS;
    if (subKind != null && subKind != Vocabulary.CreateGitOperatorTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.url_OP] = url.toJson();
    m[Vocabulary.version_DP] = version;
    m[Vocabulary.operatorId_DP] = operatorId;
    m[Vocabulary.gitToken_DP] = gitToken;
    m[Vocabulary.testRequired_DP] = testRequired;
    return m;
  }
}
