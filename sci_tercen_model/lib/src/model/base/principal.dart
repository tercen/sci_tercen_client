part of sci_model_base;

class PrincipalBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.principalId_DP];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.principalId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("User", Vocabulary.principalId_DP, isComposite: false)
  ];
  String _principalId;

  PrincipalBase() : _principalId = "";
  PrincipalBase.json(Map m)
      : _principalId = base.defaultValue(
            m[Vocabulary.principalId_DP] as String?,
            base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Principal_CLASS, m);
  }

  static Principal createFromJson(Map m) => PrincipalBase.fromJson(m);
  static Principal _createFromJson(Map? m) =>
      m == null ? Principal() : PrincipalBase.fromJson(m);
  static Principal fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Principal_CLASS:
        return Principal.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Principal_CLASS;
  String get principalId => _principalId;

  set principalId(String $o) {
    if ($o == _principalId) return;
    var $old = _principalId;
    _principalId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.principalId_DP, $old, _principalId));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.principalId_DP:
        return principalId;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.principalId_DP:
        principalId = $value as String;
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
  Principal copy() => Principal.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Principal_CLASS;
    if (subKind != null && subKind != Vocabulary.Principal_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.principalId_DP] = principalId;
    return m;
  }
}
