part of sci_model_base;

class AppDesignBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.namespace_DP,
    Vocabulary.description_DP,
    Vocabulary.name_DP,
    Vocabulary.type_DP,
    Vocabulary.factors_OP,
    Vocabulary.filters_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _namespace;
  String _description;
  String _name;
  String _type;
  final base.ListChanged<MappingFactor> factors;
  final base.ListChanged<MappingFilter> filters;

  AppDesignBase()
      : _namespace = "",
        _description = "",
        _name = "",
        _type = "",
        factors = base.ListChanged<MappingFactor>(),
        filters = base.ListChanged<MappingFilter>() {
    factors.parent = this;
    filters.parent = this;
  }

  AppDesignBase.json(Map m)
      : _namespace = base.defaultValue(
            m[Vocabulary.namespace_DP] as String?, base.String_DefaultFactory),
        _description = base.defaultValue(
            m[Vocabulary.description_DP] as String?,
            base.String_DefaultFactory),
        _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _type = base.defaultValue(
            m[Vocabulary.type_DP] as String?, base.String_DefaultFactory),
        factors = base.ListChanged<MappingFactor>.from(
            m[Vocabulary.factors_OP] as List?,
            MappingFactorBase.createFromJson),
        filters = base.ListChanged<MappingFilter>.from(
            m[Vocabulary.filters_OP] as List?,
            MappingFilterBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.AppDesign_CLASS, m);
    factors.parent = this;
    filters.parent = this;
  }

  static AppDesign createFromJson(Map m) => AppDesignBase.fromJson(m);
  static AppDesign _createFromJson(Map? m) =>
      m == null ? AppDesign() : AppDesignBase.fromJson(m);
  static AppDesign fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.AppDesign_CLASS:
        return AppDesign.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.AppDesign_CLASS;
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

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.namespace_DP:
        return namespace;
      case Vocabulary.description_DP:
        return description;
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.type_DP:
        return type;
      case Vocabulary.factors_OP:
        return factors;
      case Vocabulary.filters_OP:
        return filters;
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
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.type_DP:
        type = $value as String;
        return;
      case Vocabulary.factors_OP:
        factors.setValues($value as Iterable<MappingFactor>);
        return;
      case Vocabulary.filters_OP:
        filters.setValues($value as Iterable<MappingFilter>);
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
  AppDesign copy() => AppDesign.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.AppDesign_CLASS;
    if (subKind != null && subKind != Vocabulary.AppDesign_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.namespace_DP] = namespace;
    m[Vocabulary.description_DP] = description;
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.type_DP] = type;
    m[Vocabulary.factors_OP] = factors.toJson();
    m[Vocabulary.filters_OP] = filters.toJson();
    return m;
  }
}
