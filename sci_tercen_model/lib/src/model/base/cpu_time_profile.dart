part of sci_model_base;

class CpuTimeProfileBase extends Profile {
  static const List<String> PROPERTY_NAMES = [Vocabulary.cpuTime_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  double _cpuTime;

  CpuTimeProfileBase() : _cpuTime = 0.0;
  CpuTimeProfileBase.json(Map m)
      : _cpuTime = base.defaultDouble(m[Vocabulary.cpuTime_DP] as num?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CpuTimeProfile_CLASS, m);
  }

  static CpuTimeProfile createFromJson(Map m) => CpuTimeProfileBase.fromJson(m);
  static CpuTimeProfile _createFromJson(Map? m) =>
      m == null ? CpuTimeProfile() : CpuTimeProfileBase.fromJson(m);
  static CpuTimeProfile fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CpuTimeProfile_CLASS:
        return CpuTimeProfile.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CpuTimeProfile_CLASS;
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

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.cpuTime_DP:
        return cpuTime;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.cpuTime_DP:
        cpuTime = $value as double;
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
  CpuTimeProfile copy() => CpuTimeProfile.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CpuTimeProfile_CLASS;
    if (subKind != null && subKind != Vocabulary.CpuTimeProfile_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.cpuTime_DP] = cpuTime;
    return m;
  }
}
