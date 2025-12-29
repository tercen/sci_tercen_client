part of sci_model_base;

class WorkerBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.status_DP,
    Vocabulary.name_DP,
    Vocabulary.uri_DP,
    Vocabulary.priority_DP,
    Vocabulary.nCPU_DP,
    Vocabulary.nThread_DP,
    Vocabulary.memory_DP,
    Vocabulary.nAvailableThread_DP,
    Vocabulary.availableMemory_DP,
    Vocabulary.availableTaskTypes_DP,
    Vocabulary.taskIds_DP,
    Vocabulary.lastDateActivity_DP,
    Vocabulary.heartBeat_DP,
    Vocabulary.lastHeartBeat_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _status;
  String _name;
  String _uri;
  double _priority;
  int _nCPU;
  int _nThread;
  double _memory;
  int _nAvailableThread;
  double _availableMemory;
  final base.ListChangedBase<String> availableTaskTypes;
  final base.ListChangedBase<String> taskIds;
  String _lastDateActivity;
  int _heartBeat;
  String _lastHeartBeat;

  WorkerBase()
      : _status = "",
        _name = "",
        _uri = "",
        _priority = 0.0,
        _nCPU = 0,
        _nThread = 0,
        _memory = 0.0,
        _nAvailableThread = 0,
        _availableMemory = 0.0,
        availableTaskTypes = base.ListChangedBase<String>(),
        taskIds = base.ListChangedBase<String>(),
        _lastDateActivity = "",
        _heartBeat = 0,
        _lastHeartBeat = "" {
    availableTaskTypes.parent = this;
    taskIds.parent = this;
  }

  WorkerBase.json(Map m)
      : _status = base.defaultValue(
            m[Vocabulary.status_DP] as String?, base.String_DefaultFactory),
        _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _uri = base.defaultValue(
            m[Vocabulary.uri_DP] as String?, base.String_DefaultFactory),
        _priority = base.defaultDouble(m[Vocabulary.priority_DP] as num?),
        _nCPU = base.defaultValue(
            m[Vocabulary.nCPU_DP] as int?, base.int_DefaultFactory),
        _nThread = base.defaultValue(
            m[Vocabulary.nThread_DP] as int?, base.int_DefaultFactory),
        _memory = base.defaultDouble(m[Vocabulary.memory_DP] as num?),
        _nAvailableThread = base.defaultValue(
            m[Vocabulary.nAvailableThread_DP] as int?, base.int_DefaultFactory),
        _availableMemory =
            base.defaultDouble(m[Vocabulary.availableMemory_DP] as num?),
        availableTaskTypes = base.ListChangedBase<String>(
            m[Vocabulary.availableTaskTypes_DP] as List?),
        taskIds =
            base.ListChangedBase<String>(m[Vocabulary.taskIds_DP] as List?),
        _lastDateActivity = base.defaultValue(
            m[Vocabulary.lastDateActivity_DP] as String?,
            base.String_DefaultFactory),
        _heartBeat = base.defaultValue(
            m[Vocabulary.heartBeat_DP] as int?, base.int_DefaultFactory),
        _lastHeartBeat = base.defaultValue(
            m[Vocabulary.lastHeartBeat_DP] as String?,
            base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Worker_CLASS, m);
    availableTaskTypes.parent = this;
    taskIds.parent = this;
  }

  static Worker createFromJson(Map m) => WorkerBase.fromJson(m);
  static Worker fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Worker_CLASS:
        return Worker.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Worker_CLASS;
  String get status => _status;

  set status(String $o) {
    if ($o == _status) return;
    var $old = _status;
    _status = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.status_DP, $old, _status));
    }
  }

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

  String get uri => _uri;

  set uri(String $o) {
    if ($o == _uri) return;
    var $old = _uri;
    _uri = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.uri_DP, $old, _uri));
    }
  }

  double get priority => _priority;

  set priority(double $o) {
    if ($o == _priority) return;
    var $old = _priority;
    _priority = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.priority_DP, $old, _priority));
    }
  }

  int get nCPU => _nCPU;

  set nCPU(int $o) {
    if ($o == _nCPU) return;
    var $old = _nCPU;
    _nCPU = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nCPU_DP, $old, _nCPU));
    }
  }

  int get nThread => _nThread;

  set nThread(int $o) {
    if ($o == _nThread) return;
    var $old = _nThread;
    _nThread = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.nThread_DP, $old, _nThread));
    }
  }

  double get memory => _memory;

  set memory(double $o) {
    if ($o == _memory) return;
    var $old = _memory;
    _memory = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.memory_DP, $old, _memory));
    }
  }

  int get nAvailableThread => _nAvailableThread;

  set nAvailableThread(int $o) {
    if ($o == _nAvailableThread) return;
    var $old = _nAvailableThread;
    _nAvailableThread = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.nAvailableThread_DP, $old, _nAvailableThread));
    }
  }

  double get availableMemory => _availableMemory;

  set availableMemory(double $o) {
    if ($o == _availableMemory) return;
    var $old = _availableMemory;
    _availableMemory = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.availableMemory_DP, $old, _availableMemory));
    }
  }

  String get lastDateActivity => _lastDateActivity;

  set lastDateActivity(String $o) {
    if ($o == _lastDateActivity) return;
    var $old = _lastDateActivity;
    _lastDateActivity = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.lastDateActivity_DP, $old, _lastDateActivity));
    }
  }

  int get heartBeat => _heartBeat;

  set heartBeat(int $o) {
    if ($o == _heartBeat) return;
    var $old = _heartBeat;
    _heartBeat = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.heartBeat_DP, $old, _heartBeat));
    }
  }

  String get lastHeartBeat => _lastHeartBeat;

  set lastHeartBeat(String $o) {
    if ($o == _lastHeartBeat) return;
    var $old = _lastHeartBeat;
    _lastHeartBeat = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.lastHeartBeat_DP, $old, _lastHeartBeat));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.status_DP:
        return status;
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.uri_DP:
        return uri;
      case Vocabulary.priority_DP:
        return priority;
      case Vocabulary.nCPU_DP:
        return nCPU;
      case Vocabulary.nThread_DP:
        return nThread;
      case Vocabulary.memory_DP:
        return memory;
      case Vocabulary.nAvailableThread_DP:
        return nAvailableThread;
      case Vocabulary.availableMemory_DP:
        return availableMemory;
      case Vocabulary.availableTaskTypes_DP:
        return availableTaskTypes;
      case Vocabulary.taskIds_DP:
        return taskIds;
      case Vocabulary.lastDateActivity_DP:
        return lastDateActivity;
      case Vocabulary.heartBeat_DP:
        return heartBeat;
      case Vocabulary.lastHeartBeat_DP:
        return lastHeartBeat;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.status_DP:
        status = $value as String;
        return;
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.uri_DP:
        uri = $value as String;
        return;
      case Vocabulary.priority_DP:
        priority = $value as double;
        return;
      case Vocabulary.nCPU_DP:
        nCPU = $value as int;
        return;
      case Vocabulary.nThread_DP:
        nThread = $value as int;
        return;
      case Vocabulary.memory_DP:
        memory = $value as double;
        return;
      case Vocabulary.nAvailableThread_DP:
        nAvailableThread = $value as int;
        return;
      case Vocabulary.availableMemory_DP:
        availableMemory = $value as double;
        return;
      case Vocabulary.availableTaskTypes_DP:
        availableTaskTypes.setValues($value as Iterable<String>);
        return;
      case Vocabulary.taskIds_DP:
        taskIds.setValues($value as Iterable<String>);
        return;
      case Vocabulary.lastDateActivity_DP:
        lastDateActivity = $value as String;
        return;
      case Vocabulary.heartBeat_DP:
        heartBeat = $value as int;
        return;
      case Vocabulary.lastHeartBeat_DP:
        lastHeartBeat = $value as String;
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
  Worker copy() => Worker.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Worker_CLASS;
    if (subKind != null && subKind != Vocabulary.Worker_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.status_DP] = status;
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.uri_DP] = uri;
    m[Vocabulary.priority_DP] = priority;
    m[Vocabulary.nCPU_DP] = nCPU;
    m[Vocabulary.nThread_DP] = nThread;
    m[Vocabulary.memory_DP] = memory;
    m[Vocabulary.nAvailableThread_DP] = nAvailableThread;
    m[Vocabulary.availableMemory_DP] = availableMemory;
    m[Vocabulary.availableTaskTypes_DP] = availableTaskTypes;
    m[Vocabulary.taskIds_DP] = taskIds;
    m[Vocabulary.lastDateActivity_DP] = lastDateActivity;
    m[Vocabulary.heartBeat_DP] = heartBeat;
    m[Vocabulary.lastHeartBeat_DP] = lastHeartBeat;
    return m;
  }
}
