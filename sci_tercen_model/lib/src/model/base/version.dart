part of sci_model_base;

class VersionBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.major_DP,
    Vocabulary.minor_DP,
    Vocabulary.patch_DP,
    Vocabulary.tag_DP,
    Vocabulary.date_DP,
    Vocabulary.commit_DP,
    Vocabulary.features_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _major;
  int _minor;
  int _patch;
  String _tag;
  String _date;
  String _commit;
  final base.ListChangedBase<String> features;

  VersionBase()
      : _major = 0,
        _minor = 0,
        _patch = 0,
        _tag = "",
        _date = "",
        _commit = "",
        features = base.ListChangedBase<String>() {
    features.parent = this;
  }

  VersionBase.json(Map m)
      : _major = base.defaultValue(
            m[Vocabulary.major_DP] as int?, base.int_DefaultFactory),
        _minor = base.defaultValue(
            m[Vocabulary.minor_DP] as int?, base.int_DefaultFactory),
        _patch = base.defaultValue(
            m[Vocabulary.patch_DP] as int?, base.int_DefaultFactory),
        _tag = base.defaultValue(
            m[Vocabulary.tag_DP] as String?, base.String_DefaultFactory),
        _date = base.defaultValue(
            m[Vocabulary.date_DP] as String?, base.String_DefaultFactory),
        _commit = base.defaultValue(
            m[Vocabulary.commit_DP] as String?, base.String_DefaultFactory),
        features =
            base.ListChangedBase<String>(m[Vocabulary.features_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Version_CLASS, m);
    features.parent = this;
  }

  static Version createFromJson(Map m) => VersionBase.fromJson(m);
  static Version _createFromJson(Map? m) =>
      m == null ? Version() : VersionBase.fromJson(m);
  static Version fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Version_CLASS:
        return Version.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Version_CLASS;
  int get major => _major;

  set major(int $o) {
    if ($o == _major) return;
    var $old = _major;
    _major = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.major_DP, $old, _major));
    }
  }

  int get minor => _minor;

  set minor(int $o) {
    if ($o == _minor) return;
    var $old = _minor;
    _minor = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.minor_DP, $old, _minor));
    }
  }

  int get patch => _patch;

  set patch(int $o) {
    if ($o == _patch) return;
    var $old = _patch;
    _patch = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.patch_DP, $old, _patch));
    }
  }

  String get tag => _tag;

  set tag(String $o) {
    if ($o == _tag) return;
    var $old = _tag;
    _tag = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.tag_DP, $old, _tag));
    }
  }

  String get date => _date;

  set date(String $o) {
    if ($o == _date) return;
    var $old = _date;
    _date = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.date_DP, $old, _date));
    }
  }

  String get commit => _commit;

  set commit(String $o) {
    if ($o == _commit) return;
    var $old = _commit;
    _commit = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.commit_DP, $old, _commit));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.major_DP:
        return major;
      case Vocabulary.minor_DP:
        return minor;
      case Vocabulary.patch_DP:
        return patch;
      case Vocabulary.tag_DP:
        return tag;
      case Vocabulary.date_DP:
        return date;
      case Vocabulary.commit_DP:
        return commit;
      case Vocabulary.features_DP:
        return features;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.major_DP:
        major = $value as int;
        return;
      case Vocabulary.minor_DP:
        minor = $value as int;
        return;
      case Vocabulary.patch_DP:
        patch = $value as int;
        return;
      case Vocabulary.tag_DP:
        tag = $value as String;
        return;
      case Vocabulary.date_DP:
        date = $value as String;
        return;
      case Vocabulary.commit_DP:
        commit = $value as String;
        return;
      case Vocabulary.features_DP:
        features.setValues($value as Iterable<String>);
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
  Version copy() => Version.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Version_CLASS;
    if (subKind != null && subKind != Vocabulary.Version_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.major_DP] = major;
    m[Vocabulary.minor_DP] = minor;
    m[Vocabulary.patch_DP] = patch;
    m[Vocabulary.tag_DP] = tag;
    m[Vocabulary.date_DP] = date;
    m[Vocabulary.commit_DP] = commit;
    m[Vocabulary.features_DP] = features;
    return m;
  }
}
