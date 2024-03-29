part of sci_model_base;

class PropertyBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.description_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  String _description;

  PropertyBase()
      : _name = "",
        _description = "";
  PropertyBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _description = base.defaultValue(
            m[Vocabulary.description_DP] as String?,
            base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Property_CLASS, m);
  }

  static Property createFromJson(Map m) => PropertyBase.fromJson(m);
  static Property _createFromJson(Map? m) =>
      m == null ? Property() : PropertyBase.fromJson(m);
  static Property fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Property_CLASS:
        return Property.json(m);
      case Vocabulary.EnumeratedProperty_CLASS:
        return EnumeratedProperty.json(m);
      case Vocabulary.FactorsProperty_CLASS:
        return FactorsProperty.json(m);
      case Vocabulary.FormulaProperty_CLASS:
        return FormulaProperty.json(m);
      case Vocabulary.DoubleProperty_CLASS:
        return DoubleProperty.json(m);
      case Vocabulary.StringProperty_CLASS:
        return StringProperty.json(m);
      case Vocabulary.BooleanProperty_CLASS:
        return BooleanProperty.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Property_CLASS;
  String get name => _name;

  set name(String $o) {
    if ($o == _name) return;
    var $old = _name;
    _name = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.name_DP, $old, _name));
    }
  }

  String get description => _description;

  set description(String $o) {
    if ($o == _description) return;
    var $old = _description;
    _description = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.description_DP, $old, _description));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.description_DP:
        return description;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.description_DP:
        description = $value as String;
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
  Property copy() => Property.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Property_CLASS;
    if (subKind != null && subKind != Vocabulary.Property_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.description_DP] = description;
    return m;
  }
}
