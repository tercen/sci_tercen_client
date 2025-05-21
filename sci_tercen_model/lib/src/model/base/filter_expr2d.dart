part of sci_model_base;

class FilterExpr2dBase extends FilterExpr {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.factor2_OP,
    Vocabulary.preProcessors2_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Factor _factor2;
  final base.ListChanged<PreProcessor> preProcessors2;

  FilterExpr2dBase()
      : _factor2 = Factor(),
        preProcessors2 = base.ListChanged<PreProcessor>() {
    _factor2.parent = this;
    preProcessors2.parent = this;
  }

  FilterExpr2dBase.json(Map m)
      : _factor2 = FactorBase._createFromJson(m[Vocabulary.factor2_OP] as Map?),
        preProcessors2 = base.ListChanged<PreProcessor>.from(
            m[Vocabulary.preProcessors2_OP] as List?,
            PreProcessorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FilterExpr2d_CLASS, m);
    _factor2.parent = this;
    preProcessors2.parent = this;
  }

  static FilterExpr2d createFromJson(Map m) => FilterExpr2dBase.fromJson(m);
  static FilterExpr2d _createFromJson(Map? m) =>
      m == null ? FilterExpr2d() : FilterExpr2dBase.fromJson(m);
  static FilterExpr2d fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FilterExpr2d_CLASS:
        return FilterExpr2d.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FilterExpr2d_CLASS;
  Factor get factor2 => _factor2;

  set factor2(Factor $o) {
    if ($o == _factor2) return;
    _factor2.parent = null;
    $o.parent = this;
    var $old = _factor2;
    _factor2 = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.factor2_OP, $old, _factor2));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.factor2_OP:
        return factor2;
      case Vocabulary.preProcessors2_OP:
        return preProcessors2;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.factor2_OP:
        factor2 = $value as Factor;
        return;
      case Vocabulary.preProcessors2_OP:
        preProcessors2.setValues($value as Iterable<PreProcessor>);
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
  FilterExpr2d copy() => FilterExpr2d.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FilterExpr2d_CLASS;
    if (subKind != null && subKind != Vocabulary.FilterExpr2d_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.factor2_OP] = factor2.toJson();
    m[Vocabulary.preProcessors2_OP] = preProcessors2.toJson();
    return m;
  }
}
