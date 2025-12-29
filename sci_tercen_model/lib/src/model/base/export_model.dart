part of sci_model_base;

class ExportModelBase extends StepModel {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  ExportModelBase();
  ExportModelBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ExportModel_CLASS, m);
  }

  static ExportModel createFromJson(Map m) => ExportModelBase.fromJson(m);
  static ExportModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ExportModel_CLASS:
        return ExportModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ExportModel_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ExportModel copy() => ExportModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ExportModel_CLASS;
    if (subKind != null && subKind != Vocabulary.ExportModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
