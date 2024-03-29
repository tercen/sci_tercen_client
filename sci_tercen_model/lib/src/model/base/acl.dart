part of sci_model_base;

class AclBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.owner_DP,
    Vocabulary.aces_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.owner_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("User", Vocabulary.owner_DP, isComposite: false)
  ];
  String _owner;
  final base.ListChanged<Ace> aces;

  AclBase()
      : _owner = "",
        aces = base.ListChanged<Ace>() {
    aces.parent = this;
  }

  AclBase.json(Map m)
      : _owner = base.defaultValue(
            m[Vocabulary.owner_DP] as String?, base.String_DefaultFactory),
        aces = base.ListChanged<Ace>.from(
            m[Vocabulary.aces_OP] as List?, AceBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Acl_CLASS, m);
    aces.parent = this;
  }

  static Acl createFromJson(Map m) => AclBase.fromJson(m);
  static Acl _createFromJson(Map? m) => m == null ? Acl() : AclBase.fromJson(m);
  static Acl fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Acl_CLASS:
        return Acl.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Acl_CLASS;
  String get owner => _owner;

  set owner(String $o) {
    if ($o == _owner) return;
    var $old = _owner;
    _owner = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.owner_DP, $old, _owner));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.owner_DP:
        return owner;
      case Vocabulary.aces_OP:
        return aces;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.owner_DP:
        owner = $value as String;
        return;
      case Vocabulary.aces_OP:
        aces.setValues($value as Iterable<Ace>);
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
  Acl copy() => Acl.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Acl_CLASS;
    if (subKind != null && subKind != Vocabulary.Acl_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.owner_DP] = owner;
    m[Vocabulary.aces_OP] = aces.toJson();
    return m;
  }
}
