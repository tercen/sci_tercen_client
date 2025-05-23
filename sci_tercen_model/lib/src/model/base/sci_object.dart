part of sci_model_base;

class SciObjectBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  SciObjectBase();
  SciObjectBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.SciObject_CLASS, m);
  }

  static SciObject createFromJson(Map m) => SciObjectBase.fromJson(m);
  static SciObject _createFromJson(Map? m) =>
      m == null ? SciObject() : SciObjectBase.fromJson(m);
  static SciObject fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.SciObject_CLASS:
        return SciObject.json(m);
      case Vocabulary.EnumeratedProperty_CLASS:
        return EnumeratedProperty.json(m);
      case Vocabulary.FactorsProperty_CLASS:
        return FactorsProperty.json(m);
      case Vocabulary.FormulaProperty_CLASS:
        return FormulaProperty.json(m);
      case Vocabulary.DoubleProperty_CLASS:
        return DoubleProperty.json(m);
      case Vocabulary.StringProperty_CLASS:
        return StringProperty.json(m);
      case Vocabulary.BooleanProperty_CLASS:
        return BooleanProperty.json(m);
      case Vocabulary.GateOperatorModel_CLASS:
        return GateOperatorModel.json(m);
      case Vocabulary.AnnotationOperatorModel_CLASS:
        return AnnotationOperatorModel.json(m);
      case Vocabulary.NamedFilter_CLASS:
        return NamedFilter.json(m);
      case Vocabulary.FilterExpr2d_CLASS:
        return FilterExpr2d.json(m);
      case Vocabulary.Filter_CLASS:
        return Filter.json(m);
      case Vocabulary.FilterExpr_CLASS:
        return FilterExpr.json(m);
      case Vocabulary.RunningState_CLASS:
        return RunningState.json(m);
      case Vocabulary.RunningDependentState_CLASS:
        return RunningDependentState.json(m);
      case Vocabulary.FailedState_CLASS:
        return FailedState.json(m);
      case Vocabulary.CanceledState_CLASS:
        return CanceledState.json(m);
      case Vocabulary.DoneState_CLASS:
        return DoneState.json(m);
      case Vocabulary.InitState_CLASS:
        return InitState.json(m);
      case Vocabulary.PendingState_CLASS:
        return PendingState.json(m);
      case Vocabulary.StorageProfile_CLASS:
        return StorageProfile.json(m);
      case Vocabulary.RunProfile_CLASS:
        return RunProfile.json(m);
      case Vocabulary.CpuTimeProfile_CLASS:
        return CpuTimeProfile.json(m);
      case Vocabulary.TableProfile_CLASS:
        return TableProfile.json(m);
      case Vocabulary.ApiCallProfile_CLASS:
        return ApiCallProfile.json(m);
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
      case Vocabulary.CSVFileMetadata_CLASS:
        return CSVFileMetadata.json(m);
      case Vocabulary.JetPalette_CLASS:
        return JetPalette.json(m);
      case Vocabulary.RampPalette_CLASS:
        return RampPalette.json(m);
      case Vocabulary.CategoryPalette_CLASS:
        return CategoryPalette.json(m);
      case Vocabulary.DoubleColorElement_CLASS:
        return DoubleColorElement.json(m);
      case Vocabulary.StringColorElement_CLASS:
        return StringColorElement.json(m);
      case Vocabulary.TableStepModel_CLASS:
        return TableStepModel.json(m);
      case Vocabulary.Crosstab_CLASS:
        return Crosstab.json(m);
      case Vocabulary.JoinStepModel_CLASS:
        return JoinStepModel.json(m);
      case Vocabulary.WizardStepModel_CLASS:
        return WizardStepModel.json(m);
      case Vocabulary.MeltStepModel_CLASS:
        return MeltStepModel.json(m);
      case Vocabulary.ExportModel_CLASS:
        return ExportModel.json(m);
      case Vocabulary.MappingFactor_CLASS:
        return MappingFactor.json(m);
      case Vocabulary.MetaFactor_CLASS:
        return MetaFactor.json(m);
      case Vocabulary.Attribute_CLASS:
        return Attribute.json(m);
      case Vocabulary.ChartLine_CLASS:
        return ChartLine.json(m);
      case Vocabulary.ChartPoint_CLASS:
        return ChartPoint.json(m);
      case Vocabulary.ChartHeatmap_CLASS:
        return ChartHeatmap.json(m);
      case Vocabulary.ChartBar_CLASS:
        return ChartBar.json(m);
      case Vocabulary.ChartSize_CLASS:
        return ChartSize.json(m);
      case Vocabulary.Rectangle_CLASS:
        return Rectangle.json(m);
      case Vocabulary.ResourceSummary_CLASS:
        return ResourceSummary.json(m);
      case Vocabulary.BillingInfo_CLASS:
        return BillingInfo.json(m);
      case Vocabulary.Property_CLASS:
        return Property.json(m);
      case Vocabulary.Version_CLASS:
        return Version.json(m);
      case Vocabulary.Filters_CLASS:
        return Filters.json(m);
      case Vocabulary.CubeQuery_CLASS:
        return CubeQuery.json(m);
      case Vocabulary.UserSession_CLASS:
        return UserSession.json(m);
      case Vocabulary.Table_CLASS:
        return Table.json(m);
      case Vocabulary.Acl_CLASS:
        return Acl.json(m);
      case Vocabulary.GateNode_CLASS:
        return GateNode.json(m);
      case Vocabulary.TaskSummary_CLASS:
        return TaskSummary.json(m);
      case Vocabulary.Token_CLASS:
        return Token.json(m);
      case Vocabulary.JoinOperator_CLASS:
        return JoinOperator.json(m);
      case Vocabulary.OperatorModel_CLASS:
        return OperatorModel.json(m);
      case Vocabulary.CrosstabTable_CLASS:
        return CrosstabTable.json(m);
      case Vocabulary.XYAxisList_CLASS:
        return XYAxisList.json(m);
      case Vocabulary.FilterTopExpr_CLASS:
        return FilterTopExpr.json(m);
      case Vocabulary.State_CLASS:
        return State.json(m);
      case Vocabulary.PatchRecord_CLASS:
        return PatchRecord.json(m);
      case Vocabulary.ColumnSchemaMetaData_CLASS:
        return ColumnSchemaMetaData.json(m);
      case Vocabulary.Privilege_CLASS:
        return Privilege.json(m);
      case Vocabulary.ViesInfo_CLASS:
        return ViesInfo.json(m);
      case Vocabulary.RDescription_CLASS:
        return RDescription.json(m);
      case Vocabulary.Profile_CLASS:
        return Profile.json(m);
      case Vocabulary.Date_CLASS:
        return Date.json(m);
      case Vocabulary.StepState_CLASS:
        return StepState.json(m);
      case Vocabulary.OperatorResult_CLASS:
        return OperatorResult.json(m);
      case Vocabulary.Address_CLASS:
        return Address.json(m);
      case Vocabulary.XYAxis_CLASS:
        return XYAxis.json(m);
      case Vocabulary.IdObject_CLASS:
        return IdObject.json(m);
      case Vocabulary.Principal_CLASS:
        return Principal.json(m);
      case Vocabulary.Url_CLASS:
        return Url.json(m);
      case Vocabulary.RProxy_CLASS:
        return RProxy.json(m);
      case Vocabulary.Pair_CLASS:
        return Pair.json(m);
      case Vocabulary.FileMetadata_CLASS:
        return FileMetadata.json(m);
      case Vocabulary.Worker_CLASS:
        return Worker.json(m);
      case Vocabulary.Ace_CLASS:
        return Ace.json(m);
      case Vocabulary.Labels_CLASS:
        return Labels.json(m);
      case Vocabulary.OperatorSettings_CLASS:
        return OperatorSettings.json(m);
      case Vocabulary.TableSummary_CLASS:
        return TableSummary.json(m);
      case Vocabulary.Point_CLASS:
        return Point.json(m);
      case Vocabulary.Summary_CLASS:
        return Summary.json(m);
      case Vocabulary.Errors_CLASS:
        return Errors.json(m);
      case Vocabulary.Palette_CLASS:
        return Palette.json(m);
      case Vocabulary.GraphicalFactor_CLASS:
        return GraphicalFactor.json(m);
      case Vocabulary.ColorList_CLASS:
        return ColorList.json(m);
      case Vocabulary.SearchResult_CLASS:
        return SearchResult.json(m);
      case Vocabulary.AnnotationModel_CLASS:
        return AnnotationModel.json(m);
      case Vocabulary.ColorElement_CLASS:
        return ColorElement.json(m);
      case Vocabulary.PreProcessor_CLASS:
        return PreProcessor.json(m);
      case Vocabulary.FileSummary_CLASS:
        return FileSummary.json(m);
      case Vocabulary.Properties_CLASS:
        return Properties.json(m);
      case Vocabulary.PropertyValue_CLASS:
        return PropertyValue.json(m);
      case Vocabulary.AclContext_CLASS:
        return AclContext.json(m);
      case Vocabulary.OperatorUnitTest_CLASS:
        return OperatorUnitTest.json(m);
      case Vocabulary.StepModel_CLASS:
        return StepModel.json(m);
      case Vocabulary.Profiles_CLASS:
        return Profiles.json(m);
      case Vocabulary.OperatorRef_CLASS:
        return OperatorRef.json(m);
      case Vocabulary.Factor_CLASS:
        return Factor.json(m);
      case Vocabulary.ColumnPair_CLASS:
        return ColumnPair.json(m);
      case Vocabulary.TaxId_CLASS:
        return TaxId.json(m);
      case Vocabulary.Plan_CLASS:
        return Plan.json(m);
      case Vocabulary.CSVParserParam_CLASS:
        return CSVParserParam.json(m);
      case Vocabulary.AppDesign_CLASS:
        return AppDesign.json(m);
      case Vocabulary.Axis_CLASS:
        return Axis.json(m);
      case Vocabulary.Colors_CLASS:
        return Colors.json(m);
      case Vocabulary.TableProperties_CLASS:
        return TableProperties.json(m);
      case Vocabulary.Chart_CLASS:
        return Chart.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.SciObject_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  SciObject copy() => SciObject.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.SciObject_CLASS;
    if (subKind != null && subKind != Vocabulary.SciObject_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
