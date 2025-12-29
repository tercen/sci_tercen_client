part of sci_model_base;

class FeatureBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.coefficient_DP,
    Vocabulary.exponent_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  double _coefficient;
  double _exponent;

  FeatureBase()
      : _name = "",
        _coefficient = 0.0,
        _exponent = 0.0;
  FeatureBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _coefficient = base.defaultDouble(m[Vocabulary.coefficient_DP] as num?),
        _exponent = base.defaultDouble(m[Vocabulary.exponent_DP] as num?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Feature_CLASS, m);
  }

  static Feature createFromJson(Map m) => FeatureBase.fromJson(m);
  static Feature fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Feature_CLASS:
        return Feature.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Feature_CLASS;
  String get name => _name;

  set name(String $o) {
    if ($o == _name) return;
    var $old = _name;
    _name = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.name_DP, $old, _name));
    }
  }

  double get coefficient => _coefficient;

  set coefficient(double $o) {
    if ($o == _coefficient) return;
    var $old = _coefficient;
    _coefficient = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.coefficient_DP, $old, _coefficient));
    }
  }

  double get exponent => _exponent;

  set exponent(double $o) {
    if ($o == _exponent) return;
    var $old = _exponent;
    _exponent = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.exponent_DP, $old, _exponent));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.coefficient_DP:
        return coefficient;
      case Vocabulary.exponent_DP:
        return exponent;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.coefficient_DP:
        coefficient = $value as double;
        return;
      case Vocabulary.exponent_DP:
        exponent = $value as double;
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
  Feature copy() => Feature.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Feature_CLASS;
    if (subKind != null && subKind != Vocabulary.Feature_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.coefficient_DP] = coefficient;
    m[Vocabulary.exponent_DP] = exponent;
    return m;
  }
}
