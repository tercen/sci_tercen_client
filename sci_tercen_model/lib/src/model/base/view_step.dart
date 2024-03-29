part of sci_model_base;

class ViewStepBase extends Step {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  ViewStepBase();
  ViewStepBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ViewStep_CLASS, m);
  }

  static ViewStep createFromJson(Map m) => ViewStepBase.fromJson(m);
  static ViewStep _createFromJson(Map? m) =>
      m == null ? ViewStep() : ViewStepBase.fromJson(m);
  static ViewStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ViewStep_CLASS:
        return ViewStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ViewStep_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  ViewStep copy() => ViewStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ViewStep_CLASS;
    if (subKind != null && subKind != Vocabulary.ViewStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
