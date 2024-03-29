part of sci_model_base;

class CrosstabTableBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.cellSize_DP,
    Vocabulary.offset_DP,
    Vocabulary.graphicalFactors_OP,
    Vocabulary.rectangleSelections_OP,
    Vocabulary.nRows_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  double _cellSize;
  int _offset;
  final base.ListChanged<GraphicalFactor> graphicalFactors;
  final base.ListChanged<Rectangle> rectangleSelections;
  int _nRows;

  CrosstabTableBase()
      : _cellSize = 0.0,
        _offset = 0,
        _nRows = 0,
        graphicalFactors = base.ListChanged<GraphicalFactor>(),
        rectangleSelections = base.ListChanged<Rectangle>() {
    graphicalFactors.parent = this;
    rectangleSelections.parent = this;
  }

  CrosstabTableBase.json(Map m)
      : _cellSize = base.defaultDouble(m[Vocabulary.cellSize_DP] as num?),
        _offset = base.defaultValue(
            m[Vocabulary.offset_DP] as int?, base.int_DefaultFactory),
        _nRows = base.defaultValue(
            m[Vocabulary.nRows_DP] as int?, base.int_DefaultFactory),
        graphicalFactors = base.ListChanged<GraphicalFactor>.from(
            m[Vocabulary.graphicalFactors_OP] as List?,
            GraphicalFactorBase.createFromJson),
        rectangleSelections = base.ListChanged<Rectangle>.from(
            m[Vocabulary.rectangleSelections_OP] as List?,
            RectangleBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CrosstabTable_CLASS, m);
    graphicalFactors.parent = this;
    rectangleSelections.parent = this;
  }

  static CrosstabTable createFromJson(Map m) => CrosstabTableBase.fromJson(m);
  static CrosstabTable _createFromJson(Map? m) =>
      m == null ? CrosstabTable() : CrosstabTableBase.fromJson(m);
  static CrosstabTable fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CrosstabTable_CLASS:
        return CrosstabTable.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CrosstabTable_CLASS;
  double get cellSize => _cellSize;

  set cellSize(double $o) {
    if ($o == _cellSize) return;
    var $old = _cellSize;
    _cellSize = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cellSize_DP, $old, _cellSize));
    }
  }

  int get offset => _offset;

  set offset(int $o) {
    if ($o == _offset) return;
    var $old = _offset;
    _offset = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.offset_DP, $old, _offset));
    }
  }

  int get nRows => _nRows;

  set nRows(int $o) {
    if ($o == _nRows) return;
    var $old = _nRows;
    _nRows = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nRows_DP, $old, _nRows));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.cellSize_DP:
        return cellSize;
      case Vocabulary.offset_DP:
        return offset;
      case Vocabulary.graphicalFactors_OP:
        return graphicalFactors;
      case Vocabulary.rectangleSelections_OP:
        return rectangleSelections;
      case Vocabulary.nRows_DP:
        return nRows;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.cellSize_DP:
        cellSize = $value as double;
        return;
      case Vocabulary.offset_DP:
        offset = $value as int;
        return;
      case Vocabulary.nRows_DP:
        nRows = $value as int;
        return;
      case Vocabulary.graphicalFactors_OP:
        graphicalFactors.setValues($value as Iterable<GraphicalFactor>);
        return;
      case Vocabulary.rectangleSelections_OP:
        rectangleSelections.setValues($value as Iterable<Rectangle>);
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
  CrosstabTable copy() => CrosstabTable.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CrosstabTable_CLASS;
    if (subKind != null && subKind != Vocabulary.CrosstabTable_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.cellSize_DP] = cellSize;
    m[Vocabulary.offset_DP] = offset;
    m[Vocabulary.graphicalFactors_OP] = graphicalFactors.toJson();
    m[Vocabulary.rectangleSelections_OP] = rectangleSelections.toJson();
    m[Vocabulary.nRows_DP] = nRows;
    return m;
  }
}
