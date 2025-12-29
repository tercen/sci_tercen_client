part of sci_model_base;

class TaxIdBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.type_DP,
    Vocabulary.value_DP,
    Vocabulary.isValid_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _type;
  String _value;
  bool _isValid;

  TaxIdBase()
      : _type = "",
        _value = "",
        _isValid = true;
  TaxIdBase.json(Map m)
      : _type = base.defaultValue(
            m[Vocabulary.type_DP] as String?, base.String_DefaultFactory),
        _value = base.defaultValue(
            m[Vocabulary.value_DP] as String?, base.String_DefaultFactory),
        _isValid = base.defaultValue(
            m[Vocabulary.isValid_DP] as bool?, base.bool_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TaxId_CLASS, m);
  }

  static TaxId createFromJson(Map m) => TaxIdBase.fromJson(m);
  static TaxId fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TaxId_CLASS:
        return TaxId.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TaxId_CLASS;
  String get type => _type;

  set type(String $o) {
    if ($o == _type) return;
    var $old = _type;
    _type = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.type_DP, $old, _type));
    }
  }

  String get value => _value;

  set value(String $o) {
    if ($o == _value) return;
    var $old = _value;
    _value = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.value_DP, $old, _value));
    }
  }

  bool get isValid => _isValid;

  set isValid(bool $o) {
    if ($o == _isValid) return;
    var $old = _isValid;
    _isValid = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isValid_DP, $old, _isValid));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.type_DP:
        return type;
      case Vocabulary.value_DP:
        return value;
      case Vocabulary.isValid_DP:
        return isValid;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.type_DP:
        type = $value as String;
        return;
      case Vocabulary.value_DP:
        value = $value as String;
        return;
      case Vocabulary.isValid_DP:
        isValid = $value as bool;
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
  TaxId copy() => TaxId.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TaxId_CLASS;
    if (subKind != null && subKind != Vocabulary.TaxId_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.type_DP] = type;
    m[Vocabulary.value_DP] = value;
    m[Vocabulary.isValid_DP] = isValid;
    return m;
  }
}
