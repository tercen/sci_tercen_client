part of sci_model_base;

class OperatorSpecBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.ontologyUri_DP,
    Vocabulary.ontologyVersion_DP,
    Vocabulary.inputSpecs_OP,
    Vocabulary.outputSpecs_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _ontologyUri;
  String _ontologyVersion;
  final base.ListChanged<OperatorInputSpec> inputSpecs;
  final base.ListChanged<OperatorOutputSpec> outputSpecs;

  OperatorSpecBase()
      : _ontologyUri = "",
        _ontologyVersion = "",
        inputSpecs = base.ListChanged<OperatorInputSpec>(),
        outputSpecs = base.ListChanged<OperatorOutputSpec>() {
    inputSpecs.parent = this;
    outputSpecs.parent = this;
  }

  OperatorSpecBase.json(Map m)
      : _ontologyUri = base.defaultValue(
            m[Vocabulary.ontologyUri_DP] as String?,
            base.String_DefaultFactory),
        _ontologyVersion = base.defaultValue(
            m[Vocabulary.ontologyVersion_DP] as String?,
            base.String_DefaultFactory),
        inputSpecs = base.ListChanged<OperatorInputSpec>.from(
            m[Vocabulary.inputSpecs_OP] as List?,
            OperatorInputSpecBase.createFromJson),
        outputSpecs = base.ListChanged<OperatorOutputSpec>.from(
            m[Vocabulary.outputSpecs_OP] as List?,
            OperatorOutputSpecBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorSpec_CLASS, m);
    inputSpecs.parent = this;
    outputSpecs.parent = this;
  }

  static OperatorSpec createFromJson(Map m) => OperatorSpecBase.fromJson(m);
  static OperatorSpec fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorSpec_CLASS:
        return OperatorSpec.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorSpec_CLASS;
  String get ontologyUri => _ontologyUri;

  set ontologyUri(String $o) {
    if ($o == _ontologyUri) return;
    var $old = _ontologyUri;
    _ontologyUri = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.ontologyUri_DP, $old, _ontologyUri));
    }
  }

  String get ontologyVersion => _ontologyVersion;

  set ontologyVersion(String $o) {
    if ($o == _ontologyVersion) return;
    var $old = _ontologyVersion;
    _ontologyVersion = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.ontologyVersion_DP, $old, _ontologyVersion));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.ontologyUri_DP:
        return ontologyUri;
      case Vocabulary.ontologyVersion_DP:
        return ontologyVersion;
      case Vocabulary.inputSpecs_OP:
        return inputSpecs;
      case Vocabulary.outputSpecs_OP:
        return outputSpecs;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.ontologyUri_DP:
        ontologyUri = $value as String;
        return;
      case Vocabulary.ontologyVersion_DP:
        ontologyVersion = $value as String;
        return;
      case Vocabulary.inputSpecs_OP:
        inputSpecs.setValues($value as Iterable<OperatorInputSpec>);
        return;
      case Vocabulary.outputSpecs_OP:
        outputSpecs.setValues($value as Iterable<OperatorOutputSpec>);
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

  OperatorSpec copy() => OperatorSpec.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorSpec_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorSpec_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.ontologyUri_DP] = ontologyUri;
    m[Vocabulary.ontologyVersion_DP] = ontologyVersion;
    m[Vocabulary.inputSpecs_OP] = inputSpecs.toJson();
    m[Vocabulary.outputSpecs_OP] = outputSpecs.toJson();
    return m;
  }
}
