part of sci_model_base;

class SelectPairwiseRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.columnRelation_OP,
    Vocabulary.rowRelation_OP,
    Vocabulary.qtRelation_OP,
    Vocabulary.pairwiseColGroup_DP,
    Vocabulary.pairwiseRowGroup_DP,
    Vocabulary.pairAttributes_DP,
    Vocabulary.nAxis_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Relation _columnRelation;
  Relation _rowRelation;
  Relation _qtRelation;
  final base.ListChangedBase<String> pairwiseColGroup;
  final base.ListChangedBase<String> pairwiseRowGroup;
  final base.ListChangedBase<String> pairAttributes;
  int _nAxis;

  SelectPairwiseRelationBase()
      : pairwiseColGroup = base.ListChangedBase<String>(),
        pairwiseRowGroup = base.ListChangedBase<String>(),
        pairAttributes = base.ListChangedBase<String>(),
        _nAxis = 0,
        _columnRelation = Relation(),
        _rowRelation = Relation(),
        _qtRelation = Relation() {
    pairwiseColGroup.parent = this;
    pairwiseRowGroup.parent = this;
    pairAttributes.parent = this;
    _columnRelation.parent = this;
    _rowRelation.parent = this;
    _qtRelation.parent = this;
  }

  SelectPairwiseRelationBase.json(Map m)
      : pairwiseColGroup = base.ListChangedBase<String>(
            m[Vocabulary.pairwiseColGroup_DP] as List?),
        pairwiseRowGroup = base.ListChangedBase<String>(
            m[Vocabulary.pairwiseRowGroup_DP] as List?),
        pairAttributes = base.ListChangedBase<String>(
            m[Vocabulary.pairAttributes_DP] as List?),
        _nAxis = base.defaultValue(
            m[Vocabulary.nAxis_DP] as int?, base.int_DefaultFactory),
        _columnRelation = RelationBase._createFromJson(
            m[Vocabulary.columnRelation_OP] as Map?),
        _rowRelation =
            RelationBase._createFromJson(m[Vocabulary.rowRelation_OP] as Map?),
        _qtRelation =
            RelationBase._createFromJson(m[Vocabulary.qtRelation_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.SelectPairwiseRelation_CLASS, m);
    pairwiseColGroup.parent = this;
    pairwiseRowGroup.parent = this;
    pairAttributes.parent = this;
    _columnRelation.parent = this;
    _rowRelation.parent = this;
    _qtRelation.parent = this;
  }

  static SelectPairwiseRelation createFromJson(Map m) =>
      SelectPairwiseRelationBase.fromJson(m);
  static SelectPairwiseRelation _createFromJson(Map? m) => m == null
      ? SelectPairwiseRelation()
      : SelectPairwiseRelationBase.fromJson(m);
  static SelectPairwiseRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.SelectPairwiseRelation_CLASS:
        return SelectPairwiseRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.SelectPairwiseRelation_CLASS;
  int get nAxis => _nAxis;

  set nAxis(int $o) {
    if ($o == _nAxis) return;
    var $old = _nAxis;
    _nAxis = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nAxis_DP, $old, _nAxis));
    }
  }

  Relation get columnRelation => _columnRelation;

  set columnRelation(Relation $o) {
    if ($o == _columnRelation) return;
    _columnRelation.parent = null;
    $o.parent = this;
    var $old = _columnRelation;
    _columnRelation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.columnRelation_OP, $old, _columnRelation));
    }
  }

  Relation get rowRelation => _rowRelation;

  set rowRelation(Relation $o) {
    if ($o == _rowRelation) return;
    _rowRelation.parent = null;
    $o.parent = this;
    var $old = _rowRelation;
    _rowRelation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.rowRelation_OP, $old, _rowRelation));
    }
  }

  Relation get qtRelation => _qtRelation;

  set qtRelation(Relation $o) {
    if ($o == _qtRelation) return;
    _qtRelation.parent = null;
    $o.parent = this;
    var $old = _qtRelation;
    _qtRelation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.qtRelation_OP, $old, _qtRelation));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.columnRelation_OP:
        return columnRelation;
      case Vocabulary.rowRelation_OP:
        return rowRelation;
      case Vocabulary.qtRelation_OP:
        return qtRelation;
      case Vocabulary.pairwiseColGroup_DP:
        return pairwiseColGroup;
      case Vocabulary.pairwiseRowGroup_DP:
        return pairwiseRowGroup;
      case Vocabulary.pairAttributes_DP:
        return pairAttributes;
      case Vocabulary.nAxis_DP:
        return nAxis;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.pairwiseColGroup_DP:
        pairwiseColGroup.setValues($value as Iterable<String>);
        return;
      case Vocabulary.pairwiseRowGroup_DP:
        pairwiseRowGroup.setValues($value as Iterable<String>);
        return;
      case Vocabulary.pairAttributes_DP:
        pairAttributes.setValues($value as Iterable<String>);
        return;
      case Vocabulary.nAxis_DP:
        nAxis = $value as int;
        return;
      case Vocabulary.columnRelation_OP:
        columnRelation = $value as Relation;
        return;
      case Vocabulary.rowRelation_OP:
        rowRelation = $value as Relation;
        return;
      case Vocabulary.qtRelation_OP:
        qtRelation = $value as Relation;
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
  SelectPairwiseRelation copy() => SelectPairwiseRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.SelectPairwiseRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.SelectPairwiseRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.columnRelation_OP] = columnRelation.toJson();
    m[Vocabulary.rowRelation_OP] = rowRelation.toJson();
    m[Vocabulary.qtRelation_OP] = qtRelation.toJson();
    m[Vocabulary.pairwiseColGroup_DP] = pairwiseColGroup;
    m[Vocabulary.pairwiseRowGroup_DP] = pairwiseRowGroup;
    m[Vocabulary.pairAttributes_DP] = pairAttributes;
    m[Vocabulary.nAxis_DP] = nAxis;
    return m;
  }
}
