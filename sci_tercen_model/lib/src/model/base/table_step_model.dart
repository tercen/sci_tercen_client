part of sci_model_base;

class TableStepModelBase extends StepModel {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.relation_OP,
    Vocabulary.filterSelector_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.relation_OP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Relation", Vocabulary.relation_OP, isComposite: false)
  ];
  Relation _relation;
  String _filterSelector;

  TableStepModelBase()
      : _filterSelector = "",
        _relation = Relation() {
    _relation.parent = this;
  }

  TableStepModelBase.json(Map m)
      : _filterSelector = base.defaultValue(
            m[Vocabulary.filterSelector_DP] as String?,
            base.String_DefaultFactory),
        _relation = (m[Vocabulary.relation_OP] as Map?) == null
            ? Relation()
            : RelationBase.fromJson(m[Vocabulary.relation_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TableStepModel_CLASS, m);
    _relation.parent = this;
  }

  static TableStepModel createFromJson(Map m) => TableStepModelBase.fromJson(m);
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
  String get filterSelector => _filterSelector;

  set filterSelector(String $o) {
    if ($o == _filterSelector) return;
    var $old = _filterSelector;
    _filterSelector = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.filterSelector_DP, $old, _filterSelector));
    }
  }

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
      case Vocabulary.filterSelector_DP:
        return filterSelector;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.filterSelector_DP:
        filterSelector = $value as String;
        return;
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
    m[Vocabulary.filterSelector_DP] = filterSelector;
    return m;
  }
}
