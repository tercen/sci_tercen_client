part of sci_model_base;

class WizardStepModelBase extends StepModel {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.namespace_DP,
    Vocabulary.description_DP,
    Vocabulary.appDesignType_DP,
    Vocabulary.factors_OP,
    Vocabulary.filters_OP,
    Vocabulary.steps_OP,
    Vocabulary.defaultFactors_OP,
    Vocabulary.defaultFilters_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _namespace;
  String _description;
  String _appDesignType;
  final base.ListChanged<MappingFactor> factors;
  final base.ListChanged<MappingFilter> filters;
  final base.ListChanged<Step> steps;
  final base.ListChanged<MappingFactor> defaultFactors;
  final base.ListChanged<MappingFilter> defaultFilters;

  WizardStepModelBase()
      : _namespace = "",
        _description = "",
        _appDesignType = "",
        factors = base.ListChanged<MappingFactor>(),
        filters = base.ListChanged<MappingFilter>(),
        steps = base.ListChanged<Step>(),
        defaultFactors = base.ListChanged<MappingFactor>(),
        defaultFilters = base.ListChanged<MappingFilter>() {
    factors.parent = this;
    filters.parent = this;
    steps.parent = this;
    defaultFactors.parent = this;
    defaultFilters.parent = this;
  }

  WizardStepModelBase.json(Map m)
      : _namespace = base.defaultValue(
            m[Vocabulary.namespace_DP] as String?, base.String_DefaultFactory),
        _description = base.defaultValue(
            m[Vocabulary.description_DP] as String?,
            base.String_DefaultFactory),
        _appDesignType = base.defaultValue(
            m[Vocabulary.appDesignType_DP] as String?,
            base.String_DefaultFactory),
        factors = base.ListChanged<MappingFactor>.from(
            m[Vocabulary.factors_OP] as List?,
            MappingFactorBase.createFromJson),
        filters = base.ListChanged<MappingFilter>.from(
            m[Vocabulary.filters_OP] as List?,
            MappingFilterBase.createFromJson),
        steps = base.ListChanged<Step>.from(
            m[Vocabulary.steps_OP] as List?, StepBase.createFromJson),
        defaultFactors = base.ListChanged<MappingFactor>.from(
            m[Vocabulary.defaultFactors_OP] as List?,
            MappingFactorBase.createFromJson),
        defaultFilters = base.ListChanged<MappingFilter>.from(
            m[Vocabulary.defaultFilters_OP] as List?,
            MappingFilterBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.WizardStepModel_CLASS, m);
    factors.parent = this;
    filters.parent = this;
    steps.parent = this;
    defaultFactors.parent = this;
    defaultFilters.parent = this;
  }

  static WizardStepModel createFromJson(Map m) =>
      WizardStepModelBase.fromJson(m);
  static WizardStepModel _createFromJson(Map? m) =>
      m == null ? WizardStepModel() : WizardStepModelBase.fromJson(m);
  static WizardStepModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.WizardStepModel_CLASS:
        return WizardStepModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.WizardStepModel_CLASS;
  String get namespace => _namespace;

  set namespace(String $o) {
    if ($o == _namespace) return;
    var $old = _namespace;
    _namespace = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.namespace_DP, $old, _namespace));
    }
  }

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

  String get appDesignType => _appDesignType;

  set appDesignType(String $o) {
    if ($o == _appDesignType) return;
    var $old = _appDesignType;
    _appDesignType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.appDesignType_DP, $old, _appDesignType));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.namespace_DP:
        return namespace;
      case Vocabulary.description_DP:
        return description;
      case Vocabulary.appDesignType_DP:
        return appDesignType;
      case Vocabulary.factors_OP:
        return factors;
      case Vocabulary.filters_OP:
        return filters;
      case Vocabulary.steps_OP:
        return steps;
      case Vocabulary.defaultFactors_OP:
        return defaultFactors;
      case Vocabulary.defaultFilters_OP:
        return defaultFilters;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.namespace_DP:
        namespace = $value as String;
        return;
      case Vocabulary.description_DP:
        description = $value as String;
        return;
      case Vocabulary.appDesignType_DP:
        appDesignType = $value as String;
        return;
      case Vocabulary.factors_OP:
        factors.setValues($value as Iterable<MappingFactor>);
        return;
      case Vocabulary.filters_OP:
        filters.setValues($value as Iterable<MappingFilter>);
        return;
      case Vocabulary.steps_OP:
        steps.setValues($value as Iterable<Step>);
        return;
      case Vocabulary.defaultFactors_OP:
        defaultFactors.setValues($value as Iterable<MappingFactor>);
        return;
      case Vocabulary.defaultFilters_OP:
        defaultFilters.setValues($value as Iterable<MappingFilter>);
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
  WizardStepModel copy() => WizardStepModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.WizardStepModel_CLASS;
    if (subKind != null && subKind != Vocabulary.WizardStepModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.namespace_DP] = namespace;
    m[Vocabulary.description_DP] = description;
    m[Vocabulary.appDesignType_DP] = appDesignType;
    m[Vocabulary.factors_OP] = factors.toJson();
    m[Vocabulary.filters_OP] = filters.toJson();
    m[Vocabulary.steps_OP] = steps.toJson();
    m[Vocabulary.defaultFactors_OP] = defaultFactors.toJson();
    m[Vocabulary.defaultFilters_OP] = defaultFilters.toJson();
    return m;
  }
}
