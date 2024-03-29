part of sci_model_base;

class GroupByRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.relation_OP,
    Vocabulary.group_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Relation _relation;
  final base.ListChangedBase<String> group;

  GroupByRelationBase()
      : group = base.ListChangedBase<String>(),
        _relation = Relation() {
    group.parent = this;
    _relation.parent = this;
  }

  GroupByRelationBase.json(Map m)
      : group = base.ListChangedBase<String>(m[Vocabulary.group_DP] as List?),
        _relation =
            RelationBase._createFromJson(m[Vocabulary.relation_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GroupByRelation_CLASS, m);
    group.parent = this;
    _relation.parent = this;
  }

  static GroupByRelation createFromJson(Map m) =>
      GroupByRelationBase.fromJson(m);
  static GroupByRelation _createFromJson(Map? m) =>
      m == null ? GroupByRelation() : GroupByRelationBase.fromJson(m);
  static GroupByRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GroupByRelation_CLASS:
        return GroupByRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GroupByRelation_CLASS;
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
      case Vocabulary.group_DP:
        return group;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.group_DP:
        group.setValues($value as Iterable<String>);
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
  GroupByRelation copy() => GroupByRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GroupByRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.GroupByRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relation_OP] = relation.toJson();
    m[Vocabulary.group_DP] = group;
    return m;
  }
}
