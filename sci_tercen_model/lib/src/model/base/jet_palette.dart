part of sci_model_base;

class JetPaletteBase extends RampPalette {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  JetPaletteBase();
  JetPaletteBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.JetPalette_CLASS, m);
  }

  static JetPalette createFromJson(Map m) => JetPaletteBase.fromJson(m);
  static JetPalette _createFromJson(Map? m) =>
      m == null ? JetPalette() : JetPaletteBase.fromJson(m);
  static JetPalette fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.JetPalette_CLASS:
        return JetPalette.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.JetPalette_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  JetPalette copy() => JetPalette.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.JetPalette_CLASS;
    if (subKind != null && subKind != Vocabulary.JetPalette_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
