part of sci_model_base;

class ComputedTableSchemaBase extends Schema {
  static const List<String> PROPERTY_NAMES = [Vocabulary.query_OP];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.query_OP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("CubeQuery", Vocabulary.query_OP, isComposite: false)
  ];
  CubeQuery _query;

  ComputedTableSchemaBase() : _query = CubeQuery() {
    _query.parent = this;
  }

  ComputedTableSchemaBase.json(Map m)
      : _query = CubeQueryBase._createFromJson(m[Vocabulary.query_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ComputedTableSchema_CLASS, m);
    _query.parent = this;
  }

  static ComputedTableSchema createFromJson(Map m) =>
      ComputedTableSchemaBase.fromJson(m);
  static ComputedTableSchema _createFromJson(Map? m) =>
      m == null ? ComputedTableSchema() : ComputedTableSchemaBase.fromJson(m);
  static ComputedTableSchema fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ComputedTableSchema_CLASS:
        return ComputedTableSchema.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ComputedTableSchema_CLASS;
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
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
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
  ComputedTableSchema copy() => ComputedTableSchema.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ComputedTableSchema_CLASS;
    if (subKind != null && subKind != Vocabulary.ComputedTableSchema_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.query_OP] = query.toJson();
    return m;
  }
}
