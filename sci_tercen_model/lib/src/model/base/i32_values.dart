part of sci_model_base;

class I32ValuesBase extends CValues {
  static const List<String> PROPERTY_NAMES = [Vocabulary.values_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChangedBase<int> values;

  I32ValuesBase() : values = base.ListChangedBase<int>() {
    values.parent = this;
  }

  I32ValuesBase.json(Map m)
      : values = base.ListChangedBase<int>(m[Vocabulary.values_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.I32Values_CLASS, m);
    values.parent = this;
  }

  static I32Values createFromJson(Map m) => I32ValuesBase.fromJson(m);
  static I32Values fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.I32Values_CLASS:
        return I32Values.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.I32Values_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.values_DP:
        return values;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.values_DP:
        values.setValues($value as Iterable<int>);
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
  I32Values copy() => I32Values.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.I32Values_CLASS;
    if (subKind != null && subKind != Vocabulary.I32Values_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.values_DP] = values;
    return m;
  }
}
