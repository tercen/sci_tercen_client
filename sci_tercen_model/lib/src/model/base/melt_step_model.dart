part of sci_model_base;

class MeltStepModelBase extends StepModel {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.factors_OP,
    Vocabulary.namespace_DP,
    Vocabulary.selectionPattern_DP,
    Vocabulary.factorType_DP,
    Vocabulary.gatherType_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Factor> factors;
  String _namespace;
  String _selectionPattern;
  String _factorType;
  String _gatherType;

  MeltStepModelBase()
      : _namespace = "",
        _selectionPattern = "",
        _factorType = "",
        _gatherType = "",
        factors = base.ListChanged<Factor>() {
    factors.parent = this;
  }

  MeltStepModelBase.json(Map m)
      : _namespace = base.defaultValue(
            m[Vocabulary.namespace_DP] as String?, base.String_DefaultFactory),
        _selectionPattern = base.defaultValue(
            m[Vocabulary.selectionPattern_DP] as String?,
            base.String_DefaultFactory),
        _factorType = base.defaultValue(
            m[Vocabulary.factorType_DP] as String?, base.String_DefaultFactory),
        _gatherType = base.defaultValue(
            m[Vocabulary.gatherType_DP] as String?, base.String_DefaultFactory),
        factors = base.ListChanged<Factor>.from(
            m[Vocabulary.factors_OP] as List?, FactorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.MeltStepModel_CLASS, m);
    factors.parent = this;
  }

  static MeltStepModel createFromJson(Map m) => MeltStepModelBase.fromJson(m);
  static MeltStepModel _createFromJson(Map? m) =>
      m == null ? MeltStepModel() : MeltStepModelBase.fromJson(m);
  static MeltStepModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.MeltStepModel_CLASS:
        return MeltStepModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.MeltStepModel_CLASS;
  String get namespace => _namespace;

  set namespace(String $o) {
    if ($o == _namespace) return;
    var $old = _namespace;
    _namespace = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.namespace_DP, $old, _namespace));
    }
  }

  String get selectionPattern => _selectionPattern;

  set selectionPattern(String $o) {
    if ($o == _selectionPattern) return;
    var $old = _selectionPattern;
    _selectionPattern = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.selectionPattern_DP, $old, _selectionPattern));
    }
  }

  String get factorType => _factorType;

  set factorType(String $o) {
    if ($o == _factorType) return;
    var $old = _factorType;
    _factorType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.factorType_DP, $old, _factorType));
    }
  }

  String get gatherType => _gatherType;

  set gatherType(String $o) {
    if ($o == _gatherType) return;
    var $old = _gatherType;
    _gatherType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.gatherType_DP, $old, _gatherType));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.factors_OP:
        return factors;
      case Vocabulary.namespace_DP:
        return namespace;
      case Vocabulary.selectionPattern_DP:
        return selectionPattern;
      case Vocabulary.factorType_DP:
        return factorType;
      case Vocabulary.gatherType_DP:
        return gatherType;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.namespace_DP:
        namespace = $value as String;
        return;
      case Vocabulary.selectionPattern_DP:
        selectionPattern = $value as String;
        return;
      case Vocabulary.factorType_DP:
        factorType = $value as String;
        return;
      case Vocabulary.gatherType_DP:
        gatherType = $value as String;
        return;
      case Vocabulary.factors_OP:
        factors.setValues($value as Iterable<Factor>);
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
  MeltStepModel copy() => MeltStepModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.MeltStepModel_CLASS;
    if (subKind != null && subKind != Vocabulary.MeltStepModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.factors_OP] = factors.toJson();
    m[Vocabulary.namespace_DP] = namespace;
    m[Vocabulary.selectionPattern_DP] = selectionPattern;
    m[Vocabulary.factorType_DP] = factorType;
    m[Vocabulary.gatherType_DP] = gatherType;
    return m;
  }
}
