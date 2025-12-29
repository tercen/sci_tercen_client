part of sci_model_base;

class PrivilegeBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.type_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _type;

  PrivilegeBase() : _type = "";
  PrivilegeBase.json(Map m)
      : _type = base.defaultValue(
            m[Vocabulary.type_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Privilege_CLASS, m);
  }

  static Privilege createFromJson(Map m) => PrivilegeBase.fromJson(m);
  static Privilege fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Privilege_CLASS:
        return Privilege.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Privilege_CLASS;
  String get type => _type;

  set type(String $o) {
    if ($o == _type) return;
    var $old = _type;
    _type = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.type_DP, $old, _type));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.type_DP:
        return type;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.type_DP:
        type = $value as String;
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
  Privilege copy() => Privilege.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Privilege_CLASS;
    if (subKind != null && subKind != Vocabulary.Privilege_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.type_DP] = type;
    return m;
  }
}
