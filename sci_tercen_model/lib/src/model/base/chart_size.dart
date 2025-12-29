part of sci_model_base;

class ChartSizeBase extends Chart {
  static const List<String> PROPERTY_NAMES = [Vocabulary.pointSize_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _pointSize;

  ChartSizeBase() : _pointSize = 0;
  ChartSizeBase.json(Map m)
      : _pointSize = base.defaultValue(
            m[Vocabulary.pointSize_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ChartSize_CLASS, m);
  }

  static ChartSize createFromJson(Map m) => ChartSizeBase.fromJson(m);
  static ChartSize fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ChartSize_CLASS:
        return ChartSize.json(m);
      case Vocabulary.ChartLine_CLASS:
        return ChartLine.json(m);
      case Vocabulary.ChartPoint_CLASS:
        return ChartPoint.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ChartSize_CLASS;
  int get pointSize => _pointSize;

  set pointSize(int $o) {
    if ($o == _pointSize) return;
    var $old = _pointSize;
    _pointSize = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.pointSize_DP, $old, _pointSize));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.pointSize_DP:
        return pointSize;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.pointSize_DP:
        pointSize = $value as int;
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
  ChartSize copy() => ChartSize.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ChartSize_CLASS;
    if (subKind != null && subKind != Vocabulary.ChartSize_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.pointSize_DP] = pointSize;
    return m;
  }
}
