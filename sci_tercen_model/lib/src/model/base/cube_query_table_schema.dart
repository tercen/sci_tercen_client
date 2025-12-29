part of sci_model_base;

class CubeQueryTableSchemaBase extends Schema {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.queryHash_DP,
    Vocabulary.queryTableType_DP,
    Vocabulary.query_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.query_OP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("CubeQuery", Vocabulary.query_OP, isComposite: false)
  ];
  String _queryHash;
  String _queryTableType;
  CubeQuery _query;

  CubeQueryTableSchemaBase()
      : _queryHash = "",
        _queryTableType = "",
        _query = CubeQuery() {
    _query.parent = this;
  }

  CubeQueryTableSchemaBase.json(Map m)
      : _queryHash = base.defaultValue(
            m[Vocabulary.queryHash_DP] as String?, base.String_DefaultFactory),
        _queryTableType = base.defaultValue(
            m[Vocabulary.queryTableType_DP] as String?,
            base.String_DefaultFactory),
        _query = (m[Vocabulary.query_OP] as Map?) == null
            ? CubeQuery()
            : CubeQueryBase.fromJson(m[Vocabulary.query_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CubeQueryTableSchema_CLASS, m);
    _query.parent = this;
  }

  static CubeQueryTableSchema createFromJson(Map m) =>
      CubeQueryTableSchemaBase.fromJson(m);
  static CubeQueryTableSchema fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CubeQueryTableSchema_CLASS:
        return CubeQueryTableSchema.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CubeQueryTableSchema_CLASS;
  String get queryHash => _queryHash;

  set queryHash(String $o) {
    if ($o == _queryHash) return;
    var $old = _queryHash;
    _queryHash = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.queryHash_DP, $old, _queryHash));
    }
  }

  String get queryTableType => _queryTableType;

  set queryTableType(String $o) {
    if ($o == _queryTableType) return;
    var $old = _queryTableType;
    _queryTableType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.queryTableType_DP, $old, _queryTableType));
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
      case Vocabulary.queryHash_DP:
        return queryHash;
      case Vocabulary.queryTableType_DP:
        return queryTableType;
      case Vocabulary.query_OP:
        return query;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.queryHash_DP:
        queryHash = $value as String;
        return;
      case Vocabulary.queryTableType_DP:
        queryTableType = $value as String;
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
  CubeQueryTableSchema copy() => CubeQueryTableSchema.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CubeQueryTableSchema_CLASS;
    if (subKind != null && subKind != Vocabulary.CubeQueryTableSchema_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.queryHash_DP] = queryHash;
    m[Vocabulary.queryTableType_DP] = queryTableType;
    m[Vocabulary.query_OP] = query.toJson();
    return m;
  }
}
