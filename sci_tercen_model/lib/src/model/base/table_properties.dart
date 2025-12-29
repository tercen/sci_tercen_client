part of sci_model_base;

class TablePropertiesBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.sortOrder_DP,
    Vocabulary.ascending_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  final base.ListChangedBase<String> sortOrder;
  bool _ascending;

  TablePropertiesBase()
      : _name = "",
        sortOrder = base.ListChangedBase<String>(),
        _ascending = true {
    sortOrder.parent = this;
  }

  TablePropertiesBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        sortOrder =
            base.ListChangedBase<String>(m[Vocabulary.sortOrder_DP] as List?),
        _ascending = base.defaultValue(
            m[Vocabulary.ascending_DP] as bool?, base.bool_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TableProperties_CLASS, m);
    sortOrder.parent = this;
  }

  static TableProperties createFromJson(Map m) =>
      TablePropertiesBase.fromJson(m);
  static TableProperties fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TableProperties_CLASS:
        return TableProperties.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TableProperties_CLASS;
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

  bool get ascending => _ascending;

  set ascending(bool $o) {
    if ($o == _ascending) return;
    var $old = _ascending;
    _ascending = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.ascending_DP, $old, _ascending));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.sortOrder_DP:
        return sortOrder;
      case Vocabulary.ascending_DP:
        return ascending;
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
      case Vocabulary.sortOrder_DP:
        sortOrder.setValues($value as Iterable<String>);
        return;
      case Vocabulary.ascending_DP:
        ascending = $value as bool;
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
  TableProperties copy() => TableProperties.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TableProperties_CLASS;
    if (subKind != null && subKind != Vocabulary.TableProperties_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.sortOrder_DP] = sortOrder;
    m[Vocabulary.ascending_DP] = ascending;
    return m;
  }
}
