part of sci_model_base;

class ProfileBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.name_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;

  ProfileBase() : _name = "";
  ProfileBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Profile_CLASS, m);
  }

  static Profile createFromJson(Map m) => ProfileBase.fromJson(m);
  static Profile _createFromJson(Map? m) =>
      m == null ? Profile() : ProfileBase.fromJson(m);
  static Profile fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Profile_CLASS:
        return Profile.json(m);
      case Vocabulary.StorageProfile_CLASS:
        return StorageProfile.json(m);
      case Vocabulary.RunProfile_CLASS:
        return RunProfile.json(m);
      case Vocabulary.CpuTimeProfile_CLASS:
        return CpuTimeProfile.json(m);
      case Vocabulary.TableProfile_CLASS:
        return TableProfile.json(m);
      case Vocabulary.ApiCallProfile_CLASS:
        return ApiCallProfile.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Profile_CLASS;
  String get name => _name;

  set name(String $o) {
    if ($o == _name) return;
    var $old = _name;
    _name = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.name_DP, $old, _name));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.name_DP:
        name = $value as String;
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
  Profile copy() => Profile.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Profile_CLASS;
    if (subKind != null && subKind != Vocabulary.Profile_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    return m;
  }
}
