part of sci_model_base;

class CValuesBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  CValuesBase();
  CValuesBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CValues_CLASS, m);
  }

  static CValues createFromJson(Map m) => CValuesBase.fromJson(m);
  static CValues fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CValues_CLASS:
        return CValues.json(m);
      case Vocabulary.I32Values_CLASS:
        return I32Values.json(m);
      case Vocabulary.F64Values_CLASS:
        return F64Values.json(m);
      case Vocabulary.StrValues_CLASS:
        return StrValues.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CValues_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  CValues copy() => CValues.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CValues_CLASS;
    if (subKind != null && subKind != Vocabulary.CValues_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
