part of sci_model_base;

class MetaFactorBase extends Factor {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.description_DP,
    Vocabulary.ontologyMapping_DP,
    Vocabulary.crosstabMapping_DP,
    Vocabulary.cardinality_DP,
    Vocabulary.factors_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _description;
  String _ontologyMapping;
  String _crosstabMapping;
  String _cardinality;
  final base.ListChanged<Factor> factors;

  MetaFactorBase()
      : _description = "",
        _ontologyMapping = "",
        _crosstabMapping = "",
        _cardinality = "",
        factors = base.ListChanged<Factor>() {
    factors.parent = this;
  }

  MetaFactorBase.json(Map m)
      : _description = base.defaultValue(
            m[Vocabulary.description_DP] as String?,
            base.String_DefaultFactory),
        _ontologyMapping = base.defaultValue(
            m[Vocabulary.ontologyMapping_DP] as String?,
            base.String_DefaultFactory),
        _crosstabMapping = base.defaultValue(
            m[Vocabulary.crosstabMapping_DP] as String?,
            base.String_DefaultFactory),
        _cardinality = base.defaultValue(
            m[Vocabulary.cardinality_DP] as String?,
            base.String_DefaultFactory),
        factors = base.ListChanged<Factor>.from(
            m[Vocabulary.factors_OP] as List?, FactorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.MetaFactor_CLASS, m);
    factors.parent = this;
  }

  static MetaFactor createFromJson(Map m) => MetaFactorBase.fromJson(m);
  static MetaFactor fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.MetaFactor_CLASS:
        return MetaFactor.json(m);
      case Vocabulary.MappingFactor_CLASS:
        return MappingFactor.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.MetaFactor_CLASS;
  String get description => _description;

  set description(String $o) {
    if ($o == _description) return;
    var $old = _description;
    _description = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.description_DP, $old, _description));
    }
  }

  String get ontologyMapping => _ontologyMapping;

  set ontologyMapping(String $o) {
    if ($o == _ontologyMapping) return;
    var $old = _ontologyMapping;
    _ontologyMapping = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.ontologyMapping_DP, $old, _ontologyMapping));
    }
  }

  String get crosstabMapping => _crosstabMapping;

  set crosstabMapping(String $o) {
    if ($o == _crosstabMapping) return;
    var $old = _crosstabMapping;
    _crosstabMapping = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.crosstabMapping_DP, $old, _crosstabMapping));
    }
  }

  String get cardinality => _cardinality;

  set cardinality(String $o) {
    if ($o == _cardinality) return;
    var $old = _cardinality;
    _cardinality = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cardinality_DP, $old, _cardinality));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.description_DP:
        return description;
      case Vocabulary.ontologyMapping_DP:
        return ontologyMapping;
      case Vocabulary.crosstabMapping_DP:
        return crosstabMapping;
      case Vocabulary.cardinality_DP:
        return cardinality;
      case Vocabulary.factors_OP:
        return factors;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.description_DP:
        description = $value as String;
        return;
      case Vocabulary.ontologyMapping_DP:
        ontologyMapping = $value as String;
        return;
      case Vocabulary.crosstabMapping_DP:
        crosstabMapping = $value as String;
        return;
      case Vocabulary.cardinality_DP:
        cardinality = $value as String;
        return;
      case Vocabulary.factors_OP:
        factors.setValues($value as Iterable<Factor>);
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
  MetaFactor copy() => MetaFactor.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.MetaFactor_CLASS;
    if (subKind != null && subKind != Vocabulary.MetaFactor_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.description_DP] = description;
    m[Vocabulary.ontologyMapping_DP] = ontologyMapping;
    m[Vocabulary.crosstabMapping_DP] = crosstabMapping;
    m[Vocabulary.cardinality_DP] = cardinality;
    m[Vocabulary.factors_OP] = factors.toJson();
    return m;
  }
}
