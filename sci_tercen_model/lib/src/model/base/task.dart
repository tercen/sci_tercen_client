part of sci_model_base;

class TaskBase extends PersistentObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.environment_OP,
    Vocabulary.state_OP,
    Vocabulary.createdDate_OP,
    Vocabulary.lastModifiedDate_OP,
    Vocabulary.runDate_OP,
    Vocabulary.completedDate_OP,
    Vocabulary.duration_DP,
    Vocabulary.aclContext_OP,
    Vocabulary.owner_DP,
    Vocabulary.taskHash_DP,
    Vocabulary.channelId_DP,
    Vocabulary.meta_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.owner_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("User", Vocabulary.owner_DP, isComposite: false)
  ];
  final base.ListChanged<Pair> environment;
  State _state;
  Date _createdDate;
  Date _lastModifiedDate;
  Date _runDate;
  Date _completedDate;
  double _duration;
  AclContext _aclContext;
  String _owner;
  String _taskHash;
  String _channelId;
  final base.ListChanged<Pair> meta;

  TaskBase()
      : _duration = 0.0,
        _owner = "",
        _taskHash = "",
        _channelId = "",
        environment = base.ListChanged<Pair>(),
        _state = State(),
        _createdDate = Date(),
        _lastModifiedDate = Date(),
        _runDate = Date(),
        _completedDate = Date(),
        _aclContext = AclContext(),
        meta = base.ListChanged<Pair>() {
    environment.parent = this;
    _state.parent = this;
    _createdDate.parent = this;
    _lastModifiedDate.parent = this;
    _runDate.parent = this;
    _completedDate.parent = this;
    _aclContext.parent = this;
    meta.parent = this;
  }

  TaskBase.json(Map m)
      : _duration = base.defaultDouble(m[Vocabulary.duration_DP] as num?),
        _owner = base.defaultValue(
            m[Vocabulary.owner_DP] as String?, base.String_DefaultFactory),
        _taskHash = base.defaultValue(
            m[Vocabulary.taskHash_DP] as String?, base.String_DefaultFactory),
        _channelId = base.defaultValue(
            m[Vocabulary.channelId_DP] as String?, base.String_DefaultFactory),
        environment = base.ListChanged<Pair>.from(
            m[Vocabulary.environment_OP] as List?, PairBase.createFromJson),
        _state = StateBase._createFromJson(m[Vocabulary.state_OP] as Map?),
        _createdDate =
            DateBase._createFromJson(m[Vocabulary.createdDate_OP] as Map?),
        _lastModifiedDate =
            DateBase._createFromJson(m[Vocabulary.lastModifiedDate_OP] as Map?),
        _runDate = DateBase._createFromJson(m[Vocabulary.runDate_OP] as Map?),
        _completedDate =
            DateBase._createFromJson(m[Vocabulary.completedDate_OP] as Map?),
        _aclContext =
            AclContextBase._createFromJson(m[Vocabulary.aclContext_OP] as Map?),
        meta = base.ListChanged<Pair>.from(
            m[Vocabulary.meta_OP] as List?, PairBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Task_CLASS, m);
    environment.parent = this;
    _state.parent = this;
    _createdDate.parent = this;
    _lastModifiedDate.parent = this;
    _runDate.parent = this;
    _completedDate.parent = this;
    _aclContext.parent = this;
    meta.parent = this;
  }

  static Task createFromJson(Map m) => TaskBase.fromJson(m);
  static Task _createFromJson(Map? m) =>
      m == null ? Task() : TaskBase.fromJson(m);
  static Task fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Task_CLASS:
        return Task.json(m);
      case Vocabulary.RunComputationTask_CLASS:
        return RunComputationTask.json(m);
      case Vocabulary.SaveComputationResultTask_CLASS:
        return SaveComputationResultTask.json(m);
      case Vocabulary.ComputationTask_CLASS:
        return ComputationTask.json(m);
      case Vocabulary.ImportGitWorkflowTask_CLASS:
        return ImportGitWorkflowTask.json(m);
      case Vocabulary.ExportWorkflowTask_CLASS:
        return ExportWorkflowTask.json(m);
      case Vocabulary.CSVTask_CLASS:
        return CSVTask.json(m);
      case Vocabulary.CubeQueryTask_CLASS:
        return CubeQueryTask.json(m);
      case Vocabulary.ImportWorkflowTask_CLASS:
        return ImportWorkflowTask.json(m);
      case Vocabulary.TestOperatorTask_CLASS:
        return TestOperatorTask.json(m);
      case Vocabulary.ImportGitDatasetTask_CLASS:
        return ImportGitDatasetTask.json(m);
      case Vocabulary.RunWorkflowTask_CLASS:
        return RunWorkflowTask.json(m);
      case Vocabulary.RunWebAppTask_CLASS:
        return RunWebAppTask.json(m);
      case Vocabulary.ExportTableTask_CLASS:
        return ExportTableTask.json(m);
      case Vocabulary.ProjectTask_CLASS:
        return ProjectTask.json(m);
      case Vocabulary.GlTask_CLASS:
        return GlTask.json(m);
      case Vocabulary.LibraryTask_CLASS:
        return LibraryTask.json(m);
      case Vocabulary.CreateGitOperatorTask_CLASS:
        return CreateGitOperatorTask.json(m);
      case Vocabulary.GitProjectTask_CLASS:
        return GitProjectTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Task_CLASS;
  double get duration => _duration;

  set duration(double $o) {
    if ($o == _duration) return;
    var $old = _duration;
    _duration = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.duration_DP, $old, _duration));
    }
  }

  String get owner => _owner;

  set owner(String $o) {
    if ($o == _owner) return;
    var $old = _owner;
    _owner = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.owner_DP, $old, _owner));
    }
  }

  String get taskHash => _taskHash;

  set taskHash(String $o) {
    if ($o == _taskHash) return;
    var $old = _taskHash;
    _taskHash = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.taskHash_DP, $old, _taskHash));
    }
  }

  String get channelId => _channelId;

  set channelId(String $o) {
    if ($o == _channelId) return;
    var $old = _channelId;
    _channelId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.channelId_DP, $old, _channelId));
    }
  }

  State get state => _state;

  set state(State $o) {
    if ($o == _state) return;
    _state.parent = null;
    $o.parent = this;
    var $old = _state;
    _state = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.state_OP, $old, _state));
    }
  }

  Date get createdDate => _createdDate;

  set createdDate(Date $o) {
    if ($o == _createdDate) return;
    _createdDate.parent = null;
    $o.parent = this;
    var $old = _createdDate;
    _createdDate = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.createdDate_OP, $old, _createdDate));
    }
  }

  Date get lastModifiedDate => _lastModifiedDate;

  set lastModifiedDate(Date $o) {
    if ($o == _lastModifiedDate) return;
    _lastModifiedDate.parent = null;
    $o.parent = this;
    var $old = _lastModifiedDate;
    _lastModifiedDate = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.lastModifiedDate_OP, $old, _lastModifiedDate));
    }
  }

  Date get runDate => _runDate;

  set runDate(Date $o) {
    if ($o == _runDate) return;
    _runDate.parent = null;
    $o.parent = this;
    var $old = _runDate;
    _runDate = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.runDate_OP, $old, _runDate));
    }
  }

  Date get completedDate => _completedDate;

  set completedDate(Date $o) {
    if ($o == _completedDate) return;
    _completedDate.parent = null;
    $o.parent = this;
    var $old = _completedDate;
    _completedDate = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.completedDate_OP, $old, _completedDate));
    }
  }

  AclContext get aclContext => _aclContext;

  set aclContext(AclContext $o) {
    if ($o == _aclContext) return;
    _aclContext.parent = null;
    $o.parent = this;
    var $old = _aclContext;
    _aclContext = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.aclContext_OP, $old, _aclContext));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.environment_OP:
        return environment;
      case Vocabulary.state_OP:
        return state;
      case Vocabulary.createdDate_OP:
        return createdDate;
      case Vocabulary.lastModifiedDate_OP:
        return lastModifiedDate;
      case Vocabulary.runDate_OP:
        return runDate;
      case Vocabulary.completedDate_OP:
        return completedDate;
      case Vocabulary.duration_DP:
        return duration;
      case Vocabulary.aclContext_OP:
        return aclContext;
      case Vocabulary.owner_DP:
        return owner;
      case Vocabulary.taskHash_DP:
        return taskHash;
      case Vocabulary.channelId_DP:
        return channelId;
      case Vocabulary.meta_OP:
        return meta;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.duration_DP:
        duration = $value as double;
        return;
      case Vocabulary.owner_DP:
        owner = $value as String;
        return;
      case Vocabulary.taskHash_DP:
        taskHash = $value as String;
        return;
      case Vocabulary.channelId_DP:
        channelId = $value as String;
        return;
      case Vocabulary.environment_OP:
        environment.setValues($value as Iterable<Pair>);
        return;
      case Vocabulary.state_OP:
        state = $value as State;
        return;
      case Vocabulary.createdDate_OP:
        createdDate = $value as Date;
        return;
      case Vocabulary.lastModifiedDate_OP:
        lastModifiedDate = $value as Date;
        return;
      case Vocabulary.runDate_OP:
        runDate = $value as Date;
        return;
      case Vocabulary.completedDate_OP:
        completedDate = $value as Date;
        return;
      case Vocabulary.aclContext_OP:
        aclContext = $value as AclContext;
        return;
      case Vocabulary.meta_OP:
        meta.setValues($value as Iterable<Pair>);
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
  Task copy() => Task.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Task_CLASS;
    if (subKind != null && subKind != Vocabulary.Task_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.environment_OP] = environment.toJson();
    m[Vocabulary.state_OP] = state.toJson();
    m[Vocabulary.createdDate_OP] = createdDate.toJson();
    m[Vocabulary.lastModifiedDate_OP] = lastModifiedDate.toJson();
    m[Vocabulary.runDate_OP] = runDate.toJson();
    m[Vocabulary.completedDate_OP] = completedDate.toJson();
    m[Vocabulary.duration_DP] = duration;
    m[Vocabulary.aclContext_OP] = aclContext.toJson();
    m[Vocabulary.owner_DP] = owner;
    m[Vocabulary.taskHash_DP] = taskHash;
    m[Vocabulary.channelId_DP] = channelId;
    m[Vocabulary.meta_OP] = meta.toJson();
    return m;
  }
}
