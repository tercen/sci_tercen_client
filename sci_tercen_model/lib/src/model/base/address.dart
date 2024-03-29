part of sci_model_base;

class AddressBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.country_DP,
    Vocabulary.state_DP,
    Vocabulary.city_DP,
    Vocabulary.zipCode_DP,
    Vocabulary.address1_DP,
    Vocabulary.address2_DP,
    Vocabulary.phone_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _country;
  String _state;
  String _city;
  String _zipCode;
  String _address1;
  String _address2;
  String _phone;

  AddressBase()
      : _country = "",
        _state = "",
        _city = "",
        _zipCode = "",
        _address1 = "",
        _address2 = "",
        _phone = "";
  AddressBase.json(Map m)
      : _country = base.defaultValue(
            m[Vocabulary.country_DP] as String?, base.String_DefaultFactory),
        _state = base.defaultValue(
            m[Vocabulary.state_DP] as String?, base.String_DefaultFactory),
        _city = base.defaultValue(
            m[Vocabulary.city_DP] as String?, base.String_DefaultFactory),
        _zipCode = base.defaultValue(
            m[Vocabulary.zipCode_DP] as String?, base.String_DefaultFactory),
        _address1 = base.defaultValue(
            m[Vocabulary.address1_DP] as String?, base.String_DefaultFactory),
        _address2 = base.defaultValue(
            m[Vocabulary.address2_DP] as String?, base.String_DefaultFactory),
        _phone = base.defaultValue(
            m[Vocabulary.phone_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Address_CLASS, m);
  }

  static Address createFromJson(Map m) => AddressBase.fromJson(m);
  static Address _createFromJson(Map? m) =>
      m == null ? Address() : AddressBase.fromJson(m);
  static Address fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Address_CLASS:
        return Address.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Address_CLASS;
  String get country => _country;

  set country(String $o) {
    if ($o == _country) return;
    var $old = _country;
    _country = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.country_DP, $old, _country));
    }
  }

  String get state => _state;

  set state(String $o) {
    if ($o == _state) return;
    var $old = _state;
    _state = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.state_DP, $old, _state));
    }
  }

  String get city => _city;

  set city(String $o) {
    if ($o == _city) return;
    var $old = _city;
    _city = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.city_DP, $old, _city));
    }
  }

  String get zipCode => _zipCode;

  set zipCode(String $o) {
    if ($o == _zipCode) return;
    var $old = _zipCode;
    _zipCode = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.zipCode_DP, $old, _zipCode));
    }
  }

  String get address1 => _address1;

  set address1(String $o) {
    if ($o == _address1) return;
    var $old = _address1;
    _address1 = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.address1_DP, $old, _address1));
    }
  }

  String get address2 => _address2;

  set address2(String $o) {
    if ($o == _address2) return;
    var $old = _address2;
    _address2 = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.address2_DP, $old, _address2));
    }
  }

  String get phone => _phone;

  set phone(String $o) {
    if ($o == _phone) return;
    var $old = _phone;
    _phone = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.phone_DP, $old, _phone));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.country_DP:
        return country;
      case Vocabulary.state_DP:
        return state;
      case Vocabulary.city_DP:
        return city;
      case Vocabulary.zipCode_DP:
        return zipCode;
      case Vocabulary.address1_DP:
        return address1;
      case Vocabulary.address2_DP:
        return address2;
      case Vocabulary.phone_DP:
        return phone;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.country_DP:
        country = $value as String;
        return;
      case Vocabulary.state_DP:
        state = $value as String;
        return;
      case Vocabulary.city_DP:
        city = $value as String;
        return;
      case Vocabulary.zipCode_DP:
        zipCode = $value as String;
        return;
      case Vocabulary.address1_DP:
        address1 = $value as String;
        return;
      case Vocabulary.address2_DP:
        address2 = $value as String;
        return;
      case Vocabulary.phone_DP:
        phone = $value as String;
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
  Address copy() => Address.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Address_CLASS;
    if (subKind != null && subKind != Vocabulary.Address_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.country_DP] = country;
    m[Vocabulary.state_DP] = state;
    m[Vocabulary.city_DP] = city;
    m[Vocabulary.zipCode_DP] = zipCode;
    m[Vocabulary.address1_DP] = address1;
    m[Vocabulary.address2_DP] = address2;
    m[Vocabulary.phone_DP] = phone;
    return m;
  }
}
