part of sci_model_base;

class FilterTopExprBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  FilterTopExprBase();
  FilterTopExprBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FilterTopExpr_CLASS, m);
  }

  static FilterTopExpr createFromJson(Map m) => FilterTopExprBase.fromJson(m);
  static FilterTopExpr fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FilterTopExpr_CLASS:
        return FilterTopExpr.json(m);
      case Vocabulary.NamedFilter_CLASS:
        return NamedFilter.json(m);
      case Vocabulary.FilterExpr2d_CLASS:
        return FilterExpr2d.json(m);
      case Vocabulary.Filter_CLASS:
        return Filter.json(m);
      case Vocabulary.FilterExpr_CLASS:
        return FilterExpr.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FilterTopExpr_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  FilterTopExpr copy() => FilterTopExpr.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FilterTopExpr_CLASS;
    if (subKind != null && subKind != Vocabulary.FilterTopExpr_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
