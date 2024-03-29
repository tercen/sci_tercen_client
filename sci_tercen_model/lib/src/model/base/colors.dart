part of sci_model_base;

class ColorsBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.factors_OP,
    Vocabulary.palette_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Factor> factors;
  Palette _palette;

  ColorsBase()
      : factors = base.ListChanged<Factor>(),
        _palette = Palette() {
    factors.parent = this;
    _palette.parent = this;
  }

  ColorsBase.json(Map m)
      : factors = base.ListChanged<Factor>.from(
            m[Vocabulary.factors_OP] as List?, FactorBase.createFromJson),
        _palette =
            PaletteBase._createFromJson(m[Vocabulary.palette_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Colors_CLASS, m);
    factors.parent = this;
    _palette.parent = this;
  }

  static Colors createFromJson(Map m) => ColorsBase.fromJson(m);
  static Colors _createFromJson(Map? m) =>
      m == null ? Colors() : ColorsBase.fromJson(m);
  static Colors fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Colors_CLASS:
        return Colors.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Colors_CLASS;
  Palette get palette => _palette;

  set palette(Palette $o) {
    if ($o == _palette) return;
    _palette.parent = null;
    $o.parent = this;
    var $old = _palette;
    _palette = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.palette_OP, $old, _palette));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.factors_OP:
        return factors;
      case Vocabulary.palette_OP:
        return palette;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.factors_OP:
        factors.setValues($value as Iterable<Factor>);
        return;
      case Vocabulary.palette_OP:
        palette = $value as Palette;
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
  Colors copy() => Colors.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Colors_CLASS;
    if (subKind != null && subKind != Vocabulary.Colors_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.factors_OP] = factors.toJson();
    m[Vocabulary.palette_OP] = palette.toJson();
    return m;
  }
}
