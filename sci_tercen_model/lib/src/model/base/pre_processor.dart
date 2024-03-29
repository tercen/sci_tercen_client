part of sci_model_base;

class PreProcessorBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.type_DP,
    Vocabulary.operatorRef_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _type;
  OperatorRef _operatorRef;

  PreProcessorBase()
      : _type = "",
        _operatorRef = OperatorRef() {
    _operatorRef.parent = this;
  }

  PreProcessorBase.json(Map m)
      : _type = base.defaultValue(
            m[Vocabulary.type_DP] as String?, base.String_DefaultFactory),
        _operatorRef = OperatorRefBase._createFromJson(
            m[Vocabulary.operatorRef_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PreProcessor_CLASS, m);
    _operatorRef.parent = this;
  }

  static PreProcessor createFromJson(Map m) => PreProcessorBase.fromJson(m);
  static PreProcessor _createFromJson(Map? m) =>
      m == null ? PreProcessor() : PreProcessorBase.fromJson(m);
  static PreProcessor fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PreProcessor_CLASS:
        return PreProcessor.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PreProcessor_CLASS;
  String get type => _type;

  set type(String $o) {
    if ($o == _type) return;
    var $old = _type;
    _type = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.type_DP, $old, _type));
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

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.type_DP:
        return type;
      case Vocabulary.operatorRef_OP:
        return operatorRef;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.type_DP:
        type = $value as String;
        return;
      case Vocabulary.operatorRef_OP:
        operatorRef = $value as OperatorRef;
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
  PreProcessor copy() => PreProcessor.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PreProcessor_CLASS;
    if (subKind != null && subKind != Vocabulary.PreProcessor_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.type_DP] = type;
    m[Vocabulary.operatorRef_OP] = operatorRef.toJson();
    return m;
  }
}
