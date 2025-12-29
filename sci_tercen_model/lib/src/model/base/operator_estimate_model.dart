part of sci_model_base;

class OperatorEstimateModelBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.intercept_DP,
    Vocabulary.offset_DP,
    Vocabulary.features_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  double _intercept;
  double _offset;
  final base.ListChanged<Feature> features;

  OperatorEstimateModelBase()
      : _intercept = 0.0,
        _offset = 0.0,
        features = base.ListChanged<Feature>() {
    features.parent = this;
  }

  OperatorEstimateModelBase.json(Map m)
      : _intercept = base.defaultDouble(m[Vocabulary.intercept_DP] as num?),
        _offset = base.defaultDouble(m[Vocabulary.offset_DP] as num?),
        features = base.ListChanged<Feature>.from(
            m[Vocabulary.features_OP] as List?, FeatureBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OperatorEstimateModel_CLASS, m);
    features.parent = this;
  }

  static OperatorEstimateModel createFromJson(Map m) =>
      OperatorEstimateModelBase.fromJson(m);
  static OperatorEstimateModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OperatorEstimateModel_CLASS:
        return OperatorEstimateModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OperatorEstimateModel_CLASS;
  double get intercept => _intercept;

  set intercept(double $o) {
    if ($o == _intercept) return;
    var $old = _intercept;
    _intercept = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.intercept_DP, $old, _intercept));
    }
  }

  double get offset => _offset;

  set offset(double $o) {
    if ($o == _offset) return;
    var $old = _offset;
    _offset = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.offset_DP, $old, _offset));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.intercept_DP:
        return intercept;
      case Vocabulary.offset_DP:
        return offset;
      case Vocabulary.features_OP:
        return features;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.intercept_DP:
        intercept = $value as double;
        return;
      case Vocabulary.offset_DP:
        offset = $value as double;
        return;
      case Vocabulary.features_OP:
        features.setValues($value as Iterable<Feature>);
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
  OperatorEstimateModel copy() => OperatorEstimateModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OperatorEstimateModel_CLASS;
    if (subKind != null && subKind != Vocabulary.OperatorEstimateModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.intercept_DP] = intercept;
    m[Vocabulary.offset_DP] = offset;
    m[Vocabulary.features_OP] = features.toJson();
    return m;
  }
}
