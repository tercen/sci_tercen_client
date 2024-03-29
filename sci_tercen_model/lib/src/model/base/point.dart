part of sci_model_base;

class PointBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.x_DP, Vocabulary.y_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  double _x;
  double _y;

  PointBase()
      : _x = 0.0,
        _y = 0.0;
  PointBase.json(Map m)
      : _x = base.defaultDouble(m[Vocabulary.x_DP] as num?),
        _y = base.defaultDouble(m[Vocabulary.y_DP] as num?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Point_CLASS, m);
  }

  static Point createFromJson(Map m) => PointBase.fromJson(m);
  static Point _createFromJson(Map? m) =>
      m == null ? Point() : PointBase.fromJson(m);
  static Point fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Point_CLASS:
        return Point.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Point_CLASS;
  double get x => _x;

  set x(double $o) {
    if ($o == _x) return;
    var $old = _x;
    _x = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.x_DP, $old, _x));
    }
  }

  double get y => _y;

  set y(double $o) {
    if ($o == _y) return;
    var $old = _y;
    _y = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.y_DP, $old, _y));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.x_DP:
        return x;
      case Vocabulary.y_DP:
        return y;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.x_DP:
        x = $value as double;
        return;
      case Vocabulary.y_DP:
        y = $value as double;
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
  Point copy() => Point.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Point_CLASS;
    if (subKind != null && subKind != Vocabulary.Point_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.x_DP] = x;
    m[Vocabulary.y_DP] = y;
    return m;
  }
}
