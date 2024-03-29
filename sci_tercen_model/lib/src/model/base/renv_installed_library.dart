part of sci_model_base;

class RenvInstalledLibraryBase extends RLibrary {
  static const List<String> PROPERTY_NAMES = [Vocabulary.path_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _path;

  RenvInstalledLibraryBase() : _path = "";
  RenvInstalledLibraryBase.json(Map m)
      : _path = base.defaultValue(
            m[Vocabulary.path_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RenvInstalledLibrary_CLASS, m);
  }

  static RenvInstalledLibrary createFromJson(Map m) =>
      RenvInstalledLibraryBase.fromJson(m);
  static RenvInstalledLibrary _createFromJson(Map? m) =>
      m == null ? RenvInstalledLibrary() : RenvInstalledLibraryBase.fromJson(m);
  static RenvInstalledLibrary fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RenvInstalledLibrary_CLASS:
        return RenvInstalledLibrary.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RenvInstalledLibrary_CLASS;
  String get path => _path;

  set path(String $o) {
    if ($o == _path) return;
    var $old = _path;
    _path = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.path_DP, $old, _path));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.path_DP:
        return path;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.path_DP:
        path = $value as String;
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
  RenvInstalledLibrary copy() => RenvInstalledLibrary.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RenvInstalledLibrary_CLASS;
    if (subKind != null && subKind != Vocabulary.RenvInstalledLibrary_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.path_DP] = path;
    return m;
  }
}
