part of sci_model_base;

class OperatorResultBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.tables_OP,
    Vocabulary.joinOperators_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Table> tables;
  final base.ListChanged<JoinOperator> joinOperators;

  OperatorResultBase()
      : tables = base.ListChanged<Table>(),
        joinOperators = base.ListChanged<JoinOperator>() {
    tables.parent = this;
    joinOperators.parent = this;
  }

  OperatorResultBase.json(Map m)
      : tables = base.ListChanged<Table>.from(
            m[Vocabulary.tables_OP] as List?, TableBase.createFromJson),
        joinOperators = base.ListChanged<JoinOperator>.from(
            m[Vocabulary.joinOperators_OP] as List?,
            JoinOperatorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorResult_CLASS, m);
    tables.parent = this;
    joinOperators.parent = this;
  }

  static OperatorResult createFromJson(Map m) => OperatorResultBase.fromJson(m);
  static OperatorResult _createFromJson(Map? m) =>
      m == null ? OperatorResult() : OperatorResultBase.fromJson(m);
  static OperatorResult fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorResult_CLASS:
        return OperatorResult.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorResult_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.tables_OP:
        return tables;
      case Vocabulary.joinOperators_OP:
        return joinOperators;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.tables_OP:
        tables.setValues($value as Iterable<Table>);
        return;
      case Vocabulary.joinOperators_OP:
        joinOperators.setValues($value as Iterable<JoinOperator>);
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
  OperatorResult copy() => OperatorResult.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorResult_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorResult_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.tables_OP] = tables.toJson();
    m[Vocabulary.joinOperators_OP] = joinOperators.toJson();
    return m;
  }
}
