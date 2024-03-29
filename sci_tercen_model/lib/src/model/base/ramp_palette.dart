part of sci_model_base;

class RampPaletteBase extends Palette {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.isUserDefined_DP,
    Vocabulary.doubleColorElements_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  bool _isUserDefined;
  final base.ListChanged<DoubleColorElement> doubleColorElements;

  RampPaletteBase()
      : _isUserDefined = true,
        doubleColorElements = base.ListChanged<DoubleColorElement>() {
    doubleColorElements.parent = this;
  }

  RampPaletteBase.json(Map m)
      : _isUserDefined = base.defaultValue(
            m[Vocabulary.isUserDefined_DP] as bool?, base.bool_DefaultFactory),
        doubleColorElements = base.ListChanged<DoubleColorElement>.from(
            m[Vocabulary.doubleColorElements_OP] as List?,
            DoubleColorElementBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RampPalette_CLASS, m);
    doubleColorElements.parent = this;
  }

  static RampPalette createFromJson(Map m) => RampPaletteBase.fromJson(m);
  static RampPalette _createFromJson(Map? m) =>
      m == null ? RampPalette() : RampPaletteBase.fromJson(m);
  static RampPalette fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RampPalette_CLASS:
        return RampPalette.json(m);
      case Vocabulary.JetPalette_CLASS:
        return JetPalette.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RampPalette_CLASS;
  bool get isUserDefined => _isUserDefined;

  set isUserDefined(bool $o) {
    if ($o == _isUserDefined) return;
    var $old = _isUserDefined;
    _isUserDefined = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isUserDefined_DP, $old, _isUserDefined));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.isUserDefined_DP:
        return isUserDefined;
      case Vocabulary.doubleColorElements_OP:
        return doubleColorElements;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.isUserDefined_DP:
        isUserDefined = $value as bool;
        return;
      case Vocabulary.doubleColorElements_OP:
        doubleColorElements.setValues($value as Iterable<DoubleColorElement>);
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
  RampPalette copy() => RampPalette.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RampPalette_CLASS;
    if (subKind != null && subKind != Vocabulary.RampPalette_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.isUserDefined_DP] = isUserDefined;
    m[Vocabulary.doubleColorElements_OP] = doubleColorElements.toJson();
    return m;
  }
}
