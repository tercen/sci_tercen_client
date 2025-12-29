part of sci_model_base;

class GateOperatorModelBase extends OperatorModel {
  static const List<String> PROPERTY_NAMES = [Vocabulary.roots_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<GateNode> roots;

  GateOperatorModelBase() : roots = base.ListChanged<GateNode>() {
    roots.parent = this;
  }

  GateOperatorModelBase.json(Map m)
      : roots = base.ListChanged<GateNode>.from(
            m[Vocabulary.roots_OP] as List?, GateNodeBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GateOperatorModel_CLASS, m);
    roots.parent = this;
  }

  static GateOperatorModel createFromJson(Map m) =>
      GateOperatorModelBase.fromJson(m);
  static GateOperatorModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GateOperatorModel_CLASS:
        return GateOperatorModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GateOperatorModel_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.roots_OP:
        return roots;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.roots_OP:
        roots.setValues($value as Iterable<GateNode>);
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
  GateOperatorModel copy() => GateOperatorModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GateOperatorModel_CLASS;
    if (subKind != null && subKind != Vocabulary.GateOperatorModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.roots_OP] = roots.toJson();
    return m;
  }
}
