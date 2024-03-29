part of sci_model_base;

class ColorElementBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.color_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _color;

  ColorElementBase() : _color = 0;
  ColorElementBase.json(Map m)
      : _color = base.defaultValue(
            m[Vocabulary.color_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ColorElement_CLASS, m);
  }

  static ColorElement createFromJson(Map m) => ColorElementBase.fromJson(m);
  static ColorElement _createFromJson(Map? m) =>
      m == null ? ColorElement() : ColorElementBase.fromJson(m);
  static ColorElement fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ColorElement_CLASS:
        return ColorElement.json(m);
      case Vocabulary.DoubleColorElement_CLASS:
        return DoubleColorElement.json(m);
      case Vocabulary.StringColorElement_CLASS:
        return StringColorElement.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ColorElement_CLASS;
  int get color => _color;

  set color(int $o) {
    if ($o == _color) return;
    var $old = _color;
    _color = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.color_DP, $old, _color));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.color_DP:
        return color;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.color_DP:
        color = $value as int;
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
  ColorElement copy() => ColorElement.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ColorElement_CLASS;
    if (subKind != null && subKind != Vocabulary.ColorElement_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.color_DP] = color;
    return m;
  }
}
