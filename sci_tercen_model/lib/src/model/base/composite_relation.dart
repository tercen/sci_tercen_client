part of sci_model_base;

class CompositeRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.joinOperators_OP,
    Vocabulary.mainRelation_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<JoinOperator> joinOperators;
  Relation _mainRelation;

  CompositeRelationBase()
      : joinOperators = base.ListChanged<JoinOperator>(),
        _mainRelation = Relation() {
    joinOperators.parent = this;
    _mainRelation.parent = this;
  }

  CompositeRelationBase.json(Map m)
      : joinOperators = base.ListChanged<JoinOperator>.from(
            m[Vocabulary.joinOperators_OP] as List?,
            JoinOperatorBase.createFromJson),
        _mainRelation =
            RelationBase._createFromJson(m[Vocabulary.mainRelation_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CompositeRelation_CLASS, m);
    joinOperators.parent = this;
    _mainRelation.parent = this;
  }

  static CompositeRelation createFromJson(Map m) =>
      CompositeRelationBase.fromJson(m);
  static CompositeRelation _createFromJson(Map? m) =>
      m == null ? CompositeRelation() : CompositeRelationBase.fromJson(m);
  static CompositeRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CompositeRelation_CLASS:
        return CompositeRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CompositeRelation_CLASS;
  Relation get mainRelation => _mainRelation;

  set mainRelation(Relation $o) {
    if ($o == _mainRelation) return;
    _mainRelation.parent = null;
    $o.parent = this;
    var $old = _mainRelation;
    _mainRelation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.mainRelation_OP, $old, _mainRelation));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.joinOperators_OP:
        return joinOperators;
      case Vocabulary.mainRelation_OP:
        return mainRelation;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.joinOperators_OP:
        joinOperators.setValues($value as Iterable<JoinOperator>);
        return;
      case Vocabulary.mainRelation_OP:
        mainRelation = $value as Relation;
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
  CompositeRelation copy() => CompositeRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CompositeRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.CompositeRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.joinOperators_OP] = joinOperators.toJson();
    m[Vocabulary.mainRelation_OP] = mainRelation.toJson();
    return m;
  }
}
