part of sci_model_base;

class OperatorJoinSpecBase extends OperatorOutputSpec {
  static const List<String> PROPERTY_NAMES = [Vocabulary.joinOperators_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<JoinOperator> joinOperators;

  OperatorJoinSpecBase() : joinOperators = base.ListChanged<JoinOperator>() {
    joinOperators.parent = this;
  }

  OperatorJoinSpecBase.json(Map m)
      : joinOperators = base.ListChanged<JoinOperator>.from(
            m[Vocabulary.joinOperators_OP] as List?,
            JoinOperatorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorJoinSpec_CLASS, m);
    joinOperators.parent = this;
  }

  static OperatorJoinSpec createFromJson(Map m) =>
      OperatorJoinSpecBase.fromJson(m);
  static OperatorJoinSpec fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorJoinSpec_CLASS:
        return OperatorJoinSpec.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorJoinSpec_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.joinOperators_OP:
        return joinOperators;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
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
  OperatorJoinSpec copy() => OperatorJoinSpec.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorJoinSpec_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorJoinSpec_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.joinOperators_OP] = joinOperators.toJson();
    return m;
  }
}
