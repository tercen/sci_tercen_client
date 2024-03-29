part of sci_model_base;

class ResourceSummaryBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.storage_DP,
    Vocabulary.usedStorage_DP,
    Vocabulary.cpuTime_DP,
    Vocabulary.usedCpuTime_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  double _storage;
  double _usedStorage;
  double _cpuTime;
  double _usedCpuTime;

  ResourceSummaryBase()
      : _storage = 0.0,
        _usedStorage = 0.0,
        _cpuTime = 0.0,
        _usedCpuTime = 0.0;
  ResourceSummaryBase.json(Map m)
      : _storage = base.defaultDouble(m[Vocabulary.storage_DP] as num?),
        _usedStorage = base.defaultDouble(m[Vocabulary.usedStorage_DP] as num?),
        _cpuTime = base.defaultDouble(m[Vocabulary.cpuTime_DP] as num?),
        _usedCpuTime = base.defaultDouble(m[Vocabulary.usedCpuTime_DP] as num?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ResourceSummary_CLASS, m);
  }

  static ResourceSummary createFromJson(Map m) =>
      ResourceSummaryBase.fromJson(m);
  static ResourceSummary _createFromJson(Map? m) =>
      m == null ? ResourceSummary() : ResourceSummaryBase.fromJson(m);
  static ResourceSummary fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ResourceSummary_CLASS:
        return ResourceSummary.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ResourceSummary_CLASS;
  double get storage => _storage;

  set storage(double $o) {
    if ($o == _storage) return;
    var $old = _storage;
    _storage = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.storage_DP, $old, _storage));
    }
  }

  double get usedStorage => _usedStorage;

  set usedStorage(double $o) {
    if ($o == _usedStorage) return;
    var $old = _usedStorage;
    _usedStorage = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.usedStorage_DP, $old, _usedStorage));
    }
  }

  double get cpuTime => _cpuTime;

  set cpuTime(double $o) {
    if ($o == _cpuTime) return;
    var $old = _cpuTime;
    _cpuTime = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cpuTime_DP, $old, _cpuTime));
    }
  }

  double get usedCpuTime => _usedCpuTime;

  set usedCpuTime(double $o) {
    if ($o == _usedCpuTime) return;
    var $old = _usedCpuTime;
    _usedCpuTime = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.usedCpuTime_DP, $old, _usedCpuTime));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.storage_DP:
        return storage;
      case Vocabulary.usedStorage_DP:
        return usedStorage;
      case Vocabulary.cpuTime_DP:
        return cpuTime;
      case Vocabulary.usedCpuTime_DP:
        return usedCpuTime;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.storage_DP:
        storage = $value as double;
        return;
      case Vocabulary.usedStorage_DP:
        usedStorage = $value as double;
        return;
      case Vocabulary.cpuTime_DP:
        cpuTime = $value as double;
        return;
      case Vocabulary.usedCpuTime_DP:
        usedCpuTime = $value as double;
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
  ResourceSummary copy() => ResourceSummary.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ResourceSummary_CLASS;
    if (subKind != null && subKind != Vocabulary.ResourceSummary_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.storage_DP] = storage;
    m[Vocabulary.usedStorage_DP] = usedStorage;
    m[Vocabulary.cpuTime_DP] = cpuTime;
    m[Vocabulary.usedCpuTime_DP] = usedCpuTime;
    return m;
  }
}
