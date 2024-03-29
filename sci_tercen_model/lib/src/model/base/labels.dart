part of sci_model_base;

class LabelsBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.factors_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Factor> factors;

  LabelsBase() : factors = base.ListChanged<Factor>() {
    factors.parent = this;
  }

  LabelsBase.json(Map m)
      : factors = base.ListChanged<Factor>.from(
            m[Vocabulary.factors_OP] as List?, FactorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Labels_CLASS, m);
    factors.parent = this;
  }

  static Labels createFromJson(Map m) => LabelsBase.fromJson(m);
  static Labels _createFromJson(Map? m) =>
      m == null ? Labels() : LabelsBase.fromJson(m);
  static Labels fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Labels_CLASS:
        return Labels.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Labels_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.factors_OP:
        return factors;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.factors_OP:
        factors.setValues($value as Iterable<Factor>);
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
  Labels copy() => Labels.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Labels_CLASS;
    if (subKind != null && subKind != Vocabulary.Labels_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.factors_OP] = factors.toJson();
    return m;
  }
}
