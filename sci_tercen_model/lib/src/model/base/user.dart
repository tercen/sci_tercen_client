part of sci_model_base;

class UserBase extends Document {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.email_DP,
    Vocabulary.isValidated_DP,
    Vocabulary.domain_DP,
    Vocabulary.roles_DP,
    Vocabulary.teamAcl_OP,
    Vocabulary.invitedByUsername_DP,
    Vocabulary.invitationCounts_DP,
    Vocabulary.maxInvitation_DP,
    Vocabulary.billingInfo_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _email;
  bool _isValidated;
  String _domain;
  final base.ListChangedBase<String> roles;
  Acl _teamAcl;
  String _invitedByUsername;
  int _invitationCounts;
  int _maxInvitation;
  BillingInfo _billingInfo;

  UserBase()
      : _email = "",
        _isValidated = true,
        _domain = "",
        roles = base.ListChangedBase<String>(),
        _invitedByUsername = "",
        _invitationCounts = 0,
        _maxInvitation = 0,
        _teamAcl = Acl(),
        _billingInfo = BillingInfo() {
    roles.parent = this;
    _teamAcl.parent = this;
    _billingInfo.parent = this;
  }

  UserBase.json(Map m)
      : _email = base.defaultValue(
            m[Vocabulary.email_DP] as String?, base.String_DefaultFactory),
        _isValidated = base.defaultValue(
            m[Vocabulary.isValidated_DP] as bool?, base.bool_DefaultFactory),
        _domain = base.defaultValue(
            m[Vocabulary.domain_DP] as String?, base.String_DefaultFactory),
        roles = base.ListChangedBase<String>(m[Vocabulary.roles_DP] as List?),
        _invitedByUsername = base.defaultValue(
            m[Vocabulary.invitedByUsername_DP] as String?,
            base.String_DefaultFactory),
        _invitationCounts = base.defaultValue(
            m[Vocabulary.invitationCounts_DP] as int?, base.int_DefaultFactory),
        _maxInvitation = base.defaultValue(
            m[Vocabulary.maxInvitation_DP] as int?, base.int_DefaultFactory),
        _teamAcl = AclBase._createFromJson(m[Vocabulary.teamAcl_OP] as Map?),
        _billingInfo = BillingInfoBase._createFromJson(
            m[Vocabulary.billingInfo_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.User_CLASS, m);
    roles.parent = this;
    _teamAcl.parent = this;
    _billingInfo.parent = this;
  }

  static User createFromJson(Map m) => UserBase.fromJson(m);
  static User _createFromJson(Map? m) =>
      m == null ? User() : UserBase.fromJson(m);
  static User fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.User_CLASS:
        return User.json(m);
      case Vocabulary.Team_CLASS:
        return Team.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.User_CLASS;
  String get email => _email;

  set email(String $o) {
    if ($o == _email) return;
    var $old = _email;
    _email = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.email_DP, $old, _email));
    }
  }

  bool get isValidated => _isValidated;

  set isValidated(bool $o) {
    if ($o == _isValidated) return;
    var $old = _isValidated;
    _isValidated = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isValidated_DP, $old, _isValidated));
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

  String get invitedByUsername => _invitedByUsername;

  set invitedByUsername(String $o) {
    if ($o == _invitedByUsername) return;
    var $old = _invitedByUsername;
    _invitedByUsername = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.invitedByUsername_DP, $old, _invitedByUsername));
    }
  }

  int get invitationCounts => _invitationCounts;

  set invitationCounts(int $o) {
    if ($o == _invitationCounts) return;
    var $old = _invitationCounts;
    _invitationCounts = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.invitationCounts_DP, $old, _invitationCounts));
    }
  }

  int get maxInvitation => _maxInvitation;

  set maxInvitation(int $o) {
    if ($o == _maxInvitation) return;
    var $old = _maxInvitation;
    _maxInvitation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.maxInvitation_DP, $old, _maxInvitation));
    }
  }

  Acl get teamAcl => _teamAcl;

  set teamAcl(Acl $o) {
    if ($o == _teamAcl) return;
    _teamAcl.parent = null;
    $o.parent = this;
    var $old = _teamAcl;
    _teamAcl = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.teamAcl_OP, $old, _teamAcl));
    }
  }

  BillingInfo get billingInfo => _billingInfo;

  set billingInfo(BillingInfo $o) {
    if ($o == _billingInfo) return;
    _billingInfo.parent = null;
    $o.parent = this;
    var $old = _billingInfo;
    _billingInfo = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.billingInfo_OP, $old, _billingInfo));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.email_DP:
        return email;
      case Vocabulary.isValidated_DP:
        return isValidated;
      case Vocabulary.domain_DP:
        return domain;
      case Vocabulary.roles_DP:
        return roles;
      case Vocabulary.teamAcl_OP:
        return teamAcl;
      case Vocabulary.invitedByUsername_DP:
        return invitedByUsername;
      case Vocabulary.invitationCounts_DP:
        return invitationCounts;
      case Vocabulary.maxInvitation_DP:
        return maxInvitation;
      case Vocabulary.billingInfo_OP:
        return billingInfo;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.email_DP:
        email = $value as String;
        return;
      case Vocabulary.isValidated_DP:
        isValidated = $value as bool;
        return;
      case Vocabulary.domain_DP:
        domain = $value as String;
        return;
      case Vocabulary.roles_DP:
        roles.setValues($value as Iterable<String>);
        return;
      case Vocabulary.invitedByUsername_DP:
        invitedByUsername = $value as String;
        return;
      case Vocabulary.invitationCounts_DP:
        invitationCounts = $value as int;
        return;
      case Vocabulary.maxInvitation_DP:
        maxInvitation = $value as int;
        return;
      case Vocabulary.teamAcl_OP:
        teamAcl = $value as Acl;
        return;
      case Vocabulary.billingInfo_OP:
        billingInfo = $value as BillingInfo;
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
  User copy() => User.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.User_CLASS;
    if (subKind != null && subKind != Vocabulary.User_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.email_DP] = email;
    m[Vocabulary.isValidated_DP] = isValidated;
    m[Vocabulary.domain_DP] = domain;
    m[Vocabulary.roles_DP] = roles;
    m[Vocabulary.teamAcl_OP] = teamAcl.toJson();
    m[Vocabulary.invitedByUsername_DP] = invitedByUsername;
    m[Vocabulary.invitationCounts_DP] = invitationCounts;
    m[Vocabulary.maxInvitation_DP] = maxInvitation;
    m[Vocabulary.billingInfo_OP] = billingInfo.toJson();
    return m;
  }
}
