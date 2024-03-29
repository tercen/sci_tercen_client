part of sci_model_base;

class SubscriptionPlanBase extends Document {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.providerKey_DP,
    Vocabulary.paymentProviderPlanId_DP,
    Vocabulary.checkoutSessionId_DP,
    Vocabulary.subscriptionId_DP,
    Vocabulary.status_DP,
    Vocabulary.paymentMethodStatus_DP,
    Vocabulary.ip_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _providerKey;
  String _paymentProviderPlanId;
  String _checkoutSessionId;
  String _subscriptionId;
  String _status;
  String _paymentMethodStatus;
  String _ip;

  SubscriptionPlanBase()
      : _providerKey = "",
        _paymentProviderPlanId = "",
        _checkoutSessionId = "",
        _subscriptionId = "",
        _status = "",
        _paymentMethodStatus = "",
        _ip = "";
  SubscriptionPlanBase.json(Map m)
      : _providerKey = base.defaultValue(
            m[Vocabulary.providerKey_DP] as String?,
            base.String_DefaultFactory),
        _paymentProviderPlanId = base.defaultValue(
            m[Vocabulary.paymentProviderPlanId_DP] as String?,
            base.String_DefaultFactory),
        _checkoutSessionId = base.defaultValue(
            m[Vocabulary.checkoutSessionId_DP] as String?,
            base.String_DefaultFactory),
        _subscriptionId = base.defaultValue(
            m[Vocabulary.subscriptionId_DP] as String?,
            base.String_DefaultFactory),
        _status = base.defaultValue(
            m[Vocabulary.status_DP] as String?, base.String_DefaultFactory),
        _paymentMethodStatus = base.defaultValue(
            m[Vocabulary.paymentMethodStatus_DP] as String?,
            base.String_DefaultFactory),
        _ip = base.defaultValue(
            m[Vocabulary.ip_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.SubscriptionPlan_CLASS, m);
  }

  static SubscriptionPlan createFromJson(Map m) =>
      SubscriptionPlanBase.fromJson(m);
  static SubscriptionPlan _createFromJson(Map? m) =>
      m == null ? SubscriptionPlan() : SubscriptionPlanBase.fromJson(m);
  static SubscriptionPlan fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.SubscriptionPlan_CLASS:
        return SubscriptionPlan.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.SubscriptionPlan_CLASS;
  String get providerKey => _providerKey;

  set providerKey(String $o) {
    if ($o == _providerKey) return;
    var $old = _providerKey;
    _providerKey = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.providerKey_DP, $old, _providerKey));
    }
  }

  String get paymentProviderPlanId => _paymentProviderPlanId;

  set paymentProviderPlanId(String $o) {
    if ($o == _paymentProviderPlanId) return;
    var $old = _paymentProviderPlanId;
    _paymentProviderPlanId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(this,
          Vocabulary.paymentProviderPlanId_DP, $old, _paymentProviderPlanId));
    }
  }

  String get checkoutSessionId => _checkoutSessionId;

  set checkoutSessionId(String $o) {
    if ($o == _checkoutSessionId) return;
    var $old = _checkoutSessionId;
    _checkoutSessionId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.checkoutSessionId_DP, $old, _checkoutSessionId));
    }
  }

  String get subscriptionId => _subscriptionId;

  set subscriptionId(String $o) {
    if ($o == _subscriptionId) return;
    var $old = _subscriptionId;
    _subscriptionId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.subscriptionId_DP, $old, _subscriptionId));
    }
  }

  String get status => _status;

  set status(String $o) {
    if ($o == _status) return;
    var $old = _status;
    _status = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.status_DP, $old, _status));
    }
  }

  String get paymentMethodStatus => _paymentMethodStatus;

  set paymentMethodStatus(String $o) {
    if ($o == _paymentMethodStatus) return;
    var $old = _paymentMethodStatus;
    _paymentMethodStatus = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.paymentMethodStatus_DP, $old, _paymentMethodStatus));
    }
  }

  String get ip => _ip;

  set ip(String $o) {
    if ($o == _ip) return;
    var $old = _ip;
    _ip = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.ip_DP, $old, _ip));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.providerKey_DP:
        return providerKey;
      case Vocabulary.paymentProviderPlanId_DP:
        return paymentProviderPlanId;
      case Vocabulary.checkoutSessionId_DP:
        return checkoutSessionId;
      case Vocabulary.subscriptionId_DP:
        return subscriptionId;
      case Vocabulary.status_DP:
        return status;
      case Vocabulary.paymentMethodStatus_DP:
        return paymentMethodStatus;
      case Vocabulary.ip_DP:
        return ip;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.providerKey_DP:
        providerKey = $value as String;
        return;
      case Vocabulary.paymentProviderPlanId_DP:
        paymentProviderPlanId = $value as String;
        return;
      case Vocabulary.checkoutSessionId_DP:
        checkoutSessionId = $value as String;
        return;
      case Vocabulary.subscriptionId_DP:
        subscriptionId = $value as String;
        return;
      case Vocabulary.status_DP:
        status = $value as String;
        return;
      case Vocabulary.paymentMethodStatus_DP:
        paymentMethodStatus = $value as String;
        return;
      case Vocabulary.ip_DP:
        ip = $value as String;
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
  SubscriptionPlan copy() => SubscriptionPlan.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.SubscriptionPlan_CLASS;
    if (subKind != null && subKind != Vocabulary.SubscriptionPlan_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.providerKey_DP] = providerKey;
    m[Vocabulary.paymentProviderPlanId_DP] = paymentProviderPlanId;
    m[Vocabulary.checkoutSessionId_DP] = checkoutSessionId;
    m[Vocabulary.subscriptionId_DP] = subscriptionId;
    m[Vocabulary.status_DP] = status;
    m[Vocabulary.paymentMethodStatus_DP] = paymentMethodStatus;
    m[Vocabulary.ip_DP] = ip;
    return m;
  }
}
