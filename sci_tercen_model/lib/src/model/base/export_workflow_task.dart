part of sci_model_base;

class ExportWorkflowTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.workflowId_DP,
    Vocabulary.fileId_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.fileId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("FileDocument", Vocabulary.fileId_DP, isComposite: true)
  ];
  String _workflowId;
  String _fileId;

  ExportWorkflowTaskBase()
      : _workflowId = "",
        _fileId = "";
  ExportWorkflowTaskBase.json(Map m)
      : _workflowId = base.defaultValue(
            m[Vocabulary.workflowId_DP] as String?, base.String_DefaultFactory),
        _fileId = base.defaultValue(
            m[Vocabulary.fileId_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ExportWorkflowTask_CLASS, m);
  }

  static ExportWorkflowTask createFromJson(Map m) =>
      ExportWorkflowTaskBase.fromJson(m);
  static ExportWorkflowTask _createFromJson(Map? m) =>
      m == null ? ExportWorkflowTask() : ExportWorkflowTaskBase.fromJson(m);
  static ExportWorkflowTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ExportWorkflowTask_CLASS:
        return ExportWorkflowTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ExportWorkflowTask_CLASS;
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

  String get fileId => _fileId;

  set fileId(String $o) {
    if ($o == _fileId) return;
    var $old = _fileId;
    _fileId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.fileId_DP, $old, _fileId));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.workflowId_DP:
        return workflowId;
      case Vocabulary.fileId_DP:
        return fileId;
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
      case Vocabulary.fileId_DP:
        fileId = $value as String;
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
  ExportWorkflowTask copy() => ExportWorkflowTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ExportWorkflowTask_CLASS;
    if (subKind != null && subKind != Vocabulary.ExportWorkflowTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.workflowId_DP] = workflowId;
    m[Vocabulary.fileId_DP] = fileId;
    return m;
  }
}
