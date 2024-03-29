part of sci_model_base;

class AceBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.principals_OP,
    Vocabulary.privileges_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Principal> principals;
  final base.ListChanged<Privilege> privileges;

  AceBase()
      : principals = base.ListChanged<Principal>(),
        privileges = base.ListChanged<Privilege>() {
    principals.parent = this;
    privileges.parent = this;
  }

  AceBase.json(Map m)
      : principals = base.ListChanged<Principal>.from(
            m[Vocabulary.principals_OP] as List?, PrincipalBase.createFromJson),
        privileges = base.ListChanged<Privilege>.from(
            m[Vocabulary.privileges_OP] as List?, PrivilegeBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Ace_CLASS, m);
    principals.parent = this;
    privileges.parent = this;
  }

  static Ace createFromJson(Map m) => AceBase.fromJson(m);
  static Ace _createFromJson(Map? m) => m == null ? Ace() : AceBase.fromJson(m);
  static Ace fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Ace_CLASS:
        return Ace.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Ace_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.principals_OP:
        return principals;
      case Vocabulary.privileges_OP:
        return privileges;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.principals_OP:
        principals.setValues($value as Iterable<Principal>);
        return;
      case Vocabulary.privileges_OP:
        privileges.setValues($value as Iterable<Privilege>);
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
  Ace copy() => Ace.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Ace_CLASS;
    if (subKind != null && subKind != Vocabulary.Ace_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.principals_OP] = principals.toJson();
    m[Vocabulary.privileges_OP] = privileges.toJson();
    return m;
  }
}
