part of sci_model_base;

class AclContextBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.username_DP,
    Vocabulary.domain_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _username;
  String _domain;

  AclContextBase()
      : _username = "",
        _domain = "";
  AclContextBase.json(Map m)
      : _username = base.defaultValue(
            m[Vocabulary.username_DP] as String?, base.String_DefaultFactory),
        _domain = base.defaultValue(
            m[Vocabulary.domain_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.AclContext_CLASS, m);
  }

  static AclContext createFromJson(Map m) => AclContextBase.fromJson(m);
  static AclContext fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.AclContext_CLASS:
        return AclContext.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.AclContext_CLASS;
  String get username => _username;

  set username(String $o) {
    if ($o == _username) return;
    var $old = _username;
    _username = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.username_DP, $old, _username));
    }
  }

  String get domain => _domain;

  set domain(String $o) {
    if ($o == _domain) return;
    var $old = _domain;
    _domain = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.domain_DP, $old, _domain));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.username_DP:
        return username;
      case Vocabulary.domain_DP:
        return domain;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.username_DP:
        username = $value as String;
        return;
      case Vocabulary.domain_DP:
        domain = $value as String;
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
  AclContext copy() => AclContext.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.AclContext_CLASS;
    if (subKind != null && subKind != Vocabulary.AclContext_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.username_DP] = username;
    m[Vocabulary.domain_DP] = domain;
    return m;
  }
}
