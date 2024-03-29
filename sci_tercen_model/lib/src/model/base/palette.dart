part of sci_model_base;

class PaletteBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.backcolor_DP,
    Vocabulary.properties_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _backcolor;
  final base.ListChanged<PropertyValue> properties;

  PaletteBase()
      : _backcolor = 0,
        properties = base.ListChanged<PropertyValue>() {
    properties.parent = this;
  }

  PaletteBase.json(Map m)
      : _backcolor = base.defaultValue(
            m[Vocabulary.backcolor_DP] as int?, base.int_DefaultFactory),
        properties = base.ListChanged<PropertyValue>.from(
            m[Vocabulary.properties_OP] as List?,
            PropertyValueBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Palette_CLASS, m);
    properties.parent = this;
  }

  static Palette createFromJson(Map m) => PaletteBase.fromJson(m);
  static Palette _createFromJson(Map? m) =>
      m == null ? Palette() : PaletteBase.fromJson(m);
  static Palette fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Palette_CLASS:
        return Palette.json(m);
      case Vocabulary.JetPalette_CLASS:
        return JetPalette.json(m);
      case Vocabulary.RampPalette_CLASS:
        return RampPalette.json(m);
      case Vocabulary.CategoryPalette_CLASS:
        return CategoryPalette.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Palette_CLASS;
  int get backcolor => _backcolor;

  set backcolor(int $o) {
    if ($o == _backcolor) return;
    var $old = _backcolor;
    _backcolor = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.backcolor_DP, $old, _backcolor));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.backcolor_DP:
        return backcolor;
      case Vocabulary.properties_OP:
        return properties;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.backcolor_DP:
        backcolor = $value as int;
        return;
      case Vocabulary.properties_OP:
        properties.setValues($value as Iterable<PropertyValue>);
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
  Palette copy() => Palette.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Palette_CLASS;
    if (subKind != null && subKind != Vocabulary.Palette_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.backcolor_DP] = backcolor;
    m[Vocabulary.properties_OP] = properties.toJson();
    return m;
  }
}
