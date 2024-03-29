part of sci_model_base;

class CubeQueryTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.query_OP,
    Vocabulary.removeOnGC_DP,
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
  CubeQuery _query;
  bool _removeOnGC;
  final base.ListChangedBase<String> schemaIds;

  CubeQueryTaskBase()
      : _removeOnGC = true,
        schemaIds = base.ListChangedBase<String>(),
        _query = CubeQuery() {
    schemaIds.parent = this;
    _query.parent = this;
  }

  CubeQueryTaskBase.json(Map m)
      : _removeOnGC = base.defaultValue(
            m[Vocabulary.removeOnGC_DP] as bool?, base.bool_DefaultFactory),
        schemaIds =
            base.ListChangedBase<String>(m[Vocabulary.schemaIds_DP] as List?),
        _query = CubeQueryBase._createFromJson(m[Vocabulary.query_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CubeQueryTask_CLASS, m);
    schemaIds.parent = this;
    _query.parent = this;
  }

  static CubeQueryTask createFromJson(Map m) => CubeQueryTaskBase.fromJson(m);
  static CubeQueryTask _createFromJson(Map? m) =>
      m == null ? CubeQueryTask() : CubeQueryTaskBase.fromJson(m);
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
  bool get removeOnGC => _removeOnGC;

  set removeOnGC(bool $o) {
    if ($o == _removeOnGC) return;
    var $old = _removeOnGC;
    _removeOnGC = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.removeOnGC_DP, $old, _removeOnGC));
    }
  }

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
      case Vocabulary.removeOnGC_DP:
        return removeOnGC;
      case Vocabulary.schemaIds_DP:
        return schemaIds;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.removeOnGC_DP:
        removeOnGC = $value as bool;
        return;
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
    m[Vocabulary.removeOnGC_DP] = removeOnGC;
    m[Vocabulary.schemaIds_DP] = schemaIds;
    return m;
  }
}
