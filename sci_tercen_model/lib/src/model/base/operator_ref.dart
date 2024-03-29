part of sci_model_base;

class OperatorRefBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.version_DP,
    Vocabulary.operatorId_DP,
    Vocabulary.operatorKind_DP,
    Vocabulary.propertyValues_OP,
    Vocabulary.url_OP,
    Vocabulary.operatorSpec_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.operatorId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Operator", Vocabulary.operatorId_DP, isComposite: false)
  ];
  String _name;
  String _version;
  String _operatorId;
  String _operatorKind;
  final base.ListChanged<PropertyValue> propertyValues;
  Url _url;
  OperatorSpec _operatorSpec;

  OperatorRefBase()
      : _name = "",
        _version = "",
        _operatorId = "",
        _operatorKind = "",
        propertyValues = base.ListChanged<PropertyValue>(),
        _url = Url(),
        _operatorSpec = OperatorSpec() {
    propertyValues.parent = this;
    _url.parent = this;
    _operatorSpec.parent = this;
  }

  OperatorRefBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _version = base.defaultValue(
            m[Vocabulary.version_DP] as String?, base.String_DefaultFactory),
        _operatorId = base.defaultValue(
            m[Vocabulary.operatorId_DP] as String?, base.String_DefaultFactory),
        _operatorKind = base.defaultValue(
            m[Vocabulary.operatorKind_DP] as String?,
            base.String_DefaultFactory),
        propertyValues = base.ListChanged<PropertyValue>.from(
            m[Vocabulary.propertyValues_OP] as List?,
            PropertyValueBase.createFromJson),
        _url = UrlBase._createFromJson(m[Vocabulary.url_OP] as Map?),
        _operatorSpec = OperatorSpecBase._createFromJson(
            m[Vocabulary.operatorSpec_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorRef_CLASS, m);
    propertyValues.parent = this;
    _url.parent = this;
    _operatorSpec.parent = this;
  }

  static OperatorRef createFromJson(Map m) => OperatorRefBase.fromJson(m);
  static OperatorRef _createFromJson(Map? m) =>
      m == null ? OperatorRef() : OperatorRefBase.fromJson(m);
  static OperatorRef fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorRef_CLASS:
        return OperatorRef.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorRef_CLASS;
  String get name => _name;

  set name(String $o) {
    if ($o == _name) return;
    var $old = _name;
    _name = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.name_DP, $old, _name));
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

  String get operatorKind => _operatorKind;

  set operatorKind(String $o) {
    if ($o == _operatorKind) return;
    var $old = _operatorKind;
    _operatorKind = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.operatorKind_DP, $old, _operatorKind));
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

  OperatorSpec get operatorSpec => _operatorSpec;

  set operatorSpec(OperatorSpec $o) {
    if ($o == _operatorSpec) return;
    _operatorSpec.parent = null;
    $o.parent = this;
    var $old = _operatorSpec;
    _operatorSpec = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.operatorSpec_OP, $old, _operatorSpec));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.version_DP:
        return version;
      case Vocabulary.operatorId_DP:
        return operatorId;
      case Vocabulary.operatorKind_DP:
        return operatorKind;
      case Vocabulary.propertyValues_OP:
        return propertyValues;
      case Vocabulary.url_OP:
        return url;
      case Vocabulary.operatorSpec_OP:
        return operatorSpec;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.version_DP:
        version = $value as String;
        return;
      case Vocabulary.operatorId_DP:
        operatorId = $value as String;
        return;
      case Vocabulary.operatorKind_DP:
        operatorKind = $value as String;
        return;
      case Vocabulary.propertyValues_OP:
        propertyValues.setValues($value as Iterable<PropertyValue>);
        return;
      case Vocabulary.url_OP:
        url = $value as Url;
        return;
      case Vocabulary.operatorSpec_OP:
        operatorSpec = $value as OperatorSpec;
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
  OperatorRef copy() => OperatorRef.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorRef_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorRef_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.version_DP] = version;
    m[Vocabulary.operatorId_DP] = operatorId;
    m[Vocabulary.operatorKind_DP] = operatorKind;
    m[Vocabulary.propertyValues_OP] = propertyValues.toJson();
    m[Vocabulary.url_OP] = url.toJson();
    m[Vocabulary.operatorSpec_OP] = operatorSpec.toJson();
    return m;
  }
}
