part of sci_model_base;

class AxisSpecBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [Vocabulary.metaFactors_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<MetaFactor> metaFactors;

  AxisSpecBase() : metaFactors = base.ListChanged<MetaFactor>() {
    metaFactors.parent = this;
  }

  AxisSpecBase.json(Map m)
      : metaFactors = base.ListChanged<MetaFactor>.from(
            m[Vocabulary.metaFactors_OP] as List?,
            MetaFactorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.AxisSpec_CLASS, m);
    metaFactors.parent = this;
  }

  static AxisSpec createFromJson(Map m) => AxisSpecBase.fromJson(m);
  static AxisSpec fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.AxisSpec_CLASS:
        return AxisSpec.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.AxisSpec_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.metaFactors_OP:
        return metaFactors;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.metaFactors_OP:
        metaFactors.setValues($value as Iterable<MetaFactor>);
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

  AxisSpec copy() => AxisSpec.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.AxisSpec_CLASS;
    if (subKind != null && subKind != Vocabulary.AxisSpec_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.metaFactors_OP] = metaFactors.toJson();
    return m;
  }
}
