part of sci_model_base;

class RunWorkflowTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.workflowId_DP,
    Vocabulary.workflowRev_DP,
    Vocabulary.stepsToReset_DP,
    Vocabulary.stepsToRun_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _workflowId;
  String _workflowRev;
  final base.ListChangedBase<String> stepsToReset;
  final base.ListChangedBase<String> stepsToRun;

  RunWorkflowTaskBase()
      : _workflowId = "",
        _workflowRev = "",
        stepsToReset = base.ListChangedBase<String>(),
        stepsToRun = base.ListChangedBase<String>() {
    stepsToReset.parent = this;
    stepsToRun.parent = this;
  }

  RunWorkflowTaskBase.json(Map m)
      : _workflowId = base.defaultValue(
            m[Vocabulary.workflowId_DP] as String?, base.String_DefaultFactory),
        _workflowRev = base.defaultValue(
            m[Vocabulary.workflowRev_DP] as String?,
            base.String_DefaultFactory),
        stepsToReset = base.ListChangedBase<String>(
            m[Vocabulary.stepsToReset_DP] as List?),
        stepsToRun =
            base.ListChangedBase<String>(m[Vocabulary.stepsToRun_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RunWorkflowTask_CLASS, m);
    stepsToReset.parent = this;
    stepsToRun.parent = this;
  }

  static RunWorkflowTask createFromJson(Map m) =>
      RunWorkflowTaskBase.fromJson(m);
  static RunWorkflowTask _createFromJson(Map? m) =>
      m == null ? RunWorkflowTask() : RunWorkflowTaskBase.fromJson(m);
  static RunWorkflowTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RunWorkflowTask_CLASS:
        return RunWorkflowTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RunWorkflowTask_CLASS;
  String get workflowId => _workflowId;

  set workflowId(String $o) {
    if ($o == _workflowId) return;
    var $old = _workflowId;
    _workflowId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.workflowId_DP, $old, _workflowId));
    }
  }

  String get workflowRev => _workflowRev;

  set workflowRev(String $o) {
    if ($o == _workflowRev) return;
    var $old = _workflowRev;
    _workflowRev = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.workflowRev_DP, $old, _workflowRev));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.workflowId_DP:
        return workflowId;
      case Vocabulary.workflowRev_DP:
        return workflowRev;
      case Vocabulary.stepsToReset_DP:
        return stepsToReset;
      case Vocabulary.stepsToRun_DP:
        return stepsToRun;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.workflowId_DP:
        workflowId = $value as String;
        return;
      case Vocabulary.workflowRev_DP:
        workflowRev = $value as String;
        return;
      case Vocabulary.stepsToReset_DP:
        stepsToReset.setValues($value as Iterable<String>);
        return;
      case Vocabulary.stepsToRun_DP:
        stepsToRun.setValues($value as Iterable<String>);
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
  RunWorkflowTask copy() => RunWorkflowTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RunWorkflowTask_CLASS;
    if (subKind != null && subKind != Vocabulary.RunWorkflowTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.workflowId_DP] = workflowId;
    m[Vocabulary.workflowRev_DP] = workflowRev;
    m[Vocabulary.stepsToReset_DP] = stepsToReset;
    m[Vocabulary.stepsToRun_DP] = stepsToRun;
    return m;
  }
}
