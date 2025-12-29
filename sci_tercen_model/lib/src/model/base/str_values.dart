part of sci_model_base;

class StrValuesBase extends CValues {
  static const List<String> PROPERTY_NAMES = [Vocabulary.values_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChangedBase<String> values;

  StrValuesBase() : values = base.ListChangedBase<String>() {
    values.parent = this;
  }

  StrValuesBase.json(Map m)
      : values = base.ListChangedBase<String>(m[Vocabulary.values_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.StrValues_CLASS, m);
    values.parent = this;
  }

  static StrValues createFromJson(Map m) => StrValuesBase.fromJson(m);
  static StrValues fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.StrValues_CLASS:
        return StrValues.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.StrValues_CLASS;

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
        values.setValues($value as Iterable<String>);
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
  StrValues copy() => StrValues.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.StrValues_CLASS;
    if (subKind != null && subKind != Vocabulary.StrValues_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.values_DP] = values;
    return m;
  }
}
