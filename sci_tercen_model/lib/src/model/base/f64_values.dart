part of sci_model_base;

class F64ValuesBase extends CValues {
  static const List<String> PROPERTY_NAMES = [Vocabulary.values_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChangedBase<double> values;

  F64ValuesBase() : values = base.ListChangedBase<double>() {
    values.parent = this;
  }

  F64ValuesBase.json(Map m)
      : values = base.ListChangedBase<double>(m[Vocabulary.values_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.F64Values_CLASS, m);
    values.parent = this;
  }

  static F64Values createFromJson(Map m) => F64ValuesBase.fromJson(m);
  static F64Values _createFromJson(Map? m) =>
      m == null ? F64Values() : F64ValuesBase.fromJson(m);
  static F64Values fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.F64Values_CLASS:
        return F64Values.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.F64Values_CLASS;

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
        values.setValues($value as Iterable<double>);
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
  F64Values copy() => F64Values.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.F64Values_CLASS;
    if (subKind != null && subKind != Vocabulary.F64Values_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.values_DP] = values;
    return m;
  }
}
