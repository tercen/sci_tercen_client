part of sci_model_base;

class GroupStepBase extends RelationStep {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.appId_DP,
    Vocabulary.appName_DP,
    Vocabulary.version_DP,
    Vocabulary.offset_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _appId;
  String _appName;
  String _version;
  Point _offset;

  GroupStepBase()
      : _appId = "",
        _appName = "",
        _version = "",
        _offset = Point() {
    _offset.parent = this;
  }

  GroupStepBase.json(Map m)
      : _appId = base.defaultValue(
            m[Vocabulary.appId_DP] as String?, base.String_DefaultFactory),
        _appName = base.defaultValue(
            m[Vocabulary.appName_DP] as String?, base.String_DefaultFactory),
        _version = base.defaultValue(
            m[Vocabulary.version_DP] as String?, base.String_DefaultFactory),
        _offset = PointBase._createFromJson(m[Vocabulary.offset_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GroupStep_CLASS, m);
    _offset.parent = this;
  }

  static GroupStep createFromJson(Map m) => GroupStepBase.fromJson(m);
  static GroupStep _createFromJson(Map? m) =>
      m == null ? GroupStep() : GroupStepBase.fromJson(m);
  static GroupStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GroupStep_CLASS:
        return GroupStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GroupStep_CLASS;
  String get appId => _appId;

  set appId(String $o) {
    if ($o == _appId) return;
    var $old = _appId;
    _appId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.appId_DP, $old, _appId));
    }
  }

  String get appName => _appName;

  set appName(String $o) {
    if ($o == _appName) return;
    var $old = _appName;
    _appName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.appName_DP, $old, _appName));
    }
  }

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

  Point get offset => _offset;

  set offset(Point $o) {
    if ($o == _offset) return;
    _offset.parent = null;
    $o.parent = this;
    var $old = _offset;
    _offset = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.offset_OP, $old, _offset));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.appId_DP:
        return appId;
      case Vocabulary.appName_DP:
        return appName;
      case Vocabulary.version_DP:
        return version;
      case Vocabulary.offset_OP:
        return offset;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.appId_DP:
        appId = $value as String;
        return;
      case Vocabulary.appName_DP:
        appName = $value as String;
        return;
      case Vocabulary.version_DP:
        version = $value as String;
        return;
      case Vocabulary.offset_OP:
        offset = $value as Point;
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
  GroupStep copy() => GroupStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GroupStep_CLASS;
    if (subKind != null && subKind != Vocabulary.GroupStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.appId_DP] = appId;
    m[Vocabulary.appName_DP] = appName;
    m[Vocabulary.version_DP] = version;
    m[Vocabulary.offset_OP] = offset.toJson();
    return m;
  }
}
