part of sci_model_base;

class CrosstabSpecBase extends OperatorInputSpec {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.metaFactors_OP,
    Vocabulary.axis_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<MetaFactor> metaFactors;
  final base.ListChanged<AxisSpec> axis;

  CrosstabSpecBase()
      : metaFactors = base.ListChanged<MetaFactor>(),
        axis = base.ListChanged<AxisSpec>() {
    metaFactors.parent = this;
    axis.parent = this;
  }

  CrosstabSpecBase.json(Map m)
      : metaFactors = base.ListChanged<MetaFactor>.from(
            m[Vocabulary.metaFactors_OP] as List?,
            MetaFactorBase.createFromJson),
        axis = base.ListChanged<AxisSpec>.from(
            m[Vocabulary.axis_OP] as List?, AxisSpecBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CrosstabSpec_CLASS, m);
    metaFactors.parent = this;
    axis.parent = this;
  }

  static CrosstabSpec createFromJson(Map m) => CrosstabSpecBase.fromJson(m);
  static CrosstabSpec _createFromJson(Map? m) =>
      m == null ? CrosstabSpec() : CrosstabSpecBase.fromJson(m);
  static CrosstabSpec fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CrosstabSpec_CLASS:
        return CrosstabSpec.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CrosstabSpec_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.metaFactors_OP:
        return metaFactors;
      case Vocabulary.axis_OP:
        return axis;
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
      case Vocabulary.axis_OP:
        axis.setValues($value as Iterable<AxisSpec>);
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
  CrosstabSpec copy() => CrosstabSpec.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CrosstabSpec_CLASS;
    if (subKind != null && subKind != Vocabulary.CrosstabSpec_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.metaFactors_OP] = metaFactors.toJson();
    m[Vocabulary.axis_OP] = axis.toJson();
    return m;
  }
}
