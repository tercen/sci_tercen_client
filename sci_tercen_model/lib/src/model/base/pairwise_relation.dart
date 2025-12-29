part of sci_model_base;

class PairwiseRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.relation_OP,
    Vocabulary.rowAttributes_DP,
    Vocabulary.colAttributes_DP,
    Vocabulary.labelAttributes_DP,
    Vocabulary.colorAttributes_DP,
    Vocabulary.xAttribute_DP,
    Vocabulary.yAttribute_DP,
    Vocabulary.errorAttribute_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Relation _relation;
  final base.ListChangedBase<String> rowAttributes;
  final base.ListChangedBase<String> colAttributes;
  final base.ListChangedBase<String> labelAttributes;
  final base.ListChangedBase<String> colorAttributes;
  String _xAttribute;
  String _yAttribute;
  String _errorAttribute;

  PairwiseRelationBase()
      : rowAttributes = base.ListChangedBase<String>(),
        colAttributes = base.ListChangedBase<String>(),
        labelAttributes = base.ListChangedBase<String>(),
        colorAttributes = base.ListChangedBase<String>(),
        _xAttribute = "",
        _yAttribute = "",
        _errorAttribute = "",
        _relation = Relation() {
    rowAttributes.parent = this;
    colAttributes.parent = this;
    labelAttributes.parent = this;
    colorAttributes.parent = this;
    _relation.parent = this;
  }

  PairwiseRelationBase.json(Map m)
      : rowAttributes = base.ListChangedBase<String>(
            m[Vocabulary.rowAttributes_DP] as List?),
        colAttributes = base.ListChangedBase<String>(
            m[Vocabulary.colAttributes_DP] as List?),
        labelAttributes = base.ListChangedBase<String>(
            m[Vocabulary.labelAttributes_DP] as List?),
        colorAttributes = base.ListChangedBase<String>(
            m[Vocabulary.colorAttributes_DP] as List?),
        _xAttribute = base.defaultValue(
            m[Vocabulary.xAttribute_DP] as String?, base.String_DefaultFactory),
        _yAttribute = base.defaultValue(
            m[Vocabulary.yAttribute_DP] as String?, base.String_DefaultFactory),
        _errorAttribute = base.defaultValue(
            m[Vocabulary.errorAttribute_DP] as String?,
            base.String_DefaultFactory),
        _relation = (m[Vocabulary.relation_OP] as Map?) == null
            ? Relation()
            : RelationBase.fromJson(m[Vocabulary.relation_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PairwiseRelation_CLASS, m);
    rowAttributes.parent = this;
    colAttributes.parent = this;
    labelAttributes.parent = this;
    colorAttributes.parent = this;
    _relation.parent = this;
  }

  static PairwiseRelation createFromJson(Map m) =>
      PairwiseRelationBase.fromJson(m);
  static PairwiseRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PairwiseRelation_CLASS:
        return PairwiseRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PairwiseRelation_CLASS;
  String get xAttribute => _xAttribute;

  set xAttribute(String $o) {
    if ($o == _xAttribute) return;
    var $old = _xAttribute;
    _xAttribute = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.xAttribute_DP, $old, _xAttribute));
    }
  }

  String get yAttribute => _yAttribute;

  set yAttribute(String $o) {
    if ($o == _yAttribute) return;
    var $old = _yAttribute;
    _yAttribute = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.yAttribute_DP, $old, _yAttribute));
    }
  }

  String get errorAttribute => _errorAttribute;

  set errorAttribute(String $o) {
    if ($o == _errorAttribute) return;
    var $old = _errorAttribute;
    _errorAttribute = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.errorAttribute_DP, $old, _errorAttribute));
    }
  }

  Relation get relation => _relation;

  set relation(Relation $o) {
    if ($o == _relation) return;
    _relation.parent = null;
    $o.parent = this;
    var $old = _relation;
    _relation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.relation_OP, $old, _relation));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.relation_OP:
        return relation;
      case Vocabulary.rowAttributes_DP:
        return rowAttributes;
      case Vocabulary.colAttributes_DP:
        return colAttributes;
      case Vocabulary.labelAttributes_DP:
        return labelAttributes;
      case Vocabulary.colorAttributes_DP:
        return colorAttributes;
      case Vocabulary.xAttribute_DP:
        return xAttribute;
      case Vocabulary.yAttribute_DP:
        return yAttribute;
      case Vocabulary.errorAttribute_DP:
        return errorAttribute;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.rowAttributes_DP:
        rowAttributes.setValues($value as Iterable<String>);
        return;
      case Vocabulary.colAttributes_DP:
        colAttributes.setValues($value as Iterable<String>);
        return;
      case Vocabulary.labelAttributes_DP:
        labelAttributes.setValues($value as Iterable<String>);
        return;
      case Vocabulary.colorAttributes_DP:
        colorAttributes.setValues($value as Iterable<String>);
        return;
      case Vocabulary.xAttribute_DP:
        xAttribute = $value as String;
        return;
      case Vocabulary.yAttribute_DP:
        yAttribute = $value as String;
        return;
      case Vocabulary.errorAttribute_DP:
        errorAttribute = $value as String;
        return;
      case Vocabulary.relation_OP:
        relation = $value as Relation;
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
  PairwiseRelation copy() => PairwiseRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PairwiseRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.PairwiseRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relation_OP] = relation.toJson();
    m[Vocabulary.rowAttributes_DP] = rowAttributes;
    m[Vocabulary.colAttributes_DP] = colAttributes;
    m[Vocabulary.labelAttributes_DP] = labelAttributes;
    m[Vocabulary.colorAttributes_DP] = colorAttributes;
    m[Vocabulary.xAttribute_DP] = xAttribute;
    m[Vocabulary.yAttribute_DP] = yAttribute;
    m[Vocabulary.errorAttribute_DP] = errorAttribute;
    return m;
  }
}
