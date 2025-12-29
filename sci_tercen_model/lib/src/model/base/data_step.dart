part of sci_model_base;

class DataStepBase extends CrossTabStep {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.computedRelation_OP,
    Vocabulary.parentDataStepId_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [
    Vocabulary.computedRelation_OP
  ];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Relation", Vocabulary.computedRelation_OP, isComposite: true)
  ];
  Relation _computedRelation;
  String _parentDataStepId;

  DataStepBase()
      : _parentDataStepId = "",
        _computedRelation = Relation() {
    _computedRelation.parent = this;
  }

  DataStepBase.json(Map m)
      : _parentDataStepId = base.defaultValue(
            m[Vocabulary.parentDataStepId_DP] as String?,
            base.String_DefaultFactory),
        _computedRelation = (m[Vocabulary.computedRelation_OP] as Map?) == null
            ? Relation()
            : RelationBase.fromJson(m[Vocabulary.computedRelation_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.DataStep_CLASS, m);
    _computedRelation.parent = this;
  }

  static DataStep createFromJson(Map m) => DataStepBase.fromJson(m);
  static DataStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.DataStep_CLASS:
        return DataStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.DataStep_CLASS;
  String get parentDataStepId => _parentDataStepId;

  set parentDataStepId(String $o) {
    if ($o == _parentDataStepId) return;
    var $old = _parentDataStepId;
    _parentDataStepId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.parentDataStepId_DP, $old, _parentDataStepId));
    }
  }

  Relation get computedRelation => _computedRelation;

  set computedRelation(Relation $o) {
    if ($o == _computedRelation) return;
    _computedRelation.parent = null;
    $o.parent = this;
    var $old = _computedRelation;
    _computedRelation = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.computedRelation_OP, $old, _computedRelation));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.computedRelation_OP:
        return computedRelation;
      case Vocabulary.parentDataStepId_DP:
        return parentDataStepId;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.parentDataStepId_DP:
        parentDataStepId = $value as String;
        return;
      case Vocabulary.computedRelation_OP:
        computedRelation = $value as Relation;
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
  DataStep copy() => DataStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.DataStep_CLASS;
    if (subKind != null && subKind != Vocabulary.DataStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.computedRelation_OP] = computedRelation.toJson();
    m[Vocabulary.parentDataStepId_DP] = parentDataStepId;
    return m;
  }
}
