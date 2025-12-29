part of sci_model_base;

class ProjectTaskBase extends Task {
  static const List<String> PROPERTY_NAMES = [Vocabulary.projectId_DP];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.projectId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Project", Vocabulary.projectId_DP, isComposite: false)
  ];
  String _projectId;

  ProjectTaskBase() : _projectId = "";
  ProjectTaskBase.json(Map m)
      : _projectId = base.defaultValue(
            m[Vocabulary.projectId_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ProjectTask_CLASS, m);
  }

  static ProjectTask createFromJson(Map m) => ProjectTaskBase.fromJson(m);
  static ProjectTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ProjectTask_CLASS:
        return ProjectTask.json(m);
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
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ProjectTask_CLASS;
  String get projectId => _projectId;

  set projectId(String $o) {
    if ($o == _projectId) return;
    var $old = _projectId;
    _projectId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.projectId_DP, $old, _projectId));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.projectId_DP:
        return projectId;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.projectId_DP:
        projectId = $value as String;
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
  ProjectTask copy() => ProjectTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ProjectTask_CLASS;
    if (subKind != null && subKind != Vocabulary.ProjectTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.projectId_DP] = projectId;
    return m;
  }
}
