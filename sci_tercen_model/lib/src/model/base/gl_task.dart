part of sci_model_base;

class GlTaskBase extends Task {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.cubeQueryTask_OP,
    Vocabulary.palettes_OP,
    Vocabulary.split_DP,
    Vocabulary.xCellResolution_DP,
    Vocabulary.yCellResolution_DP,
    Vocabulary.range_OP,
    Vocabulary.layer_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  CubeQueryTask _cubeQueryTask;
  final base.ListChanged<Palette> palettes;
  int _split;
  double _xCellResolution;
  double _yCellResolution;
  Rectangle _range;
  int _layer;

  GlTaskBase()
      : _split = 0,
        _xCellResolution = 0.0,
        _yCellResolution = 0.0,
        _layer = 0,
        _cubeQueryTask = CubeQueryTask(),
        palettes = base.ListChanged<Palette>(),
        _range = Rectangle() {
    _cubeQueryTask.parent = this;
    palettes.parent = this;
    _range.parent = this;
  }

  GlTaskBase.json(Map m)
      : _split = base.defaultValue(
            m[Vocabulary.split_DP] as int?, base.int_DefaultFactory),
        _xCellResolution =
            base.defaultDouble(m[Vocabulary.xCellResolution_DP] as num?),
        _yCellResolution =
            base.defaultDouble(m[Vocabulary.yCellResolution_DP] as num?),
        _layer = base.defaultValue(
            m[Vocabulary.layer_DP] as int?, base.int_DefaultFactory),
        _cubeQueryTask = (m[Vocabulary.cubeQueryTask_OP] as Map?) == null
            ? CubeQueryTask()
            : CubeQueryTaskBase.fromJson(m[Vocabulary.cubeQueryTask_OP] as Map),
        palettes = base.ListChanged<Palette>.from(
            m[Vocabulary.palettes_OP] as List?, PaletteBase.createFromJson),
        _range = (m[Vocabulary.range_OP] as Map?) == null
            ? Rectangle()
            : RectangleBase.fromJson(m[Vocabulary.range_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GlTask_CLASS, m);
    _cubeQueryTask.parent = this;
    palettes.parent = this;
    _range.parent = this;
  }

  static GlTask createFromJson(Map m) => GlTaskBase.fromJson(m);
  static GlTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GlTask_CLASS:
        return GlTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GlTask_CLASS;
  int get split => _split;

  set split(int $o) {
    if ($o == _split) return;
    var $old = _split;
    _split = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.split_DP, $old, _split));
    }
  }

  double get xCellResolution => _xCellResolution;

  set xCellResolution(double $o) {
    if ($o == _xCellResolution) return;
    var $old = _xCellResolution;
    _xCellResolution = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.xCellResolution_DP, $old, _xCellResolution));
    }
  }

  double get yCellResolution => _yCellResolution;

  set yCellResolution(double $o) {
    if ($o == _yCellResolution) return;
    var $old = _yCellResolution;
    _yCellResolution = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.yCellResolution_DP, $old, _yCellResolution));
    }
  }

  int get layer => _layer;

  set layer(int $o) {
    if ($o == _layer) return;
    var $old = _layer;
    _layer = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.layer_DP, $old, _layer));
    }
  }

  CubeQueryTask get cubeQueryTask => _cubeQueryTask;

  set cubeQueryTask(CubeQueryTask $o) {
    if ($o == _cubeQueryTask) return;
    _cubeQueryTask.parent = null;
    $o.parent = this;
    var $old = _cubeQueryTask;
    _cubeQueryTask = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.cubeQueryTask_OP, $old, _cubeQueryTask));
    }
  }

  Rectangle get range => _range;

  set range(Rectangle $o) {
    if ($o == _range) return;
    _range.parent = null;
    $o.parent = this;
    var $old = _range;
    _range = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.range_OP, $old, _range));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.cubeQueryTask_OP:
        return cubeQueryTask;
      case Vocabulary.palettes_OP:
        return palettes;
      case Vocabulary.split_DP:
        return split;
      case Vocabulary.xCellResolution_DP:
        return xCellResolution;
      case Vocabulary.yCellResolution_DP:
        return yCellResolution;
      case Vocabulary.range_OP:
        return range;
      case Vocabulary.layer_DP:
        return layer;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.split_DP:
        split = $value as int;
        return;
      case Vocabulary.xCellResolution_DP:
        xCellResolution = $value as double;
        return;
      case Vocabulary.yCellResolution_DP:
        yCellResolution = $value as double;
        return;
      case Vocabulary.layer_DP:
        layer = $value as int;
        return;
      case Vocabulary.cubeQueryTask_OP:
        cubeQueryTask = $value as CubeQueryTask;
        return;
      case Vocabulary.palettes_OP:
        palettes.setValues($value as Iterable<Palette>);
        return;
      case Vocabulary.range_OP:
        range = $value as Rectangle;
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
  GlTask copy() => GlTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GlTask_CLASS;
    if (subKind != null && subKind != Vocabulary.GlTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.cubeQueryTask_OP] = cubeQueryTask.toJson();
    m[Vocabulary.palettes_OP] = palettes.toJson();
    m[Vocabulary.split_DP] = split;
    m[Vocabulary.xCellResolution_DP] = xCellResolution;
    m[Vocabulary.yCellResolution_DP] = yCellResolution;
    m[Vocabulary.range_OP] = range.toJson();
    m[Vocabulary.layer_DP] = layer;
    return m;
  }
}
