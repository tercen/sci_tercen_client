part of sci_model_base;

class SimpleRelationBase extends Relation {
  static const List<String> PROPERTY_NAMES = [Vocabulary.index_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _index;

  SimpleRelationBase() : _index = 0;
  SimpleRelationBase.json(Map m)
      : _index = base.defaultValue(
            m[Vocabulary.index_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.SimpleRelation_CLASS, m);
  }

  static SimpleRelation createFromJson(Map m) => SimpleRelationBase.fromJson(m);
  static SimpleRelation _createFromJson(Map? m) =>
      m == null ? SimpleRelation() : SimpleRelationBase.fromJson(m);
  static SimpleRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.SimpleRelation_CLASS:
        return SimpleRelation.json(m);
      case Vocabulary.TableRelation_CLASS:
        return TableRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.SimpleRelation_CLASS;
  int get index => _index;

  set index(int $o) {
    if ($o == _index) return;
    var $old = _index;
    _index = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.index_DP, $old, _index));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.index_DP:
        return index;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.index_DP:
        index = $value as int;
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
  SimpleRelation copy() => SimpleRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.SimpleRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.SimpleRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.index_DP] = index;
    return m;
  }
}
