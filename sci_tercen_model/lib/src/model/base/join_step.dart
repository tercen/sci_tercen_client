part of sci_model_base;

class JoinStepBase extends NamespaceStep {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.model_OP,
    Vocabulary.rightAttributes_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  JoinStepModel _model;
  final base.ListChanged<Attribute> rightAttributes;

  JoinStepBase()
      : _model = JoinStepModel(),
        rightAttributes = base.ListChanged<Attribute>() {
    _model.parent = this;
    rightAttributes.parent = this;
  }

  JoinStepBase.json(Map m)
      : _model =
            JoinStepModelBase._createFromJson(m[Vocabulary.model_OP] as Map?),
        rightAttributes = base.ListChanged<Attribute>.from(
            m[Vocabulary.rightAttributes_OP] as List?,
            AttributeBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.JoinStep_CLASS, m);
    _model.parent = this;
    rightAttributes.parent = this;
  }

  static JoinStep createFromJson(Map m) => JoinStepBase.fromJson(m);
  static JoinStep _createFromJson(Map? m) =>
      m == null ? JoinStep() : JoinStepBase.fromJson(m);
  static JoinStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.JoinStep_CLASS:
        return JoinStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.JoinStep_CLASS;
  JoinStepModel get model => _model;

  set model(JoinStepModel $o) {
    if ($o == _model) return;
    _model.parent = null;
    $o.parent = this;
    var $old = _model;
    _model = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.model_OP, $old, _model));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.model_OP:
        return model;
      case Vocabulary.rightAttributes_OP:
        return rightAttributes;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.model_OP:
        model = $value as JoinStepModel;
        return;
      case Vocabulary.rightAttributes_OP:
        rightAttributes.setValues($value as Iterable<Attribute>);
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
  JoinStep copy() => JoinStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.JoinStep_CLASS;
    if (subKind != null && subKind != Vocabulary.JoinStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.model_OP] = model.toJson();
    m[Vocabulary.rightAttributes_OP] = rightAttributes.toJson();
    return m;
  }
}
