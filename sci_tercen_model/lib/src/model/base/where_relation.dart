part of sci_model_base;

class WhereRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.relation_OP,
    Vocabulary.filters_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Relation _relation;
  Filters _filters;

  WhereRelationBase()
      : _relation = Relation(),
        _filters = Filters() {
    _relation.parent = this;
    _filters.parent = this;
  }

  WhereRelationBase.json(Map m)
      : _relation =
            RelationBase._createFromJson(m[Vocabulary.relation_OP] as Map?),
        _filters =
            FiltersBase._createFromJson(m[Vocabulary.filters_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.WhereRelation_CLASS, m);
    _relation.parent = this;
    _filters.parent = this;
  }

  static WhereRelation createFromJson(Map m) => WhereRelationBase.fromJson(m);
  static WhereRelation _createFromJson(Map? m) =>
      m == null ? WhereRelation() : WhereRelationBase.fromJson(m);
  static WhereRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.WhereRelation_CLASS:
        return WhereRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.WhereRelation_CLASS;
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

  Filters get filters => _filters;

  set filters(Filters $o) {
    if ($o == _filters) return;
    _filters.parent = null;
    $o.parent = this;
    var $old = _filters;
    _filters = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.filters_OP, $old, _filters));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.relation_OP:
        return relation;
      case Vocabulary.filters_OP:
        return filters;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.relation_OP:
        relation = $value as Relation;
        return;
      case Vocabulary.filters_OP:
        filters = $value as Filters;
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
  WhereRelation copy() => WhereRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.WhereRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.WhereRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relation_OP] = relation.toJson();
    m[Vocabulary.filters_OP] = filters.toJson();
    return m;
  }
}
