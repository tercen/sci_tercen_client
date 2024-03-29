part of sci_model_base;

class FilterBase extends FilterTopExpr {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.logical_DP,
    Vocabulary.not_DP,
    Vocabulary.filterExprs_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _logical;
  bool _not;
  final base.ListChanged<FilterTopExpr> filterExprs;

  FilterBase()
      : _logical = "",
        _not = true,
        filterExprs = base.ListChanged<FilterTopExpr>() {
    filterExprs.parent = this;
  }

  FilterBase.json(Map m)
      : _logical = base.defaultValue(
            m[Vocabulary.logical_DP] as String?, base.String_DefaultFactory),
        _not = base.defaultValue(
            m[Vocabulary.not_DP] as bool?, base.bool_DefaultFactory),
        filterExprs = base.ListChanged<FilterTopExpr>.from(
            m[Vocabulary.filterExprs_OP] as List?,
            FilterTopExprBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Filter_CLASS, m);
    filterExprs.parent = this;
  }

  static Filter createFromJson(Map m) => FilterBase.fromJson(m);
  static Filter _createFromJson(Map? m) =>
      m == null ? Filter() : FilterBase.fromJson(m);
  static Filter fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Filter_CLASS:
        return Filter.json(m);
      case Vocabulary.NamedFilter_CLASS:
        return NamedFilter.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Filter_CLASS;
  String get logical => _logical;

  set logical(String $o) {
    if ($o == _logical) return;
    var $old = _logical;
    _logical = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.logical_DP, $old, _logical));
    }
  }

  bool get not => _not;

  set not(bool $o) {
    if ($o == _not) return;
    var $old = _not;
    _not = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.not_DP, $old, _not));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.logical_DP:
        return logical;
      case Vocabulary.not_DP:
        return not;
      case Vocabulary.filterExprs_OP:
        return filterExprs;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.logical_DP:
        logical = $value as String;
        return;
      case Vocabulary.not_DP:
        not = $value as bool;
        return;
      case Vocabulary.filterExprs_OP:
        filterExprs.setValues($value as Iterable<FilterTopExpr>);
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
  Filter copy() => Filter.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Filter_CLASS;
    if (subKind != null && subKind != Vocabulary.Filter_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.logical_DP] = logical;
    m[Vocabulary.not_DP] = not;
    m[Vocabulary.filterExprs_OP] = filterExprs.toJson();
    return m;
  }
}
