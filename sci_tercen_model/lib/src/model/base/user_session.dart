part of sci_model_base;

class UserSessionBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.serverVersion_OP,
    Vocabulary.user_OP,
    Vocabulary.token_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Version _serverVersion;
  User _user;
  Token _token;

  UserSessionBase()
      : _serverVersion = Version(),
        _user = User(),
        _token = Token() {
    _serverVersion.parent = this;
    _user.parent = this;
    _token.parent = this;
  }

  UserSessionBase.json(Map m)
      : _serverVersion = (m[Vocabulary.serverVersion_OP] as Map?) == null
            ? Version()
            : VersionBase.fromJson(m[Vocabulary.serverVersion_OP] as Map),
        _user = (m[Vocabulary.user_OP] as Map?) == null
            ? User()
            : UserBase.fromJson(m[Vocabulary.user_OP] as Map),
        _token = (m[Vocabulary.token_OP] as Map?) == null
            ? Token()
            : TokenBase.fromJson(m[Vocabulary.token_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.UserSession_CLASS, m);
    _serverVersion.parent = this;
    _user.parent = this;
    _token.parent = this;
  }

  static UserSession createFromJson(Map m) => UserSessionBase.fromJson(m);
  static UserSession fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.UserSession_CLASS:
        return UserSession.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.UserSession_CLASS;
  Version get serverVersion => _serverVersion;

  set serverVersion(Version $o) {
    if ($o == _serverVersion) return;
    _serverVersion.parent = null;
    $o.parent = this;
    var $old = _serverVersion;
    _serverVersion = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.serverVersion_OP, $old, _serverVersion));
    }
  }

  User get user => _user;

  set user(User $o) {
    if ($o == _user) return;
    _user.parent = null;
    $o.parent = this;
    var $old = _user;
    _user = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.user_OP, $old, _user));
    }
  }

  Token get token => _token;

  set token(Token $o) {
    if ($o == _token) return;
    _token.parent = null;
    $o.parent = this;
    var $old = _token;
    _token = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.token_OP, $old, _token));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.serverVersion_OP:
        return serverVersion;
      case Vocabulary.user_OP:
        return user;
      case Vocabulary.token_OP:
        return token;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.serverVersion_OP:
        serverVersion = $value as Version;
        return;
      case Vocabulary.user_OP:
        user = $value as User;
        return;
      case Vocabulary.token_OP:
        token = $value as Token;
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
  UserSession copy() => UserSession.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.UserSession_CLASS;
    if (subKind != null && subKind != Vocabulary.UserSession_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.serverVersion_OP] = serverVersion.toJson();
    m[Vocabulary.user_OP] = user.toJson();
    m[Vocabulary.token_OP] = token.toJson();
    return m;
  }
}
