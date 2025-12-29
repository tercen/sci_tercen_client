part of sci_model_base;

class MappingFactorBase extends MetaFactor {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.factorName_DP,
    Vocabulary.isSingle_DP,
    Vocabulary.isRequired_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _factorName;
  bool _isSingle;
  bool _isRequired;

  MappingFactorBase()
      : _factorName = "",
        _isSingle = true,
        _isRequired = true;
  MappingFactorBase.json(Map m)
      : _factorName = base.defaultValue(
            m[Vocabulary.factorName_DP] as String?, base.String_DefaultFactory),
        _isSingle = base.defaultValue(
            m[Vocabulary.isSingle_DP] as bool?, base.bool_DefaultFactory),
        _isRequired = base.defaultValue(
            m[Vocabulary.isRequired_DP] as bool?, base.bool_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.MappingFactor_CLASS, m);
  }

  static MappingFactor createFromJson(Map m) => MappingFactorBase.fromJson(m);
  static MappingFactor fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.MappingFactor_CLASS:
        return MappingFactor.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.MappingFactor_CLASS;
  String get factorName => _factorName;

  set factorName(String $o) {
    if ($o == _factorName) return;
    var $old = _factorName;
    _factorName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.factorName_DP, $old, _factorName));
    }
  }

  bool get isSingle => _isSingle;

  set isSingle(bool $o) {
    if ($o == _isSingle) return;
    var $old = _isSingle;
    _isSingle = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isSingle_DP, $old, _isSingle));
    }
  }

  bool get isRequired => _isRequired;

  set isRequired(bool $o) {
    if ($o == _isRequired) return;
    var $old = _isRequired;
    _isRequired = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isRequired_DP, $old, _isRequired));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.factorName_DP:
        return factorName;
      case Vocabulary.isSingle_DP:
        return isSingle;
      case Vocabulary.isRequired_DP:
        return isRequired;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.factorName_DP:
        factorName = $value as String;
        return;
      case Vocabulary.isSingle_DP:
        isSingle = $value as bool;
        return;
      case Vocabulary.isRequired_DP:
        isRequired = $value as bool;
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
  MappingFactor copy() => MappingFactor.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.MappingFactor_CLASS;
    if (subKind != null && subKind != Vocabulary.MappingFactor_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.factorName_DP] = factorName;
    m[Vocabulary.isSingle_DP] = isSingle;
    m[Vocabulary.isRequired_DP] = isRequired;
    return m;
  }
}
