part of sci_model_base;

class RunWebAppTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.operatorId_DP,
    Vocabulary.cubeQueryTaskId_DP,
    Vocabulary.url_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _operatorId;
  String _cubeQueryTaskId;
  Url _url;

  RunWebAppTaskBase()
      : _operatorId = "",
        _cubeQueryTaskId = "",
        _url = Url() {
    _url.parent = this;
  }

  RunWebAppTaskBase.json(Map m)
      : _operatorId = base.defaultValue(
            m[Vocabulary.operatorId_DP] as String?, base.String_DefaultFactory),
        _cubeQueryTaskId = base.defaultValue(
            m[Vocabulary.cubeQueryTaskId_DP] as String?,
            base.String_DefaultFactory),
        _url = UrlBase._createFromJson(m[Vocabulary.url_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RunWebAppTask_CLASS, m);
    _url.parent = this;
  }

  static RunWebAppTask createFromJson(Map m) => RunWebAppTaskBase.fromJson(m);
  static RunWebAppTask _createFromJson(Map? m) =>
      m == null ? RunWebAppTask() : RunWebAppTaskBase.fromJson(m);
  static RunWebAppTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RunWebAppTask_CLASS:
        return RunWebAppTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RunWebAppTask_CLASS;
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

  String get cubeQueryTaskId => _cubeQueryTaskId;

  set cubeQueryTaskId(String $o) {
    if ($o == _cubeQueryTaskId) return;
    var $old = _cubeQueryTaskId;
    _cubeQueryTaskId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cubeQueryTaskId_DP, $old, _cubeQueryTaskId));
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
      case Vocabulary.operatorId_DP:
        return operatorId;
      case Vocabulary.cubeQueryTaskId_DP:
        return cubeQueryTaskId;
      case Vocabulary.url_OP:
        return url;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.operatorId_DP:
        operatorId = $value as String;
        return;
      case Vocabulary.cubeQueryTaskId_DP:
        cubeQueryTaskId = $value as String;
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
  RunWebAppTask copy() => RunWebAppTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RunWebAppTask_CLASS;
    if (subKind != null && subKind != Vocabulary.RunWebAppTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.operatorId_DP] = operatorId;
    m[Vocabulary.cubeQueryTaskId_DP] = cubeQueryTaskId;
    m[Vocabulary.url_OP] = url.toJson();
    return m;
  }
}
