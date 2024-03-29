part of sci_model_base;

class CategoryPaletteBase extends Palette {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.colorList_OP,
    Vocabulary.stringColorElements_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  ColorList _colorList;
  final base.ListChanged<StringColorElement> stringColorElements;

  CategoryPaletteBase()
      : _colorList = ColorList(),
        stringColorElements = base.ListChanged<StringColorElement>() {
    _colorList.parent = this;
    stringColorElements.parent = this;
  }

  CategoryPaletteBase.json(Map m)
      : _colorList =
            ColorListBase._createFromJson(m[Vocabulary.colorList_OP] as Map?),
        stringColorElements = base.ListChanged<StringColorElement>.from(
            m[Vocabulary.stringColorElements_OP] as List?,
            StringColorElementBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CategoryPalette_CLASS, m);
    _colorList.parent = this;
    stringColorElements.parent = this;
  }

  static CategoryPalette createFromJson(Map m) =>
      CategoryPaletteBase.fromJson(m);
  static CategoryPalette _createFromJson(Map? m) =>
      m == null ? CategoryPalette() : CategoryPaletteBase.fromJson(m);
  static CategoryPalette fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CategoryPalette_CLASS:
        return CategoryPalette.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CategoryPalette_CLASS;
  ColorList get colorList => _colorList;

  set colorList(ColorList $o) {
    if ($o == _colorList) return;
    _colorList.parent = null;
    $o.parent = this;
    var $old = _colorList;
    _colorList = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.colorList_OP, $old, _colorList));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.colorList_OP:
        return colorList;
      case Vocabulary.stringColorElements_OP:
        return stringColorElements;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.colorList_OP:
        colorList = $value as ColorList;
        return;
      case Vocabulary.stringColorElements_OP:
        stringColorElements.setValues($value as Iterable<StringColorElement>);
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
  CategoryPalette copy() => CategoryPalette.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CategoryPalette_CLASS;
    if (subKind != null && subKind != Vocabulary.CategoryPalette_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.colorList_OP] = colorList.toJson();
    m[Vocabulary.stringColorElements_OP] = stringColorElements.toJson();
    return m;
  }
}
