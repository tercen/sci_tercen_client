part of sci_model_base;

class XYAxisListBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.rectangleSelections_OP,
    Vocabulary.xyAxis_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Rectangle> rectangleSelections;
  final base.ListChanged<XYAxis> xyAxis;

  XYAxisListBase()
      : rectangleSelections = base.ListChanged<Rectangle>(),
        xyAxis = base.ListChanged<XYAxis>() {
    rectangleSelections.parent = this;
    xyAxis.parent = this;
  }

  XYAxisListBase.json(Map m)
      : rectangleSelections = base.ListChanged<Rectangle>.from(
            m[Vocabulary.rectangleSelections_OP] as List?,
            RectangleBase.createFromJson),
        xyAxis = base.ListChanged<XYAxis>.from(
            m[Vocabulary.xyAxis_OP] as List?, XYAxisBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.XYAxisList_CLASS, m);
    rectangleSelections.parent = this;
    xyAxis.parent = this;
  }

  static XYAxisList createFromJson(Map m) => XYAxisListBase.fromJson(m);
  static XYAxisList _createFromJson(Map? m) =>
      m == null ? XYAxisList() : XYAxisListBase.fromJson(m);
  static XYAxisList fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.XYAxisList_CLASS:
        return XYAxisList.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.XYAxisList_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.rectangleSelections_OP:
        return rectangleSelections;
      case Vocabulary.xyAxis_OP:
        return xyAxis;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.rectangleSelections_OP:
        rectangleSelections.setValues($value as Iterable<Rectangle>);
        return;
      case Vocabulary.xyAxis_OP:
        xyAxis.setValues($value as Iterable<XYAxis>);
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
  XYAxisList copy() => XYAxisList.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.XYAxisList_CLASS;
    if (subKind != null && subKind != Vocabulary.XYAxisList_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.rectangleSelections_OP] = rectangleSelections.toJson();
    m[Vocabulary.xyAxis_OP] = xyAxis.toJson();
    return m;
  }
}
