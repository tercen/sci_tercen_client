part of sci_model_base;

class ImportWorkflowTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.fileId_DP,
    Vocabulary.workflowId_DP,
    Vocabulary.gitToken_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.fileId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("FileDocument", Vocabulary.fileId_DP, isComposite: true)
  ];
  String _fileId;
  String _workflowId;
  String _gitToken;

  ImportWorkflowTaskBase()
      : _fileId = "",
        _workflowId = "",
        _gitToken = "";
  ImportWorkflowTaskBase.json(Map m)
      : _fileId = base.defaultValue(
            m[Vocabulary.fileId_DP] as String?, base.String_DefaultFactory),
        _workflowId = base.defaultValue(
            m[Vocabulary.workflowId_DP] as String?, base.String_DefaultFactory),
        _gitToken = base.defaultValue(
            m[Vocabulary.gitToken_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ImportWorkflowTask_CLASS, m);
  }

  static ImportWorkflowTask createFromJson(Map m) =>
      ImportWorkflowTaskBase.fromJson(m);
  static ImportWorkflowTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ImportWorkflowTask_CLASS:
        return ImportWorkflowTask.json(m);
      case Vocabulary.ImportGitWorkflowTask_CLASS:
        return ImportGitWorkflowTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ImportWorkflowTask_CLASS;
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

  String get gitToken => _gitToken;

  set gitToken(String $o) {
    if ($o == _gitToken) return;
    var $old = _gitToken;
    _gitToken = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.gitToken_DP, $old, _gitToken));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.fileId_DP:
        return fileId;
      case Vocabulary.workflowId_DP:
        return workflowId;
      case Vocabulary.gitToken_DP:
        return gitToken;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.fileId_DP:
        fileId = $value as String;
        return;
      case Vocabulary.workflowId_DP:
        workflowId = $value as String;
        return;
      case Vocabulary.gitToken_DP:
        gitToken = $value as String;
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
  ImportWorkflowTask copy() => ImportWorkflowTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ImportWorkflowTask_CLASS;
    if (subKind != null && subKind != Vocabulary.ImportWorkflowTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.fileId_DP] = fileId;
    m[Vocabulary.workflowId_DP] = workflowId;
    m[Vocabulary.gitToken_DP] = gitToken;
    return m;
  }
}
