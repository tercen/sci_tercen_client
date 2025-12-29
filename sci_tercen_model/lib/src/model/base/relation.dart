part of sci_model_base;

class RelationBase extends IdObject {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  RelationBase();
  RelationBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Relation_CLASS, m);
  }

  static Relation createFromJson(Map m) => RelationBase.fromJson(m);
  static Relation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Relation_CLASS:
        return Relation.json(m);
      case Vocabulary.TableRelation_CLASS:
        return TableRelation.json(m);
      case Vocabulary.WhereRelation_CLASS:
        return WhereRelation.json(m);
      case Vocabulary.DistinctRelation_CLASS:
        return DistinctRelation.json(m);
      case Vocabulary.SelectPairwiseRelation_CLASS:
        return SelectPairwiseRelation.json(m);
      case Vocabulary.ReferenceRelation_CLASS:
        return ReferenceRelation.json(m);
      case Vocabulary.InMemoryRelation_CLASS:
        return InMemoryRelation.json(m);
      case Vocabulary.PairwiseRelation_CLASS:
        return PairwiseRelation.json(m);
      case Vocabulary.RenameRelation_CLASS:
        return RenameRelation.json(m);
      case Vocabulary.UnionRelation_CLASS:
        return UnionRelation.json(m);
      case Vocabulary.RangeRelation_CLASS:
        return RangeRelation.json(m);
      case Vocabulary.SimpleRelation_CLASS:
        return SimpleRelation.json(m);
      case Vocabulary.GatherRelation_CLASS:
        return GatherRelation.json(m);
      case Vocabulary.CompositeRelation_CLASS:
        return CompositeRelation.json(m);
      case Vocabulary.GroupByRelation_CLASS:
        return GroupByRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Relation_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  Relation copy() => Relation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Relation_CLASS;
    if (subKind != null && subKind != Vocabulary.Relation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
