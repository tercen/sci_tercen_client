part of sci_model_base;

class UlimitsBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.core_file_size_DP,
    Vocabulary.data_seg_size_DP,
    Vocabulary.scheduling_priority_DP,
    Vocabulary.file_size_DP,
    Vocabulary.pending_signals_DP,
    Vocabulary.max_locked_memory_DP,
    Vocabulary.max_memory_size_DP,
    Vocabulary.open_files_DP,
    Vocabulary.pipe_size_DP,
    Vocabulary.message_queues_DP,
    Vocabulary.real_time_priority_DP,
    Vocabulary.stack_size_DP,
    Vocabulary.cpu_time_DP,
    Vocabulary.max_user_processes_DP,
    Vocabulary.virtual_memory_DP,
    Vocabulary.file_locks_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _core_file_size;
  int _data_seg_size;
  int _scheduling_priority;
  int _file_size;
  int _pending_signals;
  int _max_locked_memory;
  int _max_memory_size;
  int _open_files;
  int _pipe_size;
  int _message_queues;
  int _real_time_priority;
  int _stack_size;
  int _cpu_time;
  int _max_user_processes;
  int _virtual_memory;
  int _file_locks;

  UlimitsBase()
      : _core_file_size = 0,
        _data_seg_size = 0,
        _scheduling_priority = 0,
        _file_size = 0,
        _pending_signals = 0,
        _max_locked_memory = 0,
        _max_memory_size = 0,
        _open_files = 0,
        _pipe_size = 0,
        _message_queues = 0,
        _real_time_priority = 0,
        _stack_size = 0,
        _cpu_time = 0,
        _max_user_processes = 0,
        _virtual_memory = 0,
        _file_locks = 0;
  UlimitsBase.json(Map m)
      : _core_file_size = base.defaultValue(
            m[Vocabulary.core_file_size_DP] as int?, base.int_DefaultFactory),
        _data_seg_size = base.defaultValue(
            m[Vocabulary.data_seg_size_DP] as int?, base.int_DefaultFactory),
        _scheduling_priority = base.defaultValue(
            m[Vocabulary.scheduling_priority_DP] as int?,
            base.int_DefaultFactory),
        _file_size = base.defaultValue(
            m[Vocabulary.file_size_DP] as int?, base.int_DefaultFactory),
        _pending_signals = base.defaultValue(
            m[Vocabulary.pending_signals_DP] as int?, base.int_DefaultFactory),
        _max_locked_memory = base.defaultValue(
            m[Vocabulary.max_locked_memory_DP] as int?,
            base.int_DefaultFactory),
        _max_memory_size = base.defaultValue(
            m[Vocabulary.max_memory_size_DP] as int?, base.int_DefaultFactory),
        _open_files = base.defaultValue(
            m[Vocabulary.open_files_DP] as int?, base.int_DefaultFactory),
        _pipe_size = base.defaultValue(
            m[Vocabulary.pipe_size_DP] as int?, base.int_DefaultFactory),
        _message_queues = base.defaultValue(
            m[Vocabulary.message_queues_DP] as int?, base.int_DefaultFactory),
        _real_time_priority = base.defaultValue(
            m[Vocabulary.real_time_priority_DP] as int?,
            base.int_DefaultFactory),
        _stack_size = base.defaultValue(
            m[Vocabulary.stack_size_DP] as int?, base.int_DefaultFactory),
        _cpu_time = base.defaultValue(
            m[Vocabulary.cpu_time_DP] as int?, base.int_DefaultFactory),
        _max_user_processes = base.defaultValue(
            m[Vocabulary.max_user_processes_DP] as int?,
            base.int_DefaultFactory),
        _virtual_memory = base.defaultValue(
            m[Vocabulary.virtual_memory_DP] as int?, base.int_DefaultFactory),
        _file_locks = base.defaultValue(
            m[Vocabulary.file_locks_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Ulimits_CLASS, m);
  }

  static Ulimits createFromJson(Map m) => UlimitsBase.fromJson(m);
  static Ulimits _createFromJson(Map? m) =>
      m == null ? Ulimits() : UlimitsBase.fromJson(m);
  static Ulimits fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Ulimits_CLASS:
        return Ulimits.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Ulimits_CLASS;
  int get core_file_size => _core_file_size;

  set core_file_size(int $o) {
    if ($o == _core_file_size) return;
    var $old = _core_file_size;
    _core_file_size = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.core_file_size_DP, $old, _core_file_size));
    }
  }

  int get data_seg_size => _data_seg_size;

  set data_seg_size(int $o) {
    if ($o == _data_seg_size) return;
    var $old = _data_seg_size;
    _data_seg_size = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.data_seg_size_DP, $old, _data_seg_size));
    }
  }

  int get scheduling_priority => _scheduling_priority;

  set scheduling_priority(int $o) {
    if ($o == _scheduling_priority) return;
    var $old = _scheduling_priority;
    _scheduling_priority = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.scheduling_priority_DP, $old, _scheduling_priority));
    }
  }

  int get file_size => _file_size;

  set file_size(int $o) {
    if ($o == _file_size) return;
    var $old = _file_size;
    _file_size = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.file_size_DP, $old, _file_size));
    }
  }

  int get pending_signals => _pending_signals;

  set pending_signals(int $o) {
    if ($o == _pending_signals) return;
    var $old = _pending_signals;
    _pending_signals = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.pending_signals_DP, $old, _pending_signals));
    }
  }

  int get max_locked_memory => _max_locked_memory;

  set max_locked_memory(int $o) {
    if ($o == _max_locked_memory) return;
    var $old = _max_locked_memory;
    _max_locked_memory = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.max_locked_memory_DP, $old, _max_locked_memory));
    }
  }

  int get max_memory_size => _max_memory_size;

  set max_memory_size(int $o) {
    if ($o == _max_memory_size) return;
    var $old = _max_memory_size;
    _max_memory_size = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.max_memory_size_DP, $old, _max_memory_size));
    }
  }

  int get open_files => _open_files;

  set open_files(int $o) {
    if ($o == _open_files) return;
    var $old = _open_files;
    _open_files = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.open_files_DP, $old, _open_files));
    }
  }

  int get pipe_size => _pipe_size;

  set pipe_size(int $o) {
    if ($o == _pipe_size) return;
    var $old = _pipe_size;
    _pipe_size = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.pipe_size_DP, $old, _pipe_size));
    }
  }

  int get message_queues => _message_queues;

  set message_queues(int $o) {
    if ($o == _message_queues) return;
    var $old = _message_queues;
    _message_queues = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.message_queues_DP, $old, _message_queues));
    }
  }

  int get real_time_priority => _real_time_priority;

  set real_time_priority(int $o) {
    if ($o == _real_time_priority) return;
    var $old = _real_time_priority;
    _real_time_priority = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.real_time_priority_DP, $old, _real_time_priority));
    }
  }

  int get stack_size => _stack_size;

  set stack_size(int $o) {
    if ($o == _stack_size) return;
    var $old = _stack_size;
    _stack_size = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.stack_size_DP, $old, _stack_size));
    }
  }

  int get cpu_time => _cpu_time;

  set cpu_time(int $o) {
    if ($o == _cpu_time) return;
    var $old = _cpu_time;
    _cpu_time = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cpu_time_DP, $old, _cpu_time));
    }
  }

  int get max_user_processes => _max_user_processes;

  set max_user_processes(int $o) {
    if ($o == _max_user_processes) return;
    var $old = _max_user_processes;
    _max_user_processes = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.max_user_processes_DP, $old, _max_user_processes));
    }
  }

  int get virtual_memory => _virtual_memory;

  set virtual_memory(int $o) {
    if ($o == _virtual_memory) return;
    var $old = _virtual_memory;
    _virtual_memory = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.virtual_memory_DP, $old, _virtual_memory));
    }
  }

  int get file_locks => _file_locks;

  set file_locks(int $o) {
    if ($o == _file_locks) return;
    var $old = _file_locks;
    _file_locks = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.file_locks_DP, $old, _file_locks));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.core_file_size_DP:
        return core_file_size;
      case Vocabulary.data_seg_size_DP:
        return data_seg_size;
      case Vocabulary.scheduling_priority_DP:
        return scheduling_priority;
      case Vocabulary.file_size_DP:
        return file_size;
      case Vocabulary.pending_signals_DP:
        return pending_signals;
      case Vocabulary.max_locked_memory_DP:
        return max_locked_memory;
      case Vocabulary.max_memory_size_DP:
        return max_memory_size;
      case Vocabulary.open_files_DP:
        return open_files;
      case Vocabulary.pipe_size_DP:
        return pipe_size;
      case Vocabulary.message_queues_DP:
        return message_queues;
      case Vocabulary.real_time_priority_DP:
        return real_time_priority;
      case Vocabulary.stack_size_DP:
        return stack_size;
      case Vocabulary.cpu_time_DP:
        return cpu_time;
      case Vocabulary.max_user_processes_DP:
        return max_user_processes;
      case Vocabulary.virtual_memory_DP:
        return virtual_memory;
      case Vocabulary.file_locks_DP:
        return file_locks;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.core_file_size_DP:
        core_file_size = $value as int;
        return;
      case Vocabulary.data_seg_size_DP:
        data_seg_size = $value as int;
        return;
      case Vocabulary.scheduling_priority_DP:
        scheduling_priority = $value as int;
        return;
      case Vocabulary.file_size_DP:
        file_size = $value as int;
        return;
      case Vocabulary.pending_signals_DP:
        pending_signals = $value as int;
        return;
      case Vocabulary.max_locked_memory_DP:
        max_locked_memory = $value as int;
        return;
      case Vocabulary.max_memory_size_DP:
        max_memory_size = $value as int;
        return;
      case Vocabulary.open_files_DP:
        open_files = $value as int;
        return;
      case Vocabulary.pipe_size_DP:
        pipe_size = $value as int;
        return;
      case Vocabulary.message_queues_DP:
        message_queues = $value as int;
        return;
      case Vocabulary.real_time_priority_DP:
        real_time_priority = $value as int;
        return;
      case Vocabulary.stack_size_DP:
        stack_size = $value as int;
        return;
      case Vocabulary.cpu_time_DP:
        cpu_time = $value as int;
        return;
      case Vocabulary.max_user_processes_DP:
        max_user_processes = $value as int;
        return;
      case Vocabulary.virtual_memory_DP:
        virtual_memory = $value as int;
        return;
      case Vocabulary.file_locks_DP:
        file_locks = $value as int;
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

  Ulimits copy() => Ulimits.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Ulimits_CLASS;
    if (subKind != null && subKind != Vocabulary.Ulimits_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.core_file_size_DP] = core_file_size;
    m[Vocabulary.data_seg_size_DP] = data_seg_size;
    m[Vocabulary.scheduling_priority_DP] = scheduling_priority;
    m[Vocabulary.file_size_DP] = file_size;
    m[Vocabulary.pending_signals_DP] = pending_signals;
    m[Vocabulary.max_locked_memory_DP] = max_locked_memory;
    m[Vocabulary.max_memory_size_DP] = max_memory_size;
    m[Vocabulary.open_files_DP] = open_files;
    m[Vocabulary.pipe_size_DP] = pipe_size;
    m[Vocabulary.message_queues_DP] = message_queues;
    m[Vocabulary.real_time_priority_DP] = real_time_priority;
    m[Vocabulary.stack_size_DP] = stack_size;
    m[Vocabulary.cpu_time_DP] = cpu_time;
    m[Vocabulary.max_user_processes_DP] = max_user_processes;
    m[Vocabulary.virtual_memory_DP] = virtual_memory;
    m[Vocabulary.file_locks_DP] = file_locks;
    return m;
  }
}
