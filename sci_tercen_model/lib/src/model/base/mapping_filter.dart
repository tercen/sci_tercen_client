part of sci_model_base;

class MappingFilterBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.description_DP,
    Vocabulary.namedFilter_OP,
    Vocabulary.isRequired_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  String _description;
  NamedFilter _namedFilter;
  bool _isRequired;

  MappingFilterBase()
      : _name = "",
        _description = "",
        _isRequired = true,
        _namedFilter = NamedFilter() {
    _namedFilter.parent = this;
  }

  MappingFilterBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _description = base.defaultValue(
            m[Vocabulary.description_DP] as String?,
            base.String_DefaultFactory),
        _isRequired = base.defaultValue(
            m[Vocabulary.isRequired_DP] as bool?, base.bool_DefaultFactory),
        _namedFilter = NamedFilterBase._createFromJson(
            m[Vocabulary.namedFilter_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.MappingFilter_CLASS, m);
    _namedFilter.parent = this;
  }

  static MappingFilter createFromJson(Map m) => MappingFilterBase.fromJson(m);
  static MappingFilter _createFromJson(Map? m) =>
      m == null ? MappingFilter() : MappingFilterBase.fromJson(m);
  static MappingFilter fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.MappingFilter_CLASS:
        return MappingFilter.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.MappingFilter_CLASS;
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

  NamedFilter get namedFilter => _namedFilter;

  set namedFilter(NamedFilter $o) {
    if ($o == _namedFilter) return;
    _namedFilter.parent = null;
    $o.parent = this;
    var $old = _namedFilter;
    _namedFilter = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.namedFilter_OP, $old, _namedFilter));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.description_DP:
        return description;
      case Vocabulary.namedFilter_OP:
        return namedFilter;
      case Vocabulary.isRequired_DP:
        return isRequired;
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
      case Vocabulary.description_DP:
        description = $value as String;
        return;
      case Vocabulary.isRequired_DP:
        isRequired = $value as bool;
        return;
      case Vocabulary.namedFilter_OP:
        namedFilter = $value as NamedFilter;
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

  MappingFilter copy() => MappingFilter.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.MappingFilter_CLASS;
    if (subKind != null && subKind != Vocabulary.MappingFilter_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.description_DP] = description;
    m[Vocabulary.namedFilter_OP] = namedFilter.toJson();
    m[Vocabulary.isRequired_DP] = isRequired;
    return m;
  }
}
