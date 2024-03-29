part of sci_model_base;

class OperatorSettingsBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.namespace_DP,
    Vocabulary.operatorRef_OP,
    Vocabulary.environment_OP,
    Vocabulary.operatorModel_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _namespace;
  OperatorRef _operatorRef;
  final base.ListChanged<Pair> environment;
  OperatorModel _operatorModel;

  OperatorSettingsBase()
      : _namespace = "",
        _operatorRef = OperatorRef(),
        environment = base.ListChanged<Pair>(),
        _operatorModel = OperatorModel() {
    _operatorRef.parent = this;
    environment.parent = this;
    _operatorModel.parent = this;
  }

  OperatorSettingsBase.json(Map m)
      : _namespace = base.defaultValue(
            m[Vocabulary.namespace_DP] as String?, base.String_DefaultFactory),
        _operatorRef = OperatorRefBase._createFromJson(
            m[Vocabulary.operatorRef_OP] as Map?),
        environment = base.ListChanged<Pair>.from(
            m[Vocabulary.environment_OP] as List?, PairBase.createFromJson),
        _operatorModel = OperatorModelBase._createFromJson(
            m[Vocabulary.operatorModel_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorSettings_CLASS, m);
    _operatorRef.parent = this;
    environment.parent = this;
    _operatorModel.parent = this;
  }

  static OperatorSettings createFromJson(Map m) =>
      OperatorSettingsBase.fromJson(m);
  static OperatorSettings _createFromJson(Map? m) =>
      m == null ? OperatorSettings() : OperatorSettingsBase.fromJson(m);
  static OperatorSettings fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorSettings_CLASS:
        return OperatorSettings.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorSettings_CLASS;
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

  OperatorRef get operatorRef => _operatorRef;

  set operatorRef(OperatorRef $o) {
    if ($o == _operatorRef) return;
    _operatorRef.parent = null;
    $o.parent = this;
    var $old = _operatorRef;
    _operatorRef = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.operatorRef_OP, $old, _operatorRef));
    }
  }

  OperatorModel get operatorModel => _operatorModel;

  set operatorModel(OperatorModel $o) {
    if ($o == _operatorModel) return;
    _operatorModel.parent = null;
    $o.parent = this;
    var $old = _operatorModel;
    _operatorModel = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.operatorModel_OP, $old, _operatorModel));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.namespace_DP:
        return namespace;
      case Vocabulary.operatorRef_OP:
        return operatorRef;
      case Vocabulary.environment_OP:
        return environment;
      case Vocabulary.operatorModel_OP:
        return operatorModel;
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
      case Vocabulary.operatorRef_OP:
        operatorRef = $value as OperatorRef;
        return;
      case Vocabulary.environment_OP:
        environment.setValues($value as Iterable<Pair>);
        return;
      case Vocabulary.operatorModel_OP:
        operatorModel = $value as OperatorModel;
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
  OperatorSettings copy() => OperatorSettings.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorSettings_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorSettings_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.namespace_DP] = namespace;
    m[Vocabulary.operatorRef_OP] = operatorRef.toJson();
    m[Vocabulary.environment_OP] = environment.toJson();
    m[Vocabulary.operatorModel_OP] = operatorModel.toJson();
    return m;
  }
}
