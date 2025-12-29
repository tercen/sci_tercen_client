part of sci_model_base;

class RenameRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.relation_OP,
    Vocabulary.inNames_DP,
    Vocabulary.outNames_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Relation _relation;
  final base.ListChangedBase<String> inNames;
  final base.ListChangedBase<String> outNames;

  RenameRelationBase()
      : inNames = base.ListChangedBase<String>(),
        outNames = base.ListChangedBase<String>(),
        _relation = Relation() {
    inNames.parent = this;
    outNames.parent = this;
    _relation.parent = this;
  }

  RenameRelationBase.json(Map m)
      : inNames =
            base.ListChangedBase<String>(m[Vocabulary.inNames_DP] as List?),
        outNames =
            base.ListChangedBase<String>(m[Vocabulary.outNames_DP] as List?),
        _relation = (m[Vocabulary.relation_OP] as Map?) == null
            ? Relation()
            : RelationBase.fromJson(m[Vocabulary.relation_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RenameRelation_CLASS, m);
    inNames.parent = this;
    outNames.parent = this;
    _relation.parent = this;
  }

  static RenameRelation createFromJson(Map m) => RenameRelationBase.fromJson(m);
  static RenameRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RenameRelation_CLASS:
        return RenameRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RenameRelation_CLASS;
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
      case Vocabulary.inNames_DP:
        return inNames;
      case Vocabulary.outNames_DP:
        return outNames;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.inNames_DP:
        inNames.setValues($value as Iterable<String>);
        return;
      case Vocabulary.outNames_DP:
        outNames.setValues($value as Iterable<String>);
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
  RenameRelation copy() => RenameRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RenameRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.RenameRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relation_OP] = relation.toJson();
    m[Vocabulary.inNames_DP] = inNames;
    m[Vocabulary.outNames_DP] = outNames;
    return m;
  }
}
