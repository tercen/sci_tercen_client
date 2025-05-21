part of sci_model_base;

class RangeRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.relation_OP,
    Vocabulary.start_DP,
    Vocabulary.len_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Relation _relation;
  int _start;
  int _len;

  RangeRelationBase()
      : _start = 0,
        _len = 0,
        _relation = Relation() {
    _relation.parent = this;
  }

  RangeRelationBase.json(Map m)
      : _start = base.defaultValue(
            m[Vocabulary.start_DP] as int?, base.int_DefaultFactory),
        _len = base.defaultValue(
            m[Vocabulary.len_DP] as int?, base.int_DefaultFactory),
        _relation =
            RelationBase._createFromJson(m[Vocabulary.relation_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RangeRelation_CLASS, m);
    _relation.parent = this;
  }

  static RangeRelation createFromJson(Map m) => RangeRelationBase.fromJson(m);
  static RangeRelation _createFromJson(Map? m) =>
      m == null ? RangeRelation() : RangeRelationBase.fromJson(m);
  static RangeRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RangeRelation_CLASS:
        return RangeRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RangeRelation_CLASS;
  int get start => _start;

  set start(int $o) {
    if ($o == _start) return;
    var $old = _start;
    _start = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.start_DP, $old, _start));
    }
  }

  int get len => _len;

  set len(int $o) {
    if ($o == _len) return;
    var $old = _len;
    _len = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.len_DP, $old, _len));
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
      case Vocabulary.start_DP:
        return start;
      case Vocabulary.len_DP:
        return len;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.start_DP:
        start = $value as int;
        return;
      case Vocabulary.len_DP:
        len = $value as int;
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
  RangeRelation copy() => RangeRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RangeRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.RangeRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.relation_OP] = relation.toJson();
    m[Vocabulary.start_DP] = start;
    m[Vocabulary.len_DP] = len;
    return m;
  }
}
