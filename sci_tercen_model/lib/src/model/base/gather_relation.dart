part of sci_model_base;

class GatherRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.relation_OP,
    Vocabulary.names_DP,
    Vocabulary.valueName_DP,
    Vocabulary.variableName_DP,
    Vocabulary.valueType_DP,
    Vocabulary.gatherType_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Relation _relation;
  final base.ListChangedBase<String> names;
  String _valueName;
  String _variableName;
  String _valueType;
  String _gatherType;

  GatherRelationBase()
      : names = base.ListChangedBase<String>(),
        _valueName = "",
        _variableName = "",
        _valueType = "",
        _gatherType = "",
        _relation = Relation() {
    names.parent = this;
    _relation.parent = this;
  }

  GatherRelationBase.json(Map m)
      : names = base.ListChangedBase<String>(m[Vocabulary.names_DP] as List?),
        _valueName = base.defaultValue(
            m[Vocabulary.valueName_DP] as String?, base.String_DefaultFactory),
        _variableName = base.defaultValue(
            m[Vocabulary.variableName_DP] as String?,
            base.String_DefaultFactory),
        _valueType = base.defaultValue(
            m[Vocabulary.valueType_DP] as String?, base.String_DefaultFactory),
        _gatherType = base.defaultValue(
            m[Vocabulary.gatherType_DP] as String?, base.String_DefaultFactory),
        _relation =
            RelationBase._createFromJson(m[Vocabulary.relation_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GatherRelation_CLASS, m);
    names.parent = this;
    _relation.parent = this;
  }

  static GatherRelation createFromJson(Map m) => GatherRelationBase.fromJson(m);
  static GatherRelation _createFromJson(Map? m) =>
      m == null ? GatherRelation() : GatherRelationBase.fromJson(m);
  static GatherRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GatherRelation_CLASS:
        return GatherRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GatherRelation_CLASS;
  String get valueName => _valueName;

  set valueName(String $o) {
    if ($o == _valueName) return;
    var $old = _valueName;
    _valueName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.valueName_DP, $old, _valueName));
    }
  }

  String get variableName => _variableName;

  set variableName(String $o) {
    if ($o == _variableName) return;
    var $old = _variableName;
    _variableName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.variableName_DP, $old, _variableName));
    }
  }

  String get valueType => _valueType;

  set valueType(String $o) {
    if ($o == _valueType) return;
    var $old = _valueType;
    _valueType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.valueType_DP, $old, _valueType));
    }
  }

  String get gatherType => _gatherType;

  set gatherType(String $o) {
    if ($o == _gatherType) return;
    var $old = _gatherType;
    _gatherType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.gatherType_DP, $old, _gatherType));
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
      case Vocabulary.names_DP:
        return names;
      case Vocabulary.valueName_DP:
        return valueName;
      case Vocabulary.variableName_DP:
        return variableName;
      case Vocabulary.valueType_DP:
        return valueType;
      case Vocabulary.gatherType_DP:
        return gatherType;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.names_DP:
        names.setValues($value as Iterable<String>);
        return;
      case Vocabulary.valueName_DP:
        valueName = $value as String;
        return;
      case Vocabulary.variableName_DP:
        variableName = $value as String;
        return;
      case Vocabulary.valueType_DP:
        valueType = $value as String;
        return;
      case Vocabulary.gatherType_DP:
        gatherType = $value as String;
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
  GatherRelation copy() => GatherRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GatherRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.GatherRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relation_OP] = relation.toJson();
    m[Vocabulary.names_DP] = names;
    m[Vocabulary.valueName_DP] = valueName;
    m[Vocabulary.variableName_DP] = variableName;
    m[Vocabulary.valueType_DP] = valueType;
    m[Vocabulary.gatherType_DP] = gatherType;
    return m;
  }
}
