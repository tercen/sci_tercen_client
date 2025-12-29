part of sci_model_base;

class TestOperatorTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.operatorId_DP,
    Vocabulary.testRequired_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.operatorId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Operator", Vocabulary.operatorId_DP, isComposite: false)
  ];
  String _operatorId;
  bool _testRequired;

  TestOperatorTaskBase()
      : _operatorId = "",
        _testRequired = true;
  TestOperatorTaskBase.json(Map m)
      : _operatorId = base.defaultValue(
            m[Vocabulary.operatorId_DP] as String?, base.String_DefaultFactory),
        _testRequired = base.defaultValue(
            m[Vocabulary.testRequired_DP] as bool?, base.bool_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TestOperatorTask_CLASS, m);
  }

  static TestOperatorTask createFromJson(Map m) =>
      TestOperatorTaskBase.fromJson(m);
  static TestOperatorTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TestOperatorTask_CLASS:
        return TestOperatorTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TestOperatorTask_CLASS;
  String get operatorId => _operatorId;

  set operatorId(String $o) {
    if ($o == _operatorId) return;
    var $old = _operatorId;
    _operatorId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.operatorId_DP, $old, _operatorId));
    }
  }

  bool get testRequired => _testRequired;

  set testRequired(bool $o) {
    if ($o == _testRequired) return;
    var $old = _testRequired;
    _testRequired = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.testRequired_DP, $old, _testRequired));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.operatorId_DP:
        return operatorId;
      case Vocabulary.testRequired_DP:
        return testRequired;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.operatorId_DP:
        operatorId = $value as String;
        return;
      case Vocabulary.testRequired_DP:
        testRequired = $value as bool;
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
  TestOperatorTask copy() => TestOperatorTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TestOperatorTask_CLASS;
    if (subKind != null && subKind != Vocabulary.TestOperatorTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.operatorId_DP] = operatorId;
    m[Vocabulary.testRequired_DP] = testRequired;
    return m;
  }
}
