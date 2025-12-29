part of sci_model_base;

class TypedValueBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  TypedValueBase();
  TypedValueBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TypedValue_CLASS, m);
  }

  static TypedValue createFromJson(Map m) => TypedValueBase.fromJson(m);
  static TypedValue fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TypedValue_CLASS:
        return TypedValue.json(m);
      case Vocabulary.TypedBool_CLASS:
        return TypedBool.json(m);
      case Vocabulary.TypedDouble_CLASS:
        return TypedDouble.json(m);
      case Vocabulary.TypedIntValue_CLASS:
        return TypedIntValue.json(m);
      case Vocabulary.TypedObject_CLASS:
        return TypedObject.json(m);
      case Vocabulary.TypedList_CLASS:
        return TypedList.json(m);
      case Vocabulary.TypedString_CLASS:
        return TypedString.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TypedValue_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  TypedValue copy() => TypedValue.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TypedValue_CLASS;
    if (subKind != null && subKind != Vocabulary.TypedValue_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
