part of sci_model_base;

class ProfilesBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.apiProfile_OP,
    Vocabulary.tableProfile_OP,
    Vocabulary.cpuTimeProfile_OP,
    Vocabulary.storageProfile_OP,
    Vocabulary.runProfile_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  ApiCallProfile _apiProfile;
  TableProfile _tableProfile;
  CpuTimeProfile _cpuTimeProfile;
  StorageProfile _storageProfile;
  RunProfile _runProfile;

  ProfilesBase()
      : _apiProfile = ApiCallProfile(),
        _tableProfile = TableProfile(),
        _cpuTimeProfile = CpuTimeProfile(),
        _storageProfile = StorageProfile(),
        _runProfile = RunProfile() {
    _apiProfile.parent = this;
    _tableProfile.parent = this;
    _cpuTimeProfile.parent = this;
    _storageProfile.parent = this;
    _runProfile.parent = this;
  }

  ProfilesBase.json(Map m)
      : _apiProfile = ApiCallProfileBase._createFromJson(
            m[Vocabulary.apiProfile_OP] as Map?),
        _tableProfile = TableProfileBase._createFromJson(
            m[Vocabulary.tableProfile_OP] as Map?),
        _cpuTimeProfile = CpuTimeProfileBase._createFromJson(
            m[Vocabulary.cpuTimeProfile_OP] as Map?),
        _storageProfile = StorageProfileBase._createFromJson(
            m[Vocabulary.storageProfile_OP] as Map?),
        _runProfile =
            RunProfileBase._createFromJson(m[Vocabulary.runProfile_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Profiles_CLASS, m);
    _apiProfile.parent = this;
    _tableProfile.parent = this;
    _cpuTimeProfile.parent = this;
    _storageProfile.parent = this;
    _runProfile.parent = this;
  }

  static Profiles createFromJson(Map m) => ProfilesBase.fromJson(m);
  static Profiles _createFromJson(Map? m) =>
      m == null ? Profiles() : ProfilesBase.fromJson(m);
  static Profiles fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Profiles_CLASS:
        return Profiles.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Profiles_CLASS;
  ApiCallProfile get apiProfile => _apiProfile;

  set apiProfile(ApiCallProfile $o) {
    if ($o == _apiProfile) return;
    _apiProfile.parent = null;
    $o.parent = this;
    var $old = _apiProfile;
    _apiProfile = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.apiProfile_OP, $old, _apiProfile));
    }
  }

  TableProfile get tableProfile => _tableProfile;

  set tableProfile(TableProfile $o) {
    if ($o == _tableProfile) return;
    _tableProfile.parent = null;
    $o.parent = this;
    var $old = _tableProfile;
    _tableProfile = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.tableProfile_OP, $old, _tableProfile));
    }
  }

  CpuTimeProfile get cpuTimeProfile => _cpuTimeProfile;

  set cpuTimeProfile(CpuTimeProfile $o) {
    if ($o == _cpuTimeProfile) return;
    _cpuTimeProfile.parent = null;
    $o.parent = this;
    var $old = _cpuTimeProfile;
    _cpuTimeProfile = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cpuTimeProfile_OP, $old, _cpuTimeProfile));
    }
  }

  StorageProfile get storageProfile => _storageProfile;

  set storageProfile(StorageProfile $o) {
    if ($o == _storageProfile) return;
    _storageProfile.parent = null;
    $o.parent = this;
    var $old = _storageProfile;
    _storageProfile = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.storageProfile_OP, $old, _storageProfile));
    }
  }

  RunProfile get runProfile => _runProfile;

  set runProfile(RunProfile $o) {
    if ($o == _runProfile) return;
    _runProfile.parent = null;
    $o.parent = this;
    var $old = _runProfile;
    _runProfile = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.runProfile_OP, $old, _runProfile));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.apiProfile_OP:
        return apiProfile;
      case Vocabulary.tableProfile_OP:
        return tableProfile;
      case Vocabulary.cpuTimeProfile_OP:
        return cpuTimeProfile;
      case Vocabulary.storageProfile_OP:
        return storageProfile;
      case Vocabulary.runProfile_OP:
        return runProfile;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.apiProfile_OP:
        apiProfile = $value as ApiCallProfile;
        return;
      case Vocabulary.tableProfile_OP:
        tableProfile = $value as TableProfile;
        return;
      case Vocabulary.cpuTimeProfile_OP:
        cpuTimeProfile = $value as CpuTimeProfile;
        return;
      case Vocabulary.storageProfile_OP:
        storageProfile = $value as StorageProfile;
        return;
      case Vocabulary.runProfile_OP:
        runProfile = $value as RunProfile;
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
  Profiles copy() => Profiles.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Profiles_CLASS;
    if (subKind != null && subKind != Vocabulary.Profiles_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.apiProfile_OP] = apiProfile.toJson();
    m[Vocabulary.tableProfile_OP] = tableProfile.toJson();
    m[Vocabulary.cpuTimeProfile_OP] = cpuTimeProfile.toJson();
    m[Vocabulary.storageProfile_OP] = storageProfile.toJson();
    m[Vocabulary.runProfile_OP] = runProfile.toJson();
    return m;
  }
}
