part of sci_model_base;

class InMemoryRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [Vocabulary.inMemoryTable_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Table _inMemoryTable;

  InMemoryRelationBase() : _inMemoryTable = Table() {
    _inMemoryTable.parent = this;
  }

  InMemoryRelationBase.json(Map m)
      : _inMemoryTable =
            TableBase._createFromJson(m[Vocabulary.inMemoryTable_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.InMemoryRelation_CLASS, m);
    _inMemoryTable.parent = this;
  }

  static InMemoryRelation createFromJson(Map m) =>
      InMemoryRelationBase.fromJson(m);
  static InMemoryRelation _createFromJson(Map? m) =>
      m == null ? InMemoryRelation() : InMemoryRelationBase.fromJson(m);
  static InMemoryRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.InMemoryRelation_CLASS:
        return InMemoryRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.InMemoryRelation_CLASS;
  Table get inMemoryTable => _inMemoryTable;

  set inMemoryTable(Table $o) {
    if ($o == _inMemoryTable) return;
    _inMemoryTable.parent = null;
    $o.parent = this;
    var $old = _inMemoryTable;
    _inMemoryTable = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.inMemoryTable_OP, $old, _inMemoryTable));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.inMemoryTable_OP:
        return inMemoryTable;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.inMemoryTable_OP:
        inMemoryTable = $value as Table;
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
  InMemoryRelation copy() => InMemoryRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.InMemoryRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.InMemoryRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.inMemoryTable_OP] = inMemoryTable.toJson();
    return m;
  }
}
