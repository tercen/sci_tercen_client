part of sci_model_base;

class CubeQueryTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.query_OP,
    Vocabulary.schemaIds_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [
    Vocabulary.query_OP,
    Vocabulary.schemaIds_DP
  ];
  static const List<base.RefId> REF_IDS = [
    base.RefId("CubeQuery", Vocabulary.query_OP, isComposite: false),
    base.RefId("CubeQueryTableSchema", Vocabulary.schemaIds_DP,
        isComposite: true)
  ];
  static const List<base.PropertyConstraint> CONSTRAINTS = [];
  CubeQuery _query;
  final base.ListChangedBase<String> schemaIds;

  CubeQueryTaskBase()
      : schemaIds = base.ListChangedBase<String>(),
        _query = CubeQuery() {
    schemaIds.parent = this;
    _query.parent = this;
  }

  CubeQueryTaskBase.json(Map m)
      : schemaIds =
            base.ListChangedBase<String>(m[Vocabulary.schemaIds_DP] as List?),
        _query = (m[Vocabulary.query_OP] as Map?) == null
            ? CubeQuery()
            : CubeQueryBase.fromJson(m[Vocabulary.query_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CubeQueryTask_CLASS, m);
    schemaIds.parent = this;
    _query.parent = this;
  }

  static CubeQueryTask createFromJson(Map m) => CubeQueryTaskBase.fromJson(m);
  static CubeQueryTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CubeQueryTask_CLASS:
        return CubeQueryTask.json(m);
      case Vocabulary.RunComputationTask_CLASS:
        return RunComputationTask.json(m);
      case Vocabulary.SaveComputationResultTask_CLASS:
        return SaveComputationResultTask.json(m);
      case Vocabulary.ComputationTask_CLASS:
        return ComputationTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CubeQueryTask_CLASS;
  CubeQuery get query => _query;

  set query(CubeQuery $o) {
    if ($o == _query) return;
    _query.parent = null;
    $o.parent = this;
    var $old = _query;
    _query = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.query_OP, $old, _query));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.query_OP:
        return query;
      case Vocabulary.schemaIds_DP:
        return schemaIds;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.schemaIds_DP:
        schemaIds.setValues($value as Iterable<String>);
        return;
      case Vocabulary.query_OP:
        query = $value as CubeQuery;
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
  Iterable<base.PropertyConstraint> constraints() =>
      super.constraints().followedBy(CONSTRAINTS);

  @override
  CubeQueryTask copy() => CubeQueryTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CubeQueryTask_CLASS;
    if (subKind != null && subKind != Vocabulary.CubeQueryTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.query_OP] = query.toJson();
    m[Vocabulary.schemaIds_DP] = schemaIds;
    return m;
  }
}
