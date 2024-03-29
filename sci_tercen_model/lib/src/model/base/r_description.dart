part of sci_model_base;

class RDescriptionBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.Package_DP,
    Vocabulary.Version_DP,
    Vocabulary.Depends_DP,
    Vocabulary.Imports_DP,
    Vocabulary.LinkingTo_DP,
    Vocabulary.Suggests_DP,
    Vocabulary.License_DP,
    Vocabulary.MD5sum_DP,
    Vocabulary.NeedsCompilation_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _Package;
  String _Version;
  String _Depends;
  String _Imports;
  String _LinkingTo;
  String _Suggests;
  String _License;
  String _MD5sum;
  String _NeedsCompilation;

  RDescriptionBase()
      : _Package = "",
        _Version = "",
        _Depends = "",
        _Imports = "",
        _LinkingTo = "",
        _Suggests = "",
        _License = "",
        _MD5sum = "",
        _NeedsCompilation = "";
  RDescriptionBase.json(Map m)
      : _Package = base.defaultValue(
            m[Vocabulary.Package_DP] as String?, base.String_DefaultFactory),
        _Version = base.defaultValue(
            m[Vocabulary.Version_DP] as String?, base.String_DefaultFactory),
        _Depends = base.defaultValue(
            m[Vocabulary.Depends_DP] as String?, base.String_DefaultFactory),
        _Imports = base.defaultValue(
            m[Vocabulary.Imports_DP] as String?, base.String_DefaultFactory),
        _LinkingTo = base.defaultValue(
            m[Vocabulary.LinkingTo_DP] as String?, base.String_DefaultFactory),
        _Suggests = base.defaultValue(
            m[Vocabulary.Suggests_DP] as String?, base.String_DefaultFactory),
        _License = base.defaultValue(
            m[Vocabulary.License_DP] as String?, base.String_DefaultFactory),
        _MD5sum = base.defaultValue(
            m[Vocabulary.MD5sum_DP] as String?, base.String_DefaultFactory),
        _NeedsCompilation = base.defaultValue(
            m[Vocabulary.NeedsCompilation_DP] as String?,
            base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RDescription_CLASS, m);
  }

  static RDescription createFromJson(Map m) => RDescriptionBase.fromJson(m);
  static RDescription _createFromJson(Map? m) =>
      m == null ? RDescription() : RDescriptionBase.fromJson(m);
  static RDescription fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RDescription_CLASS:
        return RDescription.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RDescription_CLASS;
  String get Package => _Package;

  set Package(String $o) {
    if ($o == _Package) return;
    var $old = _Package;
    _Package = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.Package_DP, $old, _Package));
    }
  }

  String get Version => _Version;

  set Version(String $o) {
    if ($o == _Version) return;
    var $old = _Version;
    _Version = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.Version_DP, $old, _Version));
    }
  }

  String get Depends => _Depends;

  set Depends(String $o) {
    if ($o == _Depends) return;
    var $old = _Depends;
    _Depends = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.Depends_DP, $old, _Depends));
    }
  }

  String get Imports => _Imports;

  set Imports(String $o) {
    if ($o == _Imports) return;
    var $old = _Imports;
    _Imports = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.Imports_DP, $old, _Imports));
    }
  }

  String get LinkingTo => _LinkingTo;

  set LinkingTo(String $o) {
    if ($o == _LinkingTo) return;
    var $old = _LinkingTo;
    _LinkingTo = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.LinkingTo_DP, $old, _LinkingTo));
    }
  }

  String get Suggests => _Suggests;

  set Suggests(String $o) {
    if ($o == _Suggests) return;
    var $old = _Suggests;
    _Suggests = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.Suggests_DP, $old, _Suggests));
    }
  }

  String get License => _License;

  set License(String $o) {
    if ($o == _License) return;
    var $old = _License;
    _License = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.License_DP, $old, _License));
    }
  }

  String get MD5sum => _MD5sum;

  set MD5sum(String $o) {
    if ($o == _MD5sum) return;
    var $old = _MD5sum;
    _MD5sum = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.MD5sum_DP, $old, _MD5sum));
    }
  }

  String get NeedsCompilation => _NeedsCompilation;

  set NeedsCompilation(String $o) {
    if ($o == _NeedsCompilation) return;
    var $old = _NeedsCompilation;
    _NeedsCompilation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.NeedsCompilation_DP, $old, _NeedsCompilation));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.Package_DP:
        return Package;
      case Vocabulary.Version_DP:
        return Version;
      case Vocabulary.Depends_DP:
        return Depends;
      case Vocabulary.Imports_DP:
        return Imports;
      case Vocabulary.LinkingTo_DP:
        return LinkingTo;
      case Vocabulary.Suggests_DP:
        return Suggests;
      case Vocabulary.License_DP:
        return License;
      case Vocabulary.MD5sum_DP:
        return MD5sum;
      case Vocabulary.NeedsCompilation_DP:
        return NeedsCompilation;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.Package_DP:
        Package = $value as String;
        return;
      case Vocabulary.Version_DP:
        Version = $value as String;
        return;
      case Vocabulary.Depends_DP:
        Depends = $value as String;
        return;
      case Vocabulary.Imports_DP:
        Imports = $value as String;
        return;
      case Vocabulary.LinkingTo_DP:
        LinkingTo = $value as String;
        return;
      case Vocabulary.Suggests_DP:
        Suggests = $value as String;
        return;
      case Vocabulary.License_DP:
        License = $value as String;
        return;
      case Vocabulary.MD5sum_DP:
        MD5sum = $value as String;
        return;
      case Vocabulary.NeedsCompilation_DP:
        NeedsCompilation = $value as String;
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
  RDescription copy() => RDescription.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RDescription_CLASS;
    if (subKind != null && subKind != Vocabulary.RDescription_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.Package_DP] = Package;
    m[Vocabulary.Version_DP] = Version;
    m[Vocabulary.Depends_DP] = Depends;
    m[Vocabulary.Imports_DP] = Imports;
    m[Vocabulary.LinkingTo_DP] = LinkingTo;
    m[Vocabulary.Suggests_DP] = Suggests;
    m[Vocabulary.License_DP] = License;
    m[Vocabulary.MD5sum_DP] = MD5sum;
    m[Vocabulary.NeedsCompilation_DP] = NeedsCompilation;
    return m;
  }
}
