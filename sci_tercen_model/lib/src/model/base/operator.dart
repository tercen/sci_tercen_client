part of sci_model_base;

class OperatorBase extends Document {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.properties_OP,
    Vocabulary.operatorSpec_OP,
    Vocabulary.capabilities_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Property> properties;
  OperatorSpec _operatorSpec;
  final base.ListChangedBase<String> capabilities;

  OperatorBase()
      : capabilities = base.ListChangedBase<String>(),
        properties = base.ListChanged<Property>(),
        _operatorSpec = OperatorSpec() {
    capabilities.parent = this;
    properties.parent = this;
    _operatorSpec.parent = this;
  }

  OperatorBase.json(Map m)
      : capabilities = base.ListChangedBase<String>(
            m[Vocabulary.capabilities_DP] as List?),
        properties = base.ListChanged<Property>.from(
            m[Vocabulary.properties_OP] as List?, PropertyBase.createFromJson),
        _operatorSpec = OperatorSpecBase._createFromJson(
            m[Vocabulary.operatorSpec_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Operator_CLASS, m);
    capabilities.parent = this;
    properties.parent = this;
    _operatorSpec.parent = this;
  }

  static Operator createFromJson(Map m) => OperatorBase.fromJson(m);
  static Operator _createFromJson(Map? m) =>
      m == null ? Operator() : OperatorBase.fromJson(m);
  static Operator fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Operator_CLASS:
        return Operator.json(m);
      case Vocabulary.ShinyOperator_CLASS:
        return ShinyOperator.json(m);
      case Vocabulary.DockerWebAppOperator_CLASS:
        return DockerWebAppOperator.json(m);
      case Vocabulary.DockerOperator_CLASS:
        return DockerOperator.json(m);
      case Vocabulary.ROperator_CLASS:
        return ROperator.json(m);
      case Vocabulary.WebAppOperator_CLASS:
        return WebAppOperator.json(m);
      case Vocabulary.GitOperator_CLASS:
        return GitOperator.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Operator_CLASS;
  OperatorSpec get operatorSpec => _operatorSpec;

  set operatorSpec(OperatorSpec $o) {
    if ($o == _operatorSpec) return;
    _operatorSpec.parent = null;
    $o.parent = this;
    var $old = _operatorSpec;
    _operatorSpec = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.operatorSpec_OP, $old, _operatorSpec));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.properties_OP:
        return properties;
      case Vocabulary.operatorSpec_OP:
        return operatorSpec;
      case Vocabulary.capabilities_DP:
        return capabilities;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.capabilities_DP:
        capabilities.setValues($value as Iterable<String>);
        return;
      case Vocabulary.properties_OP:
        properties.setValues($value as Iterable<Property>);
        return;
      case Vocabulary.operatorSpec_OP:
        operatorSpec = $value as OperatorSpec;
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
  Operator copy() => Operator.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Operator_CLASS;
    if (subKind != null && subKind != Vocabulary.Operator_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.properties_OP] = properties.toJson();
    m[Vocabulary.operatorSpec_OP] = operatorSpec.toJson();
    m[Vocabulary.capabilities_DP] = capabilities;
    return m;
  }
}
