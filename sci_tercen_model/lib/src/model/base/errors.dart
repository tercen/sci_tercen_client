part of sci_model_base;

class ErrorsBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.factors_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Factor> factors;

  ErrorsBase() : factors = base.ListChanged<Factor>() {
    factors.parent = this;
  }

  ErrorsBase.json(Map m)
      : factors = base.ListChanged<Factor>.from(
            m[Vocabulary.factors_OP] as List?, FactorBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Errors_CLASS, m);
    factors.parent = this;
  }

  static Errors createFromJson(Map m) => ErrorsBase.fromJson(m);
  static Errors _createFromJson(Map? m) =>
      m == null ? Errors() : ErrorsBase.fromJson(m);
  static Errors fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Errors_CLASS:
        return Errors.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Errors_CLASS;

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
  Errors copy() => Errors.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Errors_CLASS;
    if (subKind != null && subKind != Vocabulary.Errors_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.factors_OP] = factors.toJson();
    return m;
  }
}
