part of sci_model_base;

class TableStepModelBase extends StepModel {
  static const List<String> PROPERTY_NAMES = [Vocabulary.relation_OP];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.relation_OP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Relation", Vocabulary.relation_OP, isComposite: false)
  ];
  Relation _relation;

  TableStepModelBase() : _relation = Relation() {
    _relation.parent = this;
  }

  TableStepModelBase.json(Map m)
      : _relation =
            RelationBase._createFromJson(m[Vocabulary.relation_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TableStepModel_CLASS, m);
    _relation.parent = this;
  }

  static TableStepModel createFromJson(Map m) => TableStepModelBase.fromJson(m);
  static TableStepModel _createFromJson(Map? m) =>
      m == null ? TableStepModel() : TableStepModelBase.fromJson(m);
  static TableStepModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TableStepModel_CLASS:
        return TableStepModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TableStepModel_CLASS;
  Relation get relation => _relation;

  set relation(Relation $o) {
    if ($o == _relation) return;
    _relation.parent = null;
    $o.parent = this;
    var $old = _relation;
    _relation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.relation_OP, $old, _relation));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.relation_OP:
        return relation;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.relation_OP:
        relation = $value as Relation;
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
  TableStepModel copy() => TableStepModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TableStepModel_CLASS;
    if (subKind != null && subKind != Vocabulary.TableStepModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relation_OP] = relation.toJson();
    return m;
  }
}
