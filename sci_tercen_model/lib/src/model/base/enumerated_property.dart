part of sci_model_base;

class EnumeratedPropertyBase extends StringProperty {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.isSingleSelection_DP,
    Vocabulary.values_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  bool _isSingleSelection;
  final base.ListChangedBase<String> values;

  EnumeratedPropertyBase()
      : _isSingleSelection = true,
        values = base.ListChangedBase<String>() {
    values.parent = this;
  }

  EnumeratedPropertyBase.json(Map m)
      : _isSingleSelection = base.defaultValue(
            m[Vocabulary.isSingleSelection_DP] as bool?,
            base.bool_DefaultFactory),
        values = base.ListChangedBase<String>(m[Vocabulary.values_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.EnumeratedProperty_CLASS, m);
    values.parent = this;
  }

  static EnumeratedProperty createFromJson(Map m) =>
      EnumeratedPropertyBase.fromJson(m);
  static EnumeratedProperty _createFromJson(Map? m) =>
      m == null ? EnumeratedProperty() : EnumeratedPropertyBase.fromJson(m);
  static EnumeratedProperty fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.EnumeratedProperty_CLASS:
        return EnumeratedProperty.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.EnumeratedProperty_CLASS;
  bool get isSingleSelection => _isSingleSelection;

  set isSingleSelection(bool $o) {
    if ($o == _isSingleSelection) return;
    var $old = _isSingleSelection;
    _isSingleSelection = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isSingleSelection_DP, $old, _isSingleSelection));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.isSingleSelection_DP:
        return isSingleSelection;
      case Vocabulary.values_DP:
        return values;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.isSingleSelection_DP:
        isSingleSelection = $value as bool;
        return;
      case Vocabulary.values_DP:
        values.setValues($value as Iterable<String>);
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
  EnumeratedProperty copy() => EnumeratedProperty.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.EnumeratedProperty_CLASS;
    if (subKind != null && subKind != Vocabulary.EnumeratedProperty_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.isSingleSelection_DP] = isSingleSelection;
    m[Vocabulary.values_DP] = values;
    return m;
  }
}
