part of sci_model_base;

class AnnotationModelBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.factors_OP,
    Vocabulary.annotationFactors_OP,
    Vocabulary.relation_OP,
    Vocabulary.taskId_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.taskId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("CubeQueryTask", Vocabulary.taskId_DP, isComposite: true)
  ];
  final base.ListChanged<GraphicalFactor> factors;
  final base.ListChanged<GraphicalFactor> annotationFactors;
  Relation _relation;
  String _taskId;

  AnnotationModelBase()
      : _taskId = "",
        factors = base.ListChanged<GraphicalFactor>(),
        annotationFactors = base.ListChanged<GraphicalFactor>(),
        _relation = Relation() {
    factors.parent = this;
    annotationFactors.parent = this;
    _relation.parent = this;
  }

  AnnotationModelBase.json(Map m)
      : _taskId = base.defaultValue(
            m[Vocabulary.taskId_DP] as String?, base.String_DefaultFactory),
        factors = base.ListChanged<GraphicalFactor>.from(
            m[Vocabulary.factors_OP] as List?,
            GraphicalFactorBase.createFromJson),
        annotationFactors = base.ListChanged<GraphicalFactor>.from(
            m[Vocabulary.annotationFactors_OP] as List?,
            GraphicalFactorBase.createFromJson),
        _relation =
            RelationBase._createFromJson(m[Vocabulary.relation_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.AnnotationModel_CLASS, m);
    factors.parent = this;
    annotationFactors.parent = this;
    _relation.parent = this;
  }

  static AnnotationModel createFromJson(Map m) =>
      AnnotationModelBase.fromJson(m);
  static AnnotationModel _createFromJson(Map? m) =>
      m == null ? AnnotationModel() : AnnotationModelBase.fromJson(m);
  static AnnotationModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.AnnotationModel_CLASS:
        return AnnotationModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.AnnotationModel_CLASS;
  String get taskId => _taskId;

  set taskId(String $o) {
    if ($o == _taskId) return;
    var $old = _taskId;
    _taskId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.taskId_DP, $old, _taskId));
    }
  }

  Relation get relation => _relation;

  set relation(Relation $o) {
    if ($o == _relation) return;
    _relation.parent = null;
    $o.parent = this;
    var $old = _relation;
    _relation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.relation_OP, $old, _relation));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.factors_OP:
        return factors;
      case Vocabulary.annotationFactors_OP:
        return annotationFactors;
      case Vocabulary.relation_OP:
        return relation;
      case Vocabulary.taskId_DP:
        return taskId;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.taskId_DP:
        taskId = $value as String;
        return;
      case Vocabulary.factors_OP:
        factors.setValues($value as Iterable<GraphicalFactor>);
        return;
      case Vocabulary.annotationFactors_OP:
        annotationFactors.setValues($value as Iterable<GraphicalFactor>);
        return;
      case Vocabulary.relation_OP:
        relation = $value as Relation;
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
  AnnotationModel copy() => AnnotationModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.AnnotationModel_CLASS;
    if (subKind != null && subKind != Vocabulary.AnnotationModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.factors_OP] = factors.toJson();
    m[Vocabulary.annotationFactors_OP] = annotationFactors.toJson();
    m[Vocabulary.relation_OP] = relation.toJson();
    m[Vocabulary.taskId_DP] = taskId;
    return m;
  }
}
