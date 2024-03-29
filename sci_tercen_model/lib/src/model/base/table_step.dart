part of sci_model_base;

class TableStepBase extends RelationStep {
  static const List<String> PROPERTY_NAMES = [Vocabulary.model_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  TableStepModel _model;

  TableStepBase() : _model = TableStepModel() {
    _model.parent = this;
  }

  TableStepBase.json(Map m)
      : _model =
            TableStepModelBase._createFromJson(m[Vocabulary.model_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TableStep_CLASS, m);
    _model.parent = this;
  }

  static TableStep createFromJson(Map m) => TableStepBase.fromJson(m);
  static TableStep _createFromJson(Map? m) =>
      m == null ? TableStep() : TableStepBase.fromJson(m);
  static TableStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TableStep_CLASS:
        return TableStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TableStep_CLASS;
  TableStepModel get model => _model;

  set model(TableStepModel $o) {
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
        model = $value as TableStepModel;
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
  TableStep copy() => TableStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TableStep_CLASS;
    if (subKind != null && subKind != Vocabulary.TableStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.model_OP] = model.toJson();
    return m;
  }
}
