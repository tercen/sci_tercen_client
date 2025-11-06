part of sci_model_base;

class PersistentObjectBase extends IdObject implements base.PersistentBase {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.isDeleted_DP,
    Vocabulary.rev_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  bool _isDeleted;
  String _rev;

  PersistentObjectBase()
      : _isDeleted = true,
        _rev = "";
  PersistentObjectBase.json(Map m)
      : _isDeleted = base.defaultValue(
            m[Vocabulary.isDeleted_DP] as bool?, base.bool_DefaultFactory),
        _rev = base.defaultValue(
            m[Vocabulary.rev_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PersistentObject_CLASS, m);
  }

  static PersistentObject createFromJson(Map m) =>
      PersistentObjectBase.fromJson(m);
  static PersistentObject _createFromJson(Map? m) =>
      m == null ? PersistentObject() : PersistentObjectBase.fromJson(m);
  static PersistentObject fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PersistentObject_CLASS:
        return PersistentObject.json(m);
      case Vocabulary.GarbageTasks_CLASS:
        return GarbageTasks.json(m);
      case Vocabulary.GarbageTasks2_CLASS:
        return GarbageTasks2.json(m);
      case Vocabulary.Team_CLASS:
        return Team.json(m);
      case Vocabulary.RSourceLibrary_CLASS:
        return RSourceLibrary.json(m);
      case Vocabulary.RenvInstalledLibrary_CLASS:
        return RenvInstalledLibrary.json(m);
      case Vocabulary.ShinyOperator_CLASS:
        return ShinyOperator.json(m);
      case Vocabulary.DockerWebAppOperator_CLASS:
        return DockerWebAppOperator.json(m);
      case Vocabulary.DockerOperator_CLASS:
        return DockerOperator.json(m);
      case Vocabulary.ROperator_CLASS:
        return ROperator.json(m);
      case Vocabulary.WebAppOperator_CLASS:
        return WebAppOperator.json(m);
      case Vocabulary.GitOperator_CLASS:
        return GitOperator.json(m);
      case Vocabulary.CubeQueryTableSchema_CLASS:
        return CubeQueryTableSchema.json(m);
      case Vocabulary.TableSchema_CLASS:
        return TableSchema.json(m);
      case Vocabulary.ComputedTableSchema_CLASS:
        return ComputedTableSchema.json(m);
      case Vocabulary.FileDocument_CLASS:
        return FileDocument.json(m);
      case Vocabulary.FolderDocument_CLASS:
        return FolderDocument.json(m);
      case Vocabulary.Schema_CLASS:
        return Schema.json(m);
      case Vocabulary.Workflow_CLASS:
        return Workflow.json(m);
      case Vocabulary.User_CLASS:
        return User.json(m);
      case Vocabulary.RLibrary_CLASS:
        return RLibrary.json(m);
      case Vocabulary.Operator_CLASS:
        return Operator.json(m);
      case Vocabulary.WorkerEndpoint_CLASS:
        return WorkerEndpoint.json(m);
      case Vocabulary.ProjectDocument_CLASS:
        return ProjectDocument.json(m);
      case Vocabulary.Project_CLASS:
        return Project.json(m);
      case Vocabulary.SubscriptionPlan_CLASS:
        return SubscriptionPlan.json(m);
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
      case Vocabulary.TaskLogEvent_CLASS:
        return TaskLogEvent.json(m);
      case Vocabulary.TaskProgressEvent_CLASS:
        return TaskProgressEvent.json(m);
      case Vocabulary.TaskDataEvent_CLASS:
        return TaskDataEvent.json(m);
      case Vocabulary.TaskStateEvent_CLASS:
        return TaskStateEvent.json(m);
      case Vocabulary.PatchRecords_CLASS:
        return PatchRecords.json(m);
      case Vocabulary.TaskEvent_CLASS:
        return TaskEvent.json(m);
      case Vocabulary.GenericEvent_CLASS:
        return GenericEvent.json(m);
      case Vocabulary.PersistentChannelEvent_CLASS:
        return PersistentChannelEvent.json(m);
      case Vocabulary.GarbageObject_CLASS:
        return GarbageObject.json(m);
      case Vocabulary.Activity_CLASS:
        return Activity.json(m);
      case Vocabulary.Document_CLASS:
        return Document.json(m);
      case Vocabulary.Lock_CLASS:
        return Lock.json(m);
      case Vocabulary.Task_CLASS:
        return Task.json(m);
      case Vocabulary.Event_CLASS:
        return Event.json(m);
      case Vocabulary.UserSecret_CLASS:
        return UserSecret.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PersistentObject_CLASS;
  bool get isDeleted => _isDeleted;

  set isDeleted(bool $o) {
    if ($o == _isDeleted) return;
    var $old = _isDeleted;
    _isDeleted = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isDeleted_DP, $old, _isDeleted));
    }
  }

  String get rev => _rev;

  set rev(String $o) {
    if ($o == _rev) return;
    var $old = _rev;
    _rev = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.rev_DP, $old, _rev));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.isDeleted_DP:
        return isDeleted;
      case Vocabulary.rev_DP:
        return rev;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.isDeleted_DP:
        isDeleted = $value as bool;
        return;
      case Vocabulary.rev_DP:
        rev = $value as String;
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
  PersistentObject copy() => PersistentObject.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PersistentObject_CLASS;
    if (subKind != null && subKind != Vocabulary.PersistentObject_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.isDeleted_DP] = isDeleted;
    m[Vocabulary.rev_DP] = rev;
    return m;
  }
}
