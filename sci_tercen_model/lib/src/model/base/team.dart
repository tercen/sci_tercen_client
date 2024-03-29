part of sci_model_base;

class TeamBase extends User {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  TeamBase();
  TeamBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Team_CLASS, m);
  }

  static Team createFromJson(Map m) => TeamBase.fromJson(m);
  static Team _createFromJson(Map? m) =>
      m == null ? Team() : TeamBase.fromJson(m);
  static Team fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Team_CLASS:
        return Team.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Team_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  Team copy() => Team.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Team_CLASS;
    if (subKind != null && subKind != Vocabulary.Team_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
