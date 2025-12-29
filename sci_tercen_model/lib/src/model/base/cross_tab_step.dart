part of sci_model_base;

class CrossTabStepBase extends NamespaceStep {
  static const List<String> PROPERTY_NAMES = [Vocabulary.model_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Crosstab _model;

  CrossTabStepBase() : _model = Crosstab() {
    _model.parent = this;
  }

  CrossTabStepBase.json(Map m)
      : _model = (m[Vocabulary.model_OP] as Map?) == null
            ? Crosstab()
            : CrosstabBase.fromJson(m[Vocabulary.model_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CrossTabStep_CLASS, m);
    _model.parent = this;
  }

  static CrossTabStep createFromJson(Map m) => CrossTabStepBase.fromJson(m);
  static CrossTabStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CrossTabStep_CLASS:
        return CrossTabStep.json(m);
      case Vocabulary.DataStep_CLASS:
        return DataStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CrossTabStep_CLASS;
  Crosstab get model => _model;

  set model(Crosstab $o) {
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
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.model_OP:
        model = $value as Crosstab;
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
  CrossTabStep copy() => CrossTabStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CrossTabStep_CLASS;
    if (subKind != null && subKind != Vocabulary.CrossTabStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.model_OP] = model.toJson();
    return m;
  }
}
