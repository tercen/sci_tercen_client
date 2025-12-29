part of sci_model_base;

class ReferenceRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [Vocabulary.relation_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Relation _relation;

  ReferenceRelationBase() : _relation = Relation() {
    _relation.parent = this;
  }

  ReferenceRelationBase.json(Map m)
      : _relation = (m[Vocabulary.relation_OP] as Map?) == null
            ? Relation()
            : RelationBase.fromJson(m[Vocabulary.relation_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ReferenceRelation_CLASS, m);
    _relation.parent = this;
  }

  static ReferenceRelation createFromJson(Map m) =>
      ReferenceRelationBase.fromJson(m);
  static ReferenceRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ReferenceRelation_CLASS:
        return ReferenceRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ReferenceRelation_CLASS;
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
  ReferenceRelation copy() => ReferenceRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ReferenceRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.ReferenceRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relation_OP] = relation.toJson();
    return m;
  }
}
