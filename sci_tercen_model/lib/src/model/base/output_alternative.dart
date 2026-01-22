part of sci_model_base;

class OutputAlternativeBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.condition_DP,
    Vocabulary.joinSpec_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _condition;
  OperatorJoinSpec _joinSpec;

  OutputAlternativeBase()
      : _condition = "",
        _joinSpec = OperatorJoinSpec() {
    _joinSpec.parent = this;
  }

  OutputAlternativeBase.json(Map m)
      : _condition = base.defaultValue(
            m[Vocabulary.condition_DP] as String?, base.String_DefaultFactory),
        _joinSpec = (m[Vocabulary.joinSpec_OP] as Map?) == null
            ? OperatorJoinSpec()
            : OperatorJoinSpecBase.fromJson(m[Vocabulary.joinSpec_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OutputAlternative_CLASS, m);
    _joinSpec.parent = this;
  }

  static OutputAlternative createFromJson(Map m) =>
      OutputAlternativeBase.fromJson(m);
  static OutputAlternative fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OutputAlternative_CLASS:
        return OutputAlternative.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OutputAlternative_CLASS;
  String get condition => _condition;

  set condition(String $o) {
    if ($o == _condition) return;
    var $old = _condition;
    _condition = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.condition_DP, $old, _condition));
    }
  }

  OperatorJoinSpec get joinSpec => _joinSpec;

  set joinSpec(OperatorJoinSpec $o) {
    if ($o == _joinSpec) return;
    _joinSpec.parent = null;
    $o.parent = this;
    var $old = _joinSpec;
    _joinSpec = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.joinSpec_OP, $old, _joinSpec));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.condition_DP:
        return condition;
      case Vocabulary.joinSpec_OP:
        return joinSpec;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.condition_DP:
        condition = $value as String;
        return;
      case Vocabulary.joinSpec_OP:
        joinSpec = $value as OperatorJoinSpec;
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

  OutputAlternative copy() => OutputAlternative.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OutputAlternative_CLASS;
    if (subKind != null && subKind != Vocabulary.OutputAlternative_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.condition_DP] = condition;
    m[Vocabulary.joinSpec_OP] = joinSpec.toJson();
    return m;
  }
}
