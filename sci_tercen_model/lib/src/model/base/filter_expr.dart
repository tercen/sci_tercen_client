part of sci_model_base;

class FilterExprBase extends FilterTopExpr {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.filterOp_DP,
    Vocabulary.stringValue_DP,
    Vocabulary.factor_OP,
    Vocabulary.preProcessors_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _filterOp;
  String _stringValue;
  Factor _factor;
  final base.ListChanged<PreProcessor> preProcessors;

  FilterExprBase()
      : _filterOp = "",
        _stringValue = "",
        _factor = Factor(),
        preProcessors = base.ListChanged<PreProcessor>() {
    _factor.parent = this;
    preProcessors.parent = this;
  }

  FilterExprBase.json(Map m)
      : _filterOp = base.defaultValue(
            m[Vocabulary.filterOp_DP] as String?, base.String_DefaultFactory),
        _stringValue = base.defaultValue(
            m[Vocabulary.stringValue_DP] as String?,
            base.String_DefaultFactory),
        _factor = (m[Vocabulary.factor_OP] as Map?) == null
            ? Factor()
            : FactorBase.fromJson(m[Vocabulary.factor_OP] as Map),
        preProcessors = base.ListChanged<PreProcessor>.from(
            m[Vocabulary.preProcessors_OP] as List?,
            PreProcessorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FilterExpr_CLASS, m);
    _factor.parent = this;
    preProcessors.parent = this;
  }

  static FilterExpr createFromJson(Map m) => FilterExprBase.fromJson(m);
  static FilterExpr fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FilterExpr_CLASS:
        return FilterExpr.json(m);
      case Vocabulary.FilterExpr2d_CLASS:
        return FilterExpr2d.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FilterExpr_CLASS;
  String get filterOp => _filterOp;

  set filterOp(String $o) {
    if ($o == _filterOp) return;
    var $old = _filterOp;
    _filterOp = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.filterOp_DP, $old, _filterOp));
    }
  }

  String get stringValue => _stringValue;

  set stringValue(String $o) {
    if ($o == _stringValue) return;
    var $old = _stringValue;
    _stringValue = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.stringValue_DP, $old, _stringValue));
    }
  }

  Factor get factor => _factor;

  set factor(Factor $o) {
    if ($o == _factor) return;
    _factor.parent = null;
    $o.parent = this;
    var $old = _factor;
    _factor = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.factor_OP, $old, _factor));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.filterOp_DP:
        return filterOp;
      case Vocabulary.stringValue_DP:
        return stringValue;
      case Vocabulary.factor_OP:
        return factor;
      case Vocabulary.preProcessors_OP:
        return preProcessors;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.filterOp_DP:
        filterOp = $value as String;
        return;
      case Vocabulary.stringValue_DP:
        stringValue = $value as String;
        return;
      case Vocabulary.factor_OP:
        factor = $value as Factor;
        return;
      case Vocabulary.preProcessors_OP:
        preProcessors.setValues($value as Iterable<PreProcessor>);
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
  FilterExpr copy() => FilterExpr.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FilterExpr_CLASS;
    if (subKind != null && subKind != Vocabulary.FilterExpr_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.filterOp_DP] = filterOp;
    m[Vocabulary.stringValue_DP] = stringValue;
    m[Vocabulary.factor_OP] = factor.toJson();
    m[Vocabulary.preProcessors_OP] = preProcessors.toJson();
    return m;
  }
}
