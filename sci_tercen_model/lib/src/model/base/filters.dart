part of sci_model_base;

class FiltersBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.removeNaN_DP,
    Vocabulary.namedFilters_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  bool _removeNaN;
  final base.ListChanged<NamedFilter> namedFilters;

  FiltersBase()
      : _removeNaN = true,
        namedFilters = base.ListChanged<NamedFilter>() {
    namedFilters.parent = this;
  }

  FiltersBase.json(Map m)
      : _removeNaN = base.defaultValue(
            m[Vocabulary.removeNaN_DP] as bool?, base.bool_DefaultFactory),
        namedFilters = base.ListChanged<NamedFilter>.from(
            m[Vocabulary.namedFilters_OP] as List?,
            NamedFilterBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Filters_CLASS, m);
    namedFilters.parent = this;
  }

  static Filters createFromJson(Map m) => FiltersBase.fromJson(m);
  static Filters _createFromJson(Map? m) =>
      m == null ? Filters() : FiltersBase.fromJson(m);
  static Filters fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Filters_CLASS:
        return Filters.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Filters_CLASS;
  bool get removeNaN => _removeNaN;

  set removeNaN(bool $o) {
    if ($o == _removeNaN) return;
    var $old = _removeNaN;
    _removeNaN = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.removeNaN_DP, $old, _removeNaN));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.removeNaN_DP:
        return removeNaN;
      case Vocabulary.namedFilters_OP:
        return namedFilters;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.removeNaN_DP:
        removeNaN = $value as bool;
        return;
      case Vocabulary.namedFilters_OP:
        namedFilters.setValues($value as Iterable<NamedFilter>);
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
  Filters copy() => Filters.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Filters_CLASS;
    if (subKind != null && subKind != Vocabulary.Filters_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.removeNaN_DP] = removeNaN;
    m[Vocabulary.namedFilters_OP] = namedFilters.toJson();
    return m;
  }
}
