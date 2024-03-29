part of sci_model_base;

class PortBase extends IdObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.linkType_DP,
    Vocabulary.name_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _linkType;
  String _name;

  PortBase()
      : _linkType = "",
        _name = "";
  PortBase.json(Map m)
      : _linkType = base.defaultValue(
            m[Vocabulary.linkType_DP] as String?, base.String_DefaultFactory),
        _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Port_CLASS, m);
  }

  static Port createFromJson(Map m) => PortBase.fromJson(m);
  static Port _createFromJson(Map? m) =>
      m == null ? Port() : PortBase.fromJson(m);
  static Port fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Port_CLASS:
        return Port.json(m);
      case Vocabulary.InputPort_CLASS:
        return InputPort.json(m);
      case Vocabulary.OutputPort_CLASS:
        return OutputPort.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Port_CLASS;
  String get linkType => _linkType;

  set linkType(String $o) {
    if ($o == _linkType) return;
    var $old = _linkType;
    _linkType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.linkType_DP, $old, _linkType));
    }
  }

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

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.linkType_DP:
        return linkType;
      case Vocabulary.name_DP:
        return name;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.linkType_DP:
        linkType = $value as String;
        return;
      case Vocabulary.name_DP:
        name = $value as String;
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
  Port copy() => Port.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Port_CLASS;
    if (subKind != null && subKind != Vocabulary.Port_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.linkType_DP] = linkType;
    m[Vocabulary.name_DP] = name;
    return m;
  }
}
