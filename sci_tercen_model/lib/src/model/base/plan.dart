part of sci_model_base;

class PlanBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.displayName_DP,
    Vocabulary.paymentProviderPlanId_DP,
    Vocabulary.descriptions_DP,
    Vocabulary.price_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  String _displayName;
  String _paymentProviderPlanId;
  final base.ListChangedBase<String> descriptions;
  double _price;

  PlanBase()
      : _name = "",
        _displayName = "",
        _paymentProviderPlanId = "",
        descriptions = base.ListChangedBase<String>(),
        _price = 0.0 {
    descriptions.parent = this;
  }

  PlanBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _displayName = base.defaultValue(
            m[Vocabulary.displayName_DP] as String?,
            base.String_DefaultFactory),
        _paymentProviderPlanId = base.defaultValue(
            m[Vocabulary.paymentProviderPlanId_DP] as String?,
            base.String_DefaultFactory),
        descriptions = base.ListChangedBase<String>(
            m[Vocabulary.descriptions_DP] as List?),
        _price = base.defaultDouble(m[Vocabulary.price_DP] as num?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Plan_CLASS, m);
    descriptions.parent = this;
  }

  static Plan createFromJson(Map m) => PlanBase.fromJson(m);
  static Plan fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Plan_CLASS:
        return Plan.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Plan_CLASS;
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

  String get displayName => _displayName;

  set displayName(String $o) {
    if ($o == _displayName) return;
    var $old = _displayName;
    _displayName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.displayName_DP, $old, _displayName));
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

  double get price => _price;

  set price(double $o) {
    if ($o == _price) return;
    var $old = _price;
    _price = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.price_DP, $old, _price));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.displayName_DP:
        return displayName;
      case Vocabulary.paymentProviderPlanId_DP:
        return paymentProviderPlanId;
      case Vocabulary.descriptions_DP:
        return descriptions;
      case Vocabulary.price_DP:
        return price;
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
      case Vocabulary.displayName_DP:
        displayName = $value as String;
        return;
      case Vocabulary.paymentProviderPlanId_DP:
        paymentProviderPlanId = $value as String;
        return;
      case Vocabulary.descriptions_DP:
        descriptions.setValues($value as Iterable<String>);
        return;
      case Vocabulary.price_DP:
        price = $value as double;
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
  Plan copy() => Plan.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Plan_CLASS;
    if (subKind != null && subKind != Vocabulary.Plan_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.displayName_DP] = displayName;
    m[Vocabulary.paymentProviderPlanId_DP] = paymentProviderPlanId;
    m[Vocabulary.descriptions_DP] = descriptions;
    m[Vocabulary.price_DP] = price;
    return m;
  }
}
