part of sci_model_base;

class EnumeratedPropertyBase extends StringProperty {
  static const List<String> PROPERTY_NAMES = [Vocabulary.values_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChangedBase<String> values;

  EnumeratedPropertyBase() : values = base.ListChangedBase<String>() {
    values.parent = this;
  }

  EnumeratedPropertyBase.json(Map m)
      : values = base.ListChangedBase<String>(m[Vocabulary.values_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.EnumeratedProperty_CLASS, m);
    values.parent = this;
  }

  static EnumeratedProperty createFromJson(Map m) =>
      EnumeratedPropertyBase.fromJson(m);
  static EnumeratedProperty _createFromJson(Map? m) =>
      m == null ? EnumeratedProperty() : EnumeratedPropertyBase.fromJson(m);
  static EnumeratedProperty fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.EnumeratedProperty_CLASS:
        return EnumeratedProperty.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.EnumeratedProperty_CLASS;

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
  EnumeratedProperty copy() => EnumeratedProperty.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.EnumeratedProperty_CLASS;
    if (subKind != null && subKind != Vocabulary.EnumeratedProperty_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.values_DP] = values;
    return m;
  }
}
