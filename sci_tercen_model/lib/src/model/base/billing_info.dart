part of sci_model_base;

class BillingInfoBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.firstName_DP,
    Vocabulary.lastName_DP,
    Vocabulary.companyName_DP,
    Vocabulary.taxId_OP,
    Vocabulary.address_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _firstName;
  String _lastName;
  String _companyName;
  TaxId _taxId;
  Address _address;

  BillingInfoBase()
      : _firstName = "",
        _lastName = "",
        _companyName = "",
        _taxId = TaxId(),
        _address = Address() {
    _taxId.parent = this;
    _address.parent = this;
  }

  BillingInfoBase.json(Map m)
      : _firstName = base.defaultValue(
            m[Vocabulary.firstName_DP] as String?, base.String_DefaultFactory),
        _lastName = base.defaultValue(
            m[Vocabulary.lastName_DP] as String?, base.String_DefaultFactory),
        _companyName = base.defaultValue(
            m[Vocabulary.companyName_DP] as String?,
            base.String_DefaultFactory),
        _taxId = TaxIdBase._createFromJson(m[Vocabulary.taxId_OP] as Map?),
        _address =
            AddressBase._createFromJson(m[Vocabulary.address_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.BillingInfo_CLASS, m);
    _taxId.parent = this;
    _address.parent = this;
  }

  static BillingInfo createFromJson(Map m) => BillingInfoBase.fromJson(m);
  static BillingInfo _createFromJson(Map? m) =>
      m == null ? BillingInfo() : BillingInfoBase.fromJson(m);
  static BillingInfo fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.BillingInfo_CLASS:
        return BillingInfo.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.BillingInfo_CLASS;
  String get firstName => _firstName;

  set firstName(String $o) {
    if ($o == _firstName) return;
    var $old = _firstName;
    _firstName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.firstName_DP, $old, _firstName));
    }
  }

  String get lastName => _lastName;

  set lastName(String $o) {
    if ($o == _lastName) return;
    var $old = _lastName;
    _lastName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.lastName_DP, $old, _lastName));
    }
  }

  String get companyName => _companyName;

  set companyName(String $o) {
    if ($o == _companyName) return;
    var $old = _companyName;
    _companyName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.companyName_DP, $old, _companyName));
    }
  }

  TaxId get taxId => _taxId;

  set taxId(TaxId $o) {
    if ($o == _taxId) return;
    _taxId.parent = null;
    $o.parent = this;
    var $old = _taxId;
    _taxId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.taxId_OP, $old, _taxId));
    }
  }

  Address get address => _address;

  set address(Address $o) {
    if ($o == _address) return;
    _address.parent = null;
    $o.parent = this;
    var $old = _address;
    _address = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.address_OP, $old, _address));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.firstName_DP:
        return firstName;
      case Vocabulary.lastName_DP:
        return lastName;
      case Vocabulary.companyName_DP:
        return companyName;
      case Vocabulary.taxId_OP:
        return taxId;
      case Vocabulary.address_OP:
        return address;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.firstName_DP:
        firstName = $value as String;
        return;
      case Vocabulary.lastName_DP:
        lastName = $value as String;
        return;
      case Vocabulary.companyName_DP:
        companyName = $value as String;
        return;
      case Vocabulary.taxId_OP:
        taxId = $value as TaxId;
        return;
      case Vocabulary.address_OP:
        address = $value as Address;
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
  BillingInfo copy() => BillingInfo.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.BillingInfo_CLASS;
    if (subKind != null && subKind != Vocabulary.BillingInfo_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.firstName_DP] = firstName;
    m[Vocabulary.lastName_DP] = lastName;
    m[Vocabulary.companyName_DP] = companyName;
    m[Vocabulary.taxId_OP] = taxId.toJson();
    m[Vocabulary.address_OP] = address.toJson();
    return m;
  }
}
