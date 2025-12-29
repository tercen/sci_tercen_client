part of sci_model_base;

class MeltStepBase extends NamespaceStep {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.model_OP,
    Vocabulary.meltedAttributes_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  MeltStepModel _model;
  final base.ListChanged<Attribute> meltedAttributes;

  MeltStepBase()
      : _model = MeltStepModel(),
        meltedAttributes = base.ListChanged<Attribute>() {
    _model.parent = this;
    meltedAttributes.parent = this;
  }

  MeltStepBase.json(Map m)
      : _model = (m[Vocabulary.model_OP] as Map?) == null
            ? MeltStepModel()
            : MeltStepModelBase.fromJson(m[Vocabulary.model_OP] as Map),
        meltedAttributes = base.ListChanged<Attribute>.from(
            m[Vocabulary.meltedAttributes_OP] as List?,
            AttributeBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.MeltStep_CLASS, m);
    _model.parent = this;
    meltedAttributes.parent = this;
  }

  static MeltStep createFromJson(Map m) => MeltStepBase.fromJson(m);
  static MeltStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.MeltStep_CLASS:
        return MeltStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.MeltStep_CLASS;
  MeltStepModel get model => _model;

  set model(MeltStepModel $o) {
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
      case Vocabulary.meltedAttributes_OP:
        return meltedAttributes;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.model_OP:
        model = $value as MeltStepModel;
        return;
      case Vocabulary.meltedAttributes_OP:
        meltedAttributes.setValues($value as Iterable<Attribute>);
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
  MeltStep copy() => MeltStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.MeltStep_CLASS;
    if (subKind != null && subKind != Vocabulary.MeltStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.model_OP] = model.toJson();
    m[Vocabulary.meltedAttributes_OP] = meltedAttributes.toJson();
    return m;
  }
}
