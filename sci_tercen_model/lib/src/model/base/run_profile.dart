part of sci_model_base;

class RunProfileBase extends Profile {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.memory_DP,
    Vocabulary.kernelMemory_DP,
    Vocabulary.blkioWeight_DP,
    Vocabulary.pidsLimit_DP,
    Vocabulary.ulimits_nofile_DP,
    Vocabulary.timeout_DP,
    Vocabulary.storageSize_DP,
    Vocabulary.cpusetCpus_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _memory;
  int _kernelMemory;
  int _blkioWeight;
  int _pidsLimit;
  int _ulimits_nofile;
  int _timeout;
  String _storageSize;
  String _cpusetCpus;

  RunProfileBase()
      : _memory = 0,
        _kernelMemory = 0,
        _blkioWeight = 0,
        _pidsLimit = 0,
        _ulimits_nofile = 0,
        _timeout = 0,
        _storageSize = "",
        _cpusetCpus = "";
  RunProfileBase.json(Map m)
      : _memory = base.defaultValue(
            m[Vocabulary.memory_DP] as int?, base.int_DefaultFactory),
        _kernelMemory = base.defaultValue(
            m[Vocabulary.kernelMemory_DP] as int?, base.int_DefaultFactory),
        _blkioWeight = base.defaultValue(
            m[Vocabulary.blkioWeight_DP] as int?, base.int_DefaultFactory),
        _pidsLimit = base.defaultValue(
            m[Vocabulary.pidsLimit_DP] as int?, base.int_DefaultFactory),
        _ulimits_nofile = base.defaultValue(
            m[Vocabulary.ulimits_nofile_DP] as int?, base.int_DefaultFactory),
        _timeout = base.defaultValue(
            m[Vocabulary.timeout_DP] as int?, base.int_DefaultFactory),
        _storageSize = base.defaultValue(
            m[Vocabulary.storageSize_DP] as String?,
            base.String_DefaultFactory),
        _cpusetCpus = base.defaultValue(
            m[Vocabulary.cpusetCpus_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RunProfile_CLASS, m);
  }

  static RunProfile createFromJson(Map m) => RunProfileBase.fromJson(m);
  static RunProfile fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RunProfile_CLASS:
        return RunProfile.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RunProfile_CLASS;
  int get memory => _memory;

  set memory(int $o) {
    if ($o == _memory) return;
    var $old = _memory;
    _memory = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.memory_DP, $old, _memory));
    }
  }

  int get kernelMemory => _kernelMemory;

  set kernelMemory(int $o) {
    if ($o == _kernelMemory) return;
    var $old = _kernelMemory;
    _kernelMemory = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.kernelMemory_DP, $old, _kernelMemory));
    }
  }

  int get blkioWeight => _blkioWeight;

  set blkioWeight(int $o) {
    if ($o == _blkioWeight) return;
    var $old = _blkioWeight;
    _blkioWeight = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.blkioWeight_DP, $old, _blkioWeight));
    }
  }

  int get pidsLimit => _pidsLimit;

  set pidsLimit(int $o) {
    if ($o == _pidsLimit) return;
    var $old = _pidsLimit;
    _pidsLimit = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.pidsLimit_DP, $old, _pidsLimit));
    }
  }

  int get ulimits_nofile => _ulimits_nofile;

  set ulimits_nofile(int $o) {
    if ($o == _ulimits_nofile) return;
    var $old = _ulimits_nofile;
    _ulimits_nofile = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.ulimits_nofile_DP, $old, _ulimits_nofile));
    }
  }

  int get timeout => _timeout;

  set timeout(int $o) {
    if ($o == _timeout) return;
    var $old = _timeout;
    _timeout = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.timeout_DP, $old, _timeout));
    }
  }

  String get storageSize => _storageSize;

  set storageSize(String $o) {
    if ($o == _storageSize) return;
    var $old = _storageSize;
    _storageSize = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.storageSize_DP, $old, _storageSize));
    }
  }

  String get cpusetCpus => _cpusetCpus;

  set cpusetCpus(String $o) {
    if ($o == _cpusetCpus) return;
    var $old = _cpusetCpus;
    _cpusetCpus = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cpusetCpus_DP, $old, _cpusetCpus));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.memory_DP:
        return memory;
      case Vocabulary.kernelMemory_DP:
        return kernelMemory;
      case Vocabulary.blkioWeight_DP:
        return blkioWeight;
      case Vocabulary.pidsLimit_DP:
        return pidsLimit;
      case Vocabulary.ulimits_nofile_DP:
        return ulimits_nofile;
      case Vocabulary.timeout_DP:
        return timeout;
      case Vocabulary.storageSize_DP:
        return storageSize;
      case Vocabulary.cpusetCpus_DP:
        return cpusetCpus;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.memory_DP:
        memory = $value as int;
        return;
      case Vocabulary.kernelMemory_DP:
        kernelMemory = $value as int;
        return;
      case Vocabulary.blkioWeight_DP:
        blkioWeight = $value as int;
        return;
      case Vocabulary.pidsLimit_DP:
        pidsLimit = $value as int;
        return;
      case Vocabulary.ulimits_nofile_DP:
        ulimits_nofile = $value as int;
        return;
      case Vocabulary.timeout_DP:
        timeout = $value as int;
        return;
      case Vocabulary.storageSize_DP:
        storageSize = $value as String;
        return;
      case Vocabulary.cpusetCpus_DP:
        cpusetCpus = $value as String;
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
  RunProfile copy() => RunProfile.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RunProfile_CLASS;
    if (subKind != null && subKind != Vocabulary.RunProfile_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.memory_DP] = memory;
    m[Vocabulary.kernelMemory_DP] = kernelMemory;
    m[Vocabulary.blkioWeight_DP] = blkioWeight;
    m[Vocabulary.pidsLimit_DP] = pidsLimit;
    m[Vocabulary.ulimits_nofile_DP] = ulimits_nofile;
    m[Vocabulary.timeout_DP] = timeout;
    m[Vocabulary.storageSize_DP] = storageSize;
    m[Vocabulary.cpusetCpus_DP] = cpusetCpus;
    return m;
  }
}
