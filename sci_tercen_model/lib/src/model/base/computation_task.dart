part of sci_model_base;

class ComputationTaskBase extends CubeQueryTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.parentTaskId_DP,
    Vocabulary.fileResultId_DP,
    Vocabulary.computedRelation_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [
    Vocabulary.parentTaskId_DP,
    Vocabulary.fileResultId_DP,
    Vocabulary.computedRelation_OP
  ];
  static const List<base.RefId> REF_IDS = [
    base.RefId("CubeQueryTask", Vocabulary.parentTaskId_DP, isComposite: true),
    base.RefId("FileDocument", Vocabulary.fileResultId_DP, isComposite: true),
    base.RefId("Relation", Vocabulary.computedRelation_OP, isComposite: true)
  ];
  String _parentTaskId;
  String _fileResultId;
  Relation _computedRelation;

  ComputationTaskBase()
      : _parentTaskId = "",
        _fileResultId = "",
        _computedRelation = Relation() {
    _computedRelation.parent = this;
  }

  ComputationTaskBase.json(Map m)
      : _parentTaskId = base.defaultValue(
            m[Vocabulary.parentTaskId_DP] as String?,
            base.String_DefaultFactory),
        _fileResultId = base.defaultValue(
            m[Vocabulary.fileResultId_DP] as String?,
            base.String_DefaultFactory),
        _computedRelation = (m[Vocabulary.computedRelation_OP] as Map?) == null
            ? Relation()
            : RelationBase.fromJson(m[Vocabulary.computedRelation_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ComputationTask_CLASS, m);
    _computedRelation.parent = this;
  }

  static ComputationTask createFromJson(Map m) =>
      ComputationTaskBase.fromJson(m);
  static ComputationTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ComputationTask_CLASS:
        return ComputationTask.json(m);
      case Vocabulary.RunComputationTask_CLASS:
        return RunComputationTask.json(m);
      case Vocabulary.SaveComputationResultTask_CLASS:
        return SaveComputationResultTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ComputationTask_CLASS;
  String get parentTaskId => _parentTaskId;

  set parentTaskId(String $o) {
    if ($o == _parentTaskId) return;
    var $old = _parentTaskId;
    _parentTaskId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.parentTaskId_DP, $old, _parentTaskId));
    }
  }

  String get fileResultId => _fileResultId;

  set fileResultId(String $o) {
    if ($o == _fileResultId) return;
    var $old = _fileResultId;
    _fileResultId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.fileResultId_DP, $old, _fileResultId));
    }
  }

  Relation get computedRelation => _computedRelation;

  set computedRelation(Relation $o) {
    if ($o == _computedRelation) return;
    _computedRelation.parent = null;
    $o.parent = this;
    var $old = _computedRelation;
    _computedRelation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.computedRelation_OP, $old, _computedRelation));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.parentTaskId_DP:
        return parentTaskId;
      case Vocabulary.fileResultId_DP:
        return fileResultId;
      case Vocabulary.computedRelation_OP:
        return computedRelation;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.parentTaskId_DP:
        parentTaskId = $value as String;
        return;
      case Vocabulary.fileResultId_DP:
        fileResultId = $value as String;
        return;
      case Vocabulary.computedRelation_OP:
        computedRelation = $value as Relation;
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
  ComputationTask copy() => ComputationTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ComputationTask_CLASS;
    if (subKind != null && subKind != Vocabulary.ComputationTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.parentTaskId_DP] = parentTaskId;
    m[Vocabulary.fileResultId_DP] = fileResultId;
    m[Vocabulary.computedRelation_OP] = computedRelation.toJson();
    return m;
  }
}
