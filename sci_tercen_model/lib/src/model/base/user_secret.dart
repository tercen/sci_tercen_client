part of sci_model_base;

class UserSecretBase extends PersistentObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.userId_DP,
    Vocabulary.salt_DP,
    Vocabulary.hashPassword_DP,
    Vocabulary.meta_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.userId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("User", Vocabulary.userId_DP, isComposite: false)
  ];
  String _userId;
  String _salt;
  String _hashPassword;
  final base.ListChanged<Pair> meta;

  UserSecretBase()
      : _userId = "",
        _salt = "",
        _hashPassword = "",
        meta = base.ListChanged<Pair>() {
    meta.parent = this;
  }

  UserSecretBase.json(Map m)
      : _userId = base.defaultValue(
            m[Vocabulary.userId_DP] as String?, base.String_DefaultFactory),
        _salt = base.defaultValue(
            m[Vocabulary.salt_DP] as String?, base.String_DefaultFactory),
        _hashPassword = base.defaultValue(
            m[Vocabulary.hashPassword_DP] as String?,
            base.String_DefaultFactory),
        meta = base.ListChanged<Pair>.from(
            m[Vocabulary.meta_OP] as List?, PairBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.UserSecret_CLASS, m);
    meta.parent = this;
  }

  static UserSecret createFromJson(Map m) => UserSecretBase.fromJson(m);
  static UserSecret fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.UserSecret_CLASS:
        return UserSecret.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.UserSecret_CLASS;
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

  String get salt => _salt;

  set salt(String $o) {
    if ($o == _salt) return;
    var $old = _salt;
    _salt = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.salt_DP, $old, _salt));
    }
  }

  String get hashPassword => _hashPassword;

  set hashPassword(String $o) {
    if ($o == _hashPassword) return;
    var $old = _hashPassword;
    _hashPassword = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.hashPassword_DP, $old, _hashPassword));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.userId_DP:
        return userId;
      case Vocabulary.salt_DP:
        return salt;
      case Vocabulary.hashPassword_DP:
        return hashPassword;
      case Vocabulary.meta_OP:
        return meta;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.userId_DP:
        userId = $value as String;
        return;
      case Vocabulary.salt_DP:
        salt = $value as String;
        return;
      case Vocabulary.hashPassword_DP:
        hashPassword = $value as String;
        return;
      case Vocabulary.meta_OP:
        meta.setValues($value as Iterable<Pair>);
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
  UserSecret copy() => UserSecret.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.UserSecret_CLASS;
    if (subKind != null && subKind != Vocabulary.UserSecret_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.userId_DP] = userId;
    m[Vocabulary.salt_DP] = salt;
    m[Vocabulary.hashPassword_DP] = hashPassword;
    m[Vocabulary.meta_OP] = meta.toJson();
    return m;
  }
}
