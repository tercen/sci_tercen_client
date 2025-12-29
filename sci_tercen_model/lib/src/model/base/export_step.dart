part of sci_model_base;

class ExportStepBase extends ModelStep {
  static const List<String> PROPERTY_NAMES = [Vocabulary.model_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  ExportModel _model;

  ExportStepBase() : _model = ExportModel() {
    _model.parent = this;
  }

  ExportStepBase.json(Map m)
      : _model = (m[Vocabulary.model_OP] as Map?) == null
            ? ExportModel()
            : ExportModelBase.fromJson(m[Vocabulary.model_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ExportStep_CLASS, m);
    _model.parent = this;
  }

  static ExportStep createFromJson(Map m) => ExportStepBase.fromJson(m);
  static ExportStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ExportStep_CLASS:
        return ExportStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ExportStep_CLASS;
  ExportModel get model => _model;

  set model(ExportModel $o) {
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
        model = $value as ExportModel;
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
  ExportStep copy() => ExportStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ExportStep_CLASS;
    if (subKind != null && subKind != Vocabulary.ExportStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.model_OP] = model.toJson();
    return m;
  }
}
