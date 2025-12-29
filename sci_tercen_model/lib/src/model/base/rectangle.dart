part of sci_model_base;

class RectangleBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.extent_OP,
    Vocabulary.topLeft_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Point _extent;
  Point _topLeft;

  RectangleBase()
      : _extent = Point(),
        _topLeft = Point() {
    _extent.parent = this;
    _topLeft.parent = this;
  }

  RectangleBase.json(Map m)
      : _extent = (m[Vocabulary.extent_OP] as Map?) == null
            ? Point()
            : PointBase.fromJson(m[Vocabulary.extent_OP] as Map),
        _topLeft = (m[Vocabulary.topLeft_OP] as Map?) == null
            ? Point()
            : PointBase.fromJson(m[Vocabulary.topLeft_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Rectangle_CLASS, m);
    _extent.parent = this;
    _topLeft.parent = this;
  }

  static Rectangle createFromJson(Map m) => RectangleBase.fromJson(m);
  static Rectangle fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Rectangle_CLASS:
        return Rectangle.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Rectangle_CLASS;
  Point get extent => _extent;

  set extent(Point $o) {
    if ($o == _extent) return;
    _extent.parent = null;
    $o.parent = this;
    var $old = _extent;
    _extent = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.extent_OP, $old, _extent));
    }
  }

  Point get topLeft => _topLeft;

  set topLeft(Point $o) {
    if ($o == _topLeft) return;
    _topLeft.parent = null;
    $o.parent = this;
    var $old = _topLeft;
    _topLeft = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.topLeft_OP, $old, _topLeft));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.extent_OP:
        return extent;
      case Vocabulary.topLeft_OP:
        return topLeft;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.extent_OP:
        extent = $value as Point;
        return;
      case Vocabulary.topLeft_OP:
        topLeft = $value as Point;
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
  Rectangle copy() => Rectangle.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Rectangle_CLASS;
    if (subKind != null && subKind != Vocabulary.Rectangle_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.extent_OP] = extent.toJson();
    m[Vocabulary.topLeft_OP] = topLeft.toJson();
    return m;
  }
}
