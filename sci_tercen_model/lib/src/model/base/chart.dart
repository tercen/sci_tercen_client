part of sci_model_base;

class ChartBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.properties_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  Properties _properties;

  ChartBase()
      : _name = "",
        _properties = Properties() {
    _properties.parent = this;
  }

  ChartBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _properties = (m[Vocabulary.properties_OP] as Map?) == null
            ? Properties()
            : PropertiesBase.fromJson(m[Vocabulary.properties_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Chart_CLASS, m);
    _properties.parent = this;
  }

  static Chart createFromJson(Map m) => ChartBase.fromJson(m);
  static Chart fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Chart_CLASS:
        return Chart.json(m);
      case Vocabulary.ChartLine_CLASS:
        return ChartLine.json(m);
      case Vocabulary.ChartPoint_CLASS:
        return ChartPoint.json(m);
      case Vocabulary.ChartHeatmap_CLASS:
        return ChartHeatmap.json(m);
      case Vocabulary.ChartBar_CLASS:
        return ChartBar.json(m);
      case Vocabulary.ChartSize_CLASS:
        return ChartSize.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Chart_CLASS;
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

  Properties get properties => _properties;

  set properties(Properties $o) {
    if ($o == _properties) return;
    _properties.parent = null;
    $o.parent = this;
    var $old = _properties;
    _properties = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.properties_OP, $old, _properties));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.properties_OP:
        return properties;
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
      case Vocabulary.properties_OP:
        properties = $value as Properties;
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
  Chart copy() => Chart.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Chart_CLASS;
    if (subKind != null && subKind != Vocabulary.Chart_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.properties_OP] = properties.toJson();
    return m;
  }
}
