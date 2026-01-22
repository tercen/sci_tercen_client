part of sci_model_base;

class OperatorBase extends Document {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.properties_OP,
    Vocabulary.operatorSpec_OP,
    Vocabulary.capabilities_DP,
    Vocabulary.memoryModel_OP,
    Vocabulary.runtimeModel_OP,
    Vocabulary.communicationProtocol_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Property> properties;
  OperatorSpec _operatorSpec;
  final base.ListChangedBase<String> capabilities;
  OperatorEstimateModel _memoryModel;
  OperatorEstimateModel _runtimeModel;
  String _communicationProtocol;

  OperatorBase()
      : capabilities = base.ListChangedBase<String>(),
        _communicationProtocol = "",
        properties = base.ListChanged<Property>(),
        _operatorSpec = OperatorSpec(),
        _memoryModel = OperatorEstimateModel(),
        _runtimeModel = OperatorEstimateModel() {
    capabilities.parent = this;
    properties.parent = this;
    _operatorSpec.parent = this;
    _memoryModel.parent = this;
    _runtimeModel.parent = this;
  }

  OperatorBase.json(Map m)
      : capabilities = base.ListChangedBase<String>(
            m[Vocabulary.capabilities_DP] as List?),
        _communicationProtocol = base.defaultValue(
            m[Vocabulary.communicationProtocol_DP] as String?,
            base.String_DefaultFactory),
        properties = base.ListChanged<Property>.from(
            m[Vocabulary.properties_OP] as List?, PropertyBase.createFromJson),
        _operatorSpec = (m[Vocabulary.operatorSpec_OP] as Map?) == null
            ? OperatorSpec()
            : OperatorSpecBase.fromJson(m[Vocabulary.operatorSpec_OP] as Map),
        _memoryModel = (m[Vocabulary.memoryModel_OP] as Map?) == null
            ? OperatorEstimateModel()
            : OperatorEstimateModelBase.fromJson(
                m[Vocabulary.memoryModel_OP] as Map),
        _runtimeModel = (m[Vocabulary.runtimeModel_OP] as Map?) == null
            ? OperatorEstimateModel()
            : OperatorEstimateModelBase.fromJson(
                m[Vocabulary.runtimeModel_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Operator_CLASS, m);
    capabilities.parent = this;
    properties.parent = this;
    _operatorSpec.parent = this;
    _memoryModel.parent = this;
    _runtimeModel.parent = this;
  }

  static Operator createFromJson(Map m) => OperatorBase.fromJson(m);
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
  String get communicationProtocol => _communicationProtocol;

  set communicationProtocol(String $o) {
    if ($o == _communicationProtocol) return;
    var $old = _communicationProtocol;
    _communicationProtocol = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(this,
          Vocabulary.communicationProtocol_DP, $old, _communicationProtocol));
    }
  }

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

  OperatorEstimateModel get memoryModel => _memoryModel;

  set memoryModel(OperatorEstimateModel $o) {
    if ($o == _memoryModel) return;
    _memoryModel.parent = null;
    $o.parent = this;
    var $old = _memoryModel;
    _memoryModel = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.memoryModel_OP, $old, _memoryModel));
    }
  }

  OperatorEstimateModel get runtimeModel => _runtimeModel;

  set runtimeModel(OperatorEstimateModel $o) {
    if ($o == _runtimeModel) return;
    _runtimeModel.parent = null;
    $o.parent = this;
    var $old = _runtimeModel;
    _runtimeModel = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.runtimeModel_OP, $old, _runtimeModel));
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
      case Vocabulary.memoryModel_OP:
        return memoryModel;
      case Vocabulary.runtimeModel_OP:
        return runtimeModel;
      case Vocabulary.communicationProtocol_DP:
        return communicationProtocol;
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
      case Vocabulary.communicationProtocol_DP:
        communicationProtocol = $value as String;
        return;
      case Vocabulary.properties_OP:
        properties.setValues($value as Iterable<Property>);
        return;
      case Vocabulary.operatorSpec_OP:
        operatorSpec = $value as OperatorSpec;
        return;
      case Vocabulary.memoryModel_OP:
        memoryModel = $value as OperatorEstimateModel;
        return;
      case Vocabulary.runtimeModel_OP:
        runtimeModel = $value as OperatorEstimateModel;
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
    m[Vocabulary.memoryModel_OP] = memoryModel.toJson();
    m[Vocabulary.runtimeModel_OP] = runtimeModel.toJson();
    m[Vocabulary.communicationProtocol_DP] = communicationProtocol;
    return m;
  }
}
