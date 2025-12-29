part of sci_model_base;

class ViesInfoBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.countryCode_DP,
    Vocabulary.vatNumber_DP,
    Vocabulary.requestDate_DP,
    Vocabulary.valid_DP,
    Vocabulary.name_DP,
    Vocabulary.address_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _countryCode;
  String _vatNumber;
  String _requestDate;
  bool _valid;
  String _name;
  String _address;

  ViesInfoBase()
      : _countryCode = "",
        _vatNumber = "",
        _requestDate = "",
        _valid = true,
        _name = "",
        _address = "";
  ViesInfoBase.json(Map m)
      : _countryCode = base.defaultValue(
            m[Vocabulary.countryCode_DP] as String?,
            base.String_DefaultFactory),
        _vatNumber = base.defaultValue(
            m[Vocabulary.vatNumber_DP] as String?, base.String_DefaultFactory),
        _requestDate = base.defaultValue(
            m[Vocabulary.requestDate_DP] as String?,
            base.String_DefaultFactory),
        _valid = base.defaultValue(
            m[Vocabulary.valid_DP] as bool?, base.bool_DefaultFactory),
        _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _address = base.defaultValue(
            m[Vocabulary.address_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ViesInfo_CLASS, m);
  }

  static ViesInfo createFromJson(Map m) => ViesInfoBase.fromJson(m);
  static ViesInfo fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ViesInfo_CLASS:
        return ViesInfo.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ViesInfo_CLASS;
  String get countryCode => _countryCode;

  set countryCode(String $o) {
    if ($o == _countryCode) return;
    var $old = _countryCode;
    _countryCode = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.countryCode_DP, $old, _countryCode));
    }
  }

  String get vatNumber => _vatNumber;

  set vatNumber(String $o) {
    if ($o == _vatNumber) return;
    var $old = _vatNumber;
    _vatNumber = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.vatNumber_DP, $old, _vatNumber));
    }
  }

  String get requestDate => _requestDate;

  set requestDate(String $o) {
    if ($o == _requestDate) return;
    var $old = _requestDate;
    _requestDate = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.requestDate_DP, $old, _requestDate));
    }
  }

  bool get valid => _valid;

  set valid(bool $o) {
    if ($o == _valid) return;
    var $old = _valid;
    _valid = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.valid_DP, $old, _valid));
    }
  }

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

  String get address => _address;

  set address(String $o) {
    if ($o == _address) return;
    var $old = _address;
    _address = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.address_DP, $old, _address));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.countryCode_DP:
        return countryCode;
      case Vocabulary.vatNumber_DP:
        return vatNumber;
      case Vocabulary.requestDate_DP:
        return requestDate;
      case Vocabulary.valid_DP:
        return valid;
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.address_DP:
        return address;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.countryCode_DP:
        countryCode = $value as String;
        return;
      case Vocabulary.vatNumber_DP:
        vatNumber = $value as String;
        return;
      case Vocabulary.requestDate_DP:
        requestDate = $value as String;
        return;
      case Vocabulary.valid_DP:
        valid = $value as bool;
        return;
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.address_DP:
        address = $value as String;
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
  ViesInfo copy() => ViesInfo.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ViesInfo_CLASS;
    if (subKind != null && subKind != Vocabulary.ViesInfo_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.countryCode_DP] = countryCode;
    m[Vocabulary.vatNumber_DP] = vatNumber;
    m[Vocabulary.requestDate_DP] = requestDate;
    m[Vocabulary.valid_DP] = valid;
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.address_DP] = address;
    return m;
  }
}
