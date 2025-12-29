part of sci_model_base;

class IdObjectBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.id_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _id;

  IdObjectBase() : _id = "";
  IdObjectBase.json(Map m)
      : _id = base.defaultValue(
            m[Vocabulary.id_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.IdObject_CLASS, m);
  }

  static IdObject createFromJson(Map m) => IdObjectBase.fromJson(m);
  static IdObject fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.IdObject_CLASS:
        return IdObject.json(m);
      case Vocabulary.TableRelation_CLASS:
        return TableRelation.json(m);
      case Vocabulary.WhereRelation_CLASS:
        return WhereRelation.json(m);
      case Vocabulary.DistinctRelation_CLASS:
        return DistinctRelation.json(m);
      case Vocabulary.SelectPairwiseRelation_CLASS:
        return SelectPairwiseRelation.json(m);
      case Vocabulary.ReferenceRelation_CLASS:
        return ReferenceRelation.json(m);
      case Vocabulary.InMemoryRelation_CLASS:
        return InMemoryRelation.json(m);
      case Vocabulary.PairwiseRelation_CLASS:
        return PairwiseRelation.json(m);
      case Vocabulary.RenameRelation_CLASS:
        return RenameRelation.json(m);
      case Vocabulary.UnionRelation_CLASS:
        return UnionRelation.json(m);
      case Vocabulary.RangeRelation_CLASS:
        return RangeRelation.json(m);
      case Vocabulary.SimpleRelation_CLASS:
        return SimpleRelation.json(m);
      case Vocabulary.GatherRelation_CLASS:
        return GatherRelation.json(m);
      case Vocabulary.CompositeRelation_CLASS:
        return CompositeRelation.json(m);
      case Vocabulary.GroupByRelation_CLASS:
        return GroupByRelation.json(m);
      case Vocabulary.DataStep_CLASS:
        return DataStep.json(m);
      case Vocabulary.MeltStep_CLASS:
        return MeltStep.json(m);
      case Vocabulary.JoinStep_CLASS:
        return JoinStep.json(m);
      case Vocabulary.WizardStep_CLASS:
        return WizardStep.json(m);
      case Vocabulary.CrossTabStep_CLASS:
        return CrossTabStep.json(m);
      case Vocabulary.GroupStep_CLASS:
        return GroupStep.json(m);
      case Vocabulary.InStep_CLASS:
        return InStep.json(m);
      case Vocabulary.OutStep_CLASS:
        return OutStep.json(m);
      case Vocabulary.TableStep_CLASS:
        return TableStep.json(m);
      case Vocabulary.NamespaceStep_CLASS:
        return NamespaceStep.json(m);
      case Vocabulary.RelationStep_CLASS:
        return RelationStep.json(m);
      case Vocabulary.ExportStep_CLASS:
        return ExportStep.json(m);
      case Vocabulary.ModelStep_CLASS:
        return ModelStep.json(m);
      case Vocabulary.ViewStep_CLASS:
        return ViewStep.json(m);
      case Vocabulary.InputPort_CLASS:
        return InputPort.json(m);
      case Vocabulary.OutputPort_CLASS:
        return OutputPort.json(m);
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
      case Vocabulary.Column_CLASS:
        return Column.json(m);
      case Vocabulary.StartProcess_CLASS:
        return StartProcess.json(m);
      case Vocabulary.Relation_CLASS:
        return Relation.json(m);
      case Vocabulary.Step_CLASS:
        return Step.json(m);
      case Vocabulary.Port_CLASS:
        return Port.json(m);
      case Vocabulary.PersistentObject_CLASS:
        return PersistentObject.json(m);
      case Vocabulary.Link_CLASS:
        return Link.json(m);
      case Vocabulary.ColumnSchema_CLASS:
        return ColumnSchema.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.IdObject_CLASS;
  String get id => _id;

  set id(String $o) {
    if ($o == _id) return;
    var $old = _id;
    _id = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.id_DP, $old, _id));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.id_DP:
        return id;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.id_DP:
        id = $value as String;
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
  IdObject copy() => IdObject.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.IdObject_CLASS;
    if (subKind != null && subKind != Vocabulary.IdObject_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.id_DP] = id;
    return m;
  }
}
