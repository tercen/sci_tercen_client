part of sci_model_base;

class AttributeBase extends Factor {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  AttributeBase();
  AttributeBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Attribute_CLASS, m);
  }

  static Attribute createFromJson(Map m) => AttributeBase.fromJson(m);
  static Attribute _createFromJson(Map? m) =>
      m == null ? Attribute() : AttributeBase.fromJson(m);
  static Attribute fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Attribute_CLASS:
        return Attribute.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Attribute_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  Attribute copy() => Attribute.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Attribute_CLASS;
    if (subKind != null && subKind != Vocabulary.Attribute_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
