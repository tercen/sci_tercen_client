part of sci_model_base;

class PatchResultBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.warnings_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  static const List<base.PropertyConstraint> CONSTRAINTS = [];
  final base.ListChangedBase<String> warnings;

  PatchResultBase() : warnings = base.ListChangedBase<String>() {
    warnings.parent = this;
  }

  PatchResultBase.json(Map m)
      : warnings =
            base.ListChangedBase<String>(m[Vocabulary.warnings_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PatchResult_CLASS, m);
    warnings.parent = this;
  }

  static PatchResult createFromJson(Map m) => PatchResultBase.fromJson(m);
  static PatchResult fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PatchResult_CLASS:
        return PatchResult.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PatchResult_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.warnings_DP:
        return warnings;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.warnings_DP:
        warnings.setValues($value as Iterable<String>);
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
  Iterable<base.PropertyConstraint> constraints() =>
      super.constraints().followedBy(CONSTRAINTS);

  @override
  PatchResult copy() => PatchResult.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PatchResult_CLASS;
    if (subKind != null && subKind != Vocabulary.PatchResult_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.warnings_DP] = warnings;
    return m;
  }
}
