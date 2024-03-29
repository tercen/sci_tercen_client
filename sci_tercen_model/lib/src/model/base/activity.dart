part of sci_model_base;

class ActivityBase extends PersistentObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.type_DP,
    Vocabulary.objectKind_DP,
    Vocabulary.date_OP,
    Vocabulary.teamId_DP,
    Vocabulary.projectId_DP,
    Vocabulary.userId_DP,
    Vocabulary.projectName_DP,
    Vocabulary.isPublic_DP,
    Vocabulary.properties_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [
    Vocabulary.teamId_DP,
    Vocabulary.projectId_DP,
    Vocabulary.userId_DP
  ];
  static const List<base.RefId> REF_IDS = [
    base.RefId("User", Vocabulary.teamId_DP, isComposite: false),
    base.RefId("Project", Vocabulary.projectId_DP, isComposite: false),
    base.RefId("User", Vocabulary.userId_DP, isComposite: false)
  ];
  String _type;
  String _objectKind;
  Date _date;
  String _teamId;
  String _projectId;
  String _userId;
  String _projectName;
  bool _isPublic;
  final base.ListChanged<Pair> properties;

  ActivityBase()
      : _type = "",
        _objectKind = "",
        _teamId = "",
        _projectId = "",
        _userId = "",
        _projectName = "",
        _isPublic = true,
        _date = Date(),
        properties = base.ListChanged<Pair>() {
    _date.parent = this;
    properties.parent = this;
  }

  ActivityBase.json(Map m)
      : _type = base.defaultValue(
            m[Vocabulary.type_DP] as String?, base.String_DefaultFactory),
        _objectKind = base.defaultValue(
            m[Vocabulary.objectKind_DP] as String?, base.String_DefaultFactory),
        _teamId = base.defaultValue(
            m[Vocabulary.teamId_DP] as String?, base.String_DefaultFactory),
        _projectId = base.defaultValue(
            m[Vocabulary.projectId_DP] as String?, base.String_DefaultFactory),
        _userId = base.defaultValue(
            m[Vocabulary.userId_DP] as String?, base.String_DefaultFactory),
        _projectName = base.defaultValue(
            m[Vocabulary.projectName_DP] as String?,
            base.String_DefaultFactory),
        _isPublic = base.defaultValue(
            m[Vocabulary.isPublic_DP] as bool?, base.bool_DefaultFactory),
        _date = DateBase._createFromJson(m[Vocabulary.date_OP] as Map?),
        properties = base.ListChanged<Pair>.from(
            m[Vocabulary.properties_OP] as List?, PairBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Activity_CLASS, m);
    _date.parent = this;
    properties.parent = this;
  }

  static Activity createFromJson(Map m) => ActivityBase.fromJson(m);
  static Activity _createFromJson(Map? m) =>
      m == null ? Activity() : ActivityBase.fromJson(m);
  static Activity fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Activity_CLASS:
        return Activity.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Activity_CLASS;
  String get type => _type;

  set type(String $o) {
    if ($o == _type) return;
    var $old = _type;
    _type = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.type_DP, $old, _type));
    }
  }

  String get objectKind => _objectKind;

  set objectKind(String $o) {
    if ($o == _objectKind) return;
    var $old = _objectKind;
    _objectKind = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.objectKind_DP, $old, _objectKind));
    }
  }

  String get teamId => _teamId;

  set teamId(String $o) {
    if ($o == _teamId) return;
    var $old = _teamId;
    _teamId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.teamId_DP, $old, _teamId));
    }
  }

  String get projectId => _projectId;

  set projectId(String $o) {
    if ($o == _projectId) return;
    var $old = _projectId;
    _projectId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.projectId_DP, $old, _projectId));
    }
  }

  String get userId => _userId;

  set userId(String $o) {
    if ($o == _userId) return;
    var $old = _userId;
    _userId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.userId_DP, $old, _userId));
    }
  }

  String get projectName => _projectName;

  set projectName(String $o) {
    if ($o == _projectName) return;
    var $old = _projectName;
    _projectName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.projectName_DP, $old, _projectName));
    }
  }

  bool get isPublic => _isPublic;

  set isPublic(bool $o) {
    if ($o == _isPublic) return;
    var $old = _isPublic;
    _isPublic = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isPublic_DP, $old, _isPublic));
    }
  }

  Date get date => _date;

  set date(Date $o) {
    if ($o == _date) return;
    _date.parent = null;
    $o.parent = this;
    var $old = _date;
    _date = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.date_OP, $old, _date));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.type_DP:
        return type;
      case Vocabulary.objectKind_DP:
        return objectKind;
      case Vocabulary.date_OP:
        return date;
      case Vocabulary.teamId_DP:
        return teamId;
      case Vocabulary.projectId_DP:
        return projectId;
      case Vocabulary.userId_DP:
        return userId;
      case Vocabulary.projectName_DP:
        return projectName;
      case Vocabulary.isPublic_DP:
        return isPublic;
      case Vocabulary.properties_OP:
        return properties;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.type_DP:
        type = $value as String;
        return;
      case Vocabulary.objectKind_DP:
        objectKind = $value as String;
        return;
      case Vocabulary.teamId_DP:
        teamId = $value as String;
        return;
      case Vocabulary.projectId_DP:
        projectId = $value as String;
        return;
      case Vocabulary.userId_DP:
        userId = $value as String;
        return;
      case Vocabulary.projectName_DP:
        projectName = $value as String;
        return;
      case Vocabulary.isPublic_DP:
        isPublic = $value as bool;
        return;
      case Vocabulary.date_OP:
        date = $value as Date;
        return;
      case Vocabulary.properties_OP:
        properties.setValues($value as Iterable<Pair>);
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
  Activity copy() => Activity.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Activity_CLASS;
    if (subKind != null && subKind != Vocabulary.Activity_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.type_DP] = type;
    m[Vocabulary.objectKind_DP] = objectKind;
    m[Vocabulary.date_OP] = date.toJson();
    m[Vocabulary.teamId_DP] = teamId;
    m[Vocabulary.projectId_DP] = projectId;
    m[Vocabulary.userId_DP] = userId;
    m[Vocabulary.projectName_DP] = projectName;
    m[Vocabulary.isPublic_DP] = isPublic;
    m[Vocabulary.properties_OP] = properties.toJson();
    return m;
  }
}
