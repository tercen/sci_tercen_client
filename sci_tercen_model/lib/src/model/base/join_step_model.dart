part of sci_model_base;

class JoinStepModelBase extends StepModel {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.leftFactors_OP,
    Vocabulary.rightFactors_OP,
    Vocabulary.rightPrefix_DP,
    Vocabulary.joinType_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Factor> leftFactors;
  final base.ListChanged<Factor> rightFactors;
  String _rightPrefix;
  String _joinType;

  JoinStepModelBase()
      : _rightPrefix = "",
        _joinType = "",
        leftFactors = base.ListChanged<Factor>(),
        rightFactors = base.ListChanged<Factor>() {
    leftFactors.parent = this;
    rightFactors.parent = this;
  }

  JoinStepModelBase.json(Map m)
      : _rightPrefix = base.defaultValue(
            m[Vocabulary.rightPrefix_DP] as String?,
            base.String_DefaultFactory),
        _joinType = base.defaultValue(
            m[Vocabulary.joinType_DP] as String?, base.String_DefaultFactory),
        leftFactors = base.ListChanged<Factor>.from(
            m[Vocabulary.leftFactors_OP] as List?, FactorBase.createFromJson),
        rightFactors = base.ListChanged<Factor>.from(
            m[Vocabulary.rightFactors_OP] as List?, FactorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.JoinStepModel_CLASS, m);
    leftFactors.parent = this;
    rightFactors.parent = this;
  }

  static JoinStepModel createFromJson(Map m) => JoinStepModelBase.fromJson(m);
  static JoinStepModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.JoinStepModel_CLASS:
        return JoinStepModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.JoinStepModel_CLASS;
  String get rightPrefix => _rightPrefix;

  set rightPrefix(String $o) {
    if ($o == _rightPrefix) return;
    var $old = _rightPrefix;
    _rightPrefix = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.rightPrefix_DP, $old, _rightPrefix));
    }
  }

  String get joinType => _joinType;

  set joinType(String $o) {
    if ($o == _joinType) return;
    var $old = _joinType;
    _joinType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.joinType_DP, $old, _joinType));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.leftFactors_OP:
        return leftFactors;
      case Vocabulary.rightFactors_OP:
        return rightFactors;
      case Vocabulary.rightPrefix_DP:
        return rightPrefix;
      case Vocabulary.joinType_DP:
        return joinType;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.rightPrefix_DP:
        rightPrefix = $value as String;
        return;
      case Vocabulary.joinType_DP:
        joinType = $value as String;
        return;
      case Vocabulary.leftFactors_OP:
        leftFactors.setValues($value as Iterable<Factor>);
        return;
      case Vocabulary.rightFactors_OP:
        rightFactors.setValues($value as Iterable<Factor>);
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
  JoinStepModel copy() => JoinStepModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.JoinStepModel_CLASS;
    if (subKind != null && subKind != Vocabulary.JoinStepModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.leftFactors_OP] = leftFactors.toJson();
    m[Vocabulary.rightFactors_OP] = rightFactors.toJson();
    m[Vocabulary.rightPrefix_DP] = rightPrefix;
    m[Vocabulary.joinType_DP] = joinType;
    return m;
  }
}
