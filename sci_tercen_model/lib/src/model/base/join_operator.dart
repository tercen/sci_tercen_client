part of sci_model_base;

class JoinOperatorBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.joinType_DP,
    Vocabulary.leftPair_OP,
    Vocabulary.rightRelation_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _joinType;
  ColumnPair _leftPair;
  Relation _rightRelation;

  JoinOperatorBase()
      : _joinType = "",
        _leftPair = ColumnPair(),
        _rightRelation = Relation() {
    _leftPair.parent = this;
    _rightRelation.parent = this;
  }

  JoinOperatorBase.json(Map m)
      : _joinType = base.defaultValue(
            m[Vocabulary.joinType_DP] as String?, base.String_DefaultFactory),
        _leftPair = (m[Vocabulary.leftPair_OP] as Map?) == null
            ? ColumnPair()
            : ColumnPairBase.fromJson(m[Vocabulary.leftPair_OP] as Map),
        _rightRelation = (m[Vocabulary.rightRelation_OP] as Map?) == null
            ? Relation()
            : RelationBase.fromJson(m[Vocabulary.rightRelation_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.JoinOperator_CLASS, m);
    _leftPair.parent = this;
    _rightRelation.parent = this;
  }

  static JoinOperator createFromJson(Map m) => JoinOperatorBase.fromJson(m);
  static JoinOperator fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.JoinOperator_CLASS:
        return JoinOperator.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.JoinOperator_CLASS;
  String get joinType => _joinType;

  set joinType(String $o) {
    if ($o == _joinType) return;
    var $old = _joinType;
    _joinType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.joinType_DP, $old, _joinType));
    }
  }

  ColumnPair get leftPair => _leftPair;

  set leftPair(ColumnPair $o) {
    if ($o == _leftPair) return;
    _leftPair.parent = null;
    $o.parent = this;
    var $old = _leftPair;
    _leftPair = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.leftPair_OP, $old, _leftPair));
    }
  }

  Relation get rightRelation => _rightRelation;

  set rightRelation(Relation $o) {
    if ($o == _rightRelation) return;
    _rightRelation.parent = null;
    $o.parent = this;
    var $old = _rightRelation;
    _rightRelation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.rightRelation_OP, $old, _rightRelation));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.joinType_DP:
        return joinType;
      case Vocabulary.leftPair_OP:
        return leftPair;
      case Vocabulary.rightRelation_OP:
        return rightRelation;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.joinType_DP:
        joinType = $value as String;
        return;
      case Vocabulary.leftPair_OP:
        leftPair = $value as ColumnPair;
        return;
      case Vocabulary.rightRelation_OP:
        rightRelation = $value as Relation;
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
  JoinOperator copy() => JoinOperator.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.JoinOperator_CLASS;
    if (subKind != null && subKind != Vocabulary.JoinOperator_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.joinType_DP] = joinType;
    m[Vocabulary.leftPair_OP] = leftPair.toJson();
    m[Vocabulary.rightRelation_OP] = rightRelation.toJson();
    return m;
  }
}
