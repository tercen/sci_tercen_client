part of sci_model_base;

class TokenBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.userId_DP,
    Vocabulary.expiry_OP,
    Vocabulary.token_DP,
    Vocabulary.domain_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.userId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("User", Vocabulary.userId_DP, isComposite: false)
  ];
  String _userId;
  Date _expiry;
  String _token;
  String _domain;

  TokenBase()
      : _userId = "",
        _token = "",
        _domain = "",
        _expiry = Date() {
    _expiry.parent = this;
  }

  TokenBase.json(Map m)
      : _userId = base.defaultValue(
            m[Vocabulary.userId_DP] as String?, base.String_DefaultFactory),
        _token = base.defaultValue(
            m[Vocabulary.token_DP] as String?, base.String_DefaultFactory),
        _domain = base.defaultValue(
            m[Vocabulary.domain_DP] as String?, base.String_DefaultFactory),
        _expiry = (m[Vocabulary.expiry_OP] as Map?) == null
            ? Date()
            : DateBase.fromJson(m[Vocabulary.expiry_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Token_CLASS, m);
    _expiry.parent = this;
  }

  static Token createFromJson(Map m) => TokenBase.fromJson(m);
  static Token fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Token_CLASS:
        return Token.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Token_CLASS;
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

  String get token => _token;

  set token(String $o) {
    if ($o == _token) return;
    var $old = _token;
    _token = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.token_DP, $old, _token));
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

  Date get expiry => _expiry;

  set expiry(Date $o) {
    if ($o == _expiry) return;
    _expiry.parent = null;
    $o.parent = this;
    var $old = _expiry;
    _expiry = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.expiry_OP, $old, _expiry));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.userId_DP:
        return userId;
      case Vocabulary.expiry_OP:
        return expiry;
      case Vocabulary.token_DP:
        return token;
      case Vocabulary.domain_DP:
        return domain;
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
      case Vocabulary.token_DP:
        token = $value as String;
        return;
      case Vocabulary.domain_DP:
        domain = $value as String;
        return;
      case Vocabulary.expiry_OP:
        expiry = $value as Date;
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
  Token copy() => Token.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Token_CLASS;
    if (subKind != null && subKind != Vocabulary.Token_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.userId_DP] = userId;
    m[Vocabulary.expiry_OP] = expiry.toJson();
    m[Vocabulary.token_DP] = token;
    m[Vocabulary.domain_DP] = domain;
    return m;
  }
}
