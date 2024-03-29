part of sci_model_base;

class ProjectDocumentBase extends Document {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.projectId_DP,
    Vocabulary.folderId_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [
    Vocabulary.projectId_DP,
    Vocabulary.folderId_DP
  ];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Project", Vocabulary.projectId_DP, isComposite: false),
    base.RefId("FolderDocument", Vocabulary.folderId_DP, isComposite: false)
  ];
  String _projectId;
  String _folderId;

  ProjectDocumentBase()
      : _projectId = "",
        _folderId = "";
  ProjectDocumentBase.json(Map m)
      : _projectId = base.defaultValue(
            m[Vocabulary.projectId_DP] as String?, base.String_DefaultFactory),
        _folderId = base.defaultValue(
            m[Vocabulary.folderId_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ProjectDocument_CLASS, m);
  }

  static ProjectDocument createFromJson(Map m) =>
      ProjectDocumentBase.fromJson(m);
  static ProjectDocument _createFromJson(Map? m) =>
      m == null ? ProjectDocument() : ProjectDocumentBase.fromJson(m);
  static ProjectDocument fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ProjectDocument_CLASS:
        return ProjectDocument.json(m);
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
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ProjectDocument_CLASS;
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

  String get folderId => _folderId;

  set folderId(String $o) {
    if ($o == _folderId) return;
    var $old = _folderId;
    _folderId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.folderId_DP, $old, _folderId));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.projectId_DP:
        return projectId;
      case Vocabulary.folderId_DP:
        return folderId;
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
      case Vocabulary.folderId_DP:
        folderId = $value as String;
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
  ProjectDocument copy() => ProjectDocument.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ProjectDocument_CLASS;
    if (subKind != null && subKind != Vocabulary.ProjectDocument_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.projectId_DP] = projectId;
    m[Vocabulary.folderId_DP] = folderId;
    return m;
  }
}
