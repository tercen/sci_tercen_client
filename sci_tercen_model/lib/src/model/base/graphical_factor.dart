part of sci_model_base;

class GraphicalFactorBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.factor_OP,
    Vocabulary.rectangle_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Factor _factor;
  Rectangle _rectangle;

  GraphicalFactorBase()
      : _factor = Factor(),
        _rectangle = Rectangle() {
    _factor.parent = this;
    _rectangle.parent = this;
  }

  GraphicalFactorBase.json(Map m)
      : _factor = (m[Vocabulary.factor_OP] as Map?) == null
            ? Factor()
            : FactorBase.fromJson(m[Vocabulary.factor_OP] as Map),
        _rectangle = (m[Vocabulary.rectangle_OP] as Map?) == null
            ? Rectangle()
            : RectangleBase.fromJson(m[Vocabulary.rectangle_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GraphicalFactor_CLASS, m);
    _factor.parent = this;
    _rectangle.parent = this;
  }

  static GraphicalFactor createFromJson(Map m) =>
      GraphicalFactorBase.fromJson(m);
  static GraphicalFactor fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GraphicalFactor_CLASS:
        return GraphicalFactor.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GraphicalFactor_CLASS;
  Factor get factor => _factor;

  set factor(Factor $o) {
    if ($o == _factor) return;
    _factor.parent = null;
    $o.parent = this;
    var $old = _factor;
    _factor = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.factor_OP, $old, _factor));
    }
  }

  Rectangle get rectangle => _rectangle;

  set rectangle(Rectangle $o) {
    if ($o == _rectangle) return;
    _rectangle.parent = null;
    $o.parent = this;
    var $old = _rectangle;
    _rectangle = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.rectangle_OP, $old, _rectangle));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.factor_OP:
        return factor;
      case Vocabulary.rectangle_OP:
        return rectangle;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.factor_OP:
        factor = $value as Factor;
        return;
      case Vocabulary.rectangle_OP:
        rectangle = $value as Rectangle;
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
  GraphicalFactor copy() => GraphicalFactor.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GraphicalFactor_CLASS;
    if (subKind != null && subKind != Vocabulary.GraphicalFactor_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.factor_OP] = factor.toJson();
    m[Vocabulary.rectangle_OP] = rectangle.toJson();
    return m;
  }
}
