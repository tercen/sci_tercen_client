part of sci_model_base;

class UnionRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [Vocabulary.relations_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Relation> relations;

  UnionRelationBase() : relations = base.ListChanged<Relation>() {
    relations.parent = this;
  }

  UnionRelationBase.json(Map m)
      : relations = base.ListChanged<Relation>.from(
            m[Vocabulary.relations_OP] as List?, RelationBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.UnionRelation_CLASS, m);
    relations.parent = this;
  }

  static UnionRelation createFromJson(Map m) => UnionRelationBase.fromJson(m);
  static UnionRelation _createFromJson(Map? m) =>
      m == null ? UnionRelation() : UnionRelationBase.fromJson(m);
  static UnionRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.UnionRelation_CLASS:
        return UnionRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.UnionRelation_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.relations_OP:
        return relations;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.relations_OP:
        relations.setValues($value as Iterable<Relation>);
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
  UnionRelation copy() => UnionRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.UnionRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.UnionRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relations_OP] = relations.toJson();
    return m;
  }
}
