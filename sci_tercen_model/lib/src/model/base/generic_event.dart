part of sci_model_base;

class GenericEventBase extends Event {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.type_DP,
    Vocabulary.content_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _type;
  String _content;

  GenericEventBase()
      : _type = "",
        _content = "";
  GenericEventBase.json(Map m)
      : _type = base.defaultValue(
            m[Vocabulary.type_DP] as String?, base.String_DefaultFactory),
        _content = base.defaultValue(
            m[Vocabulary.content_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GenericEvent_CLASS, m);
  }

  static GenericEvent createFromJson(Map m) => GenericEventBase.fromJson(m);
  static GenericEvent fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GenericEvent_CLASS:
        return GenericEvent.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GenericEvent_CLASS;
  String get type => _type;

  set type(String $o) {
    if ($o == _type) return;
    var $old = _type;
    _type = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.type_DP, $old, _type));
    }
  }

  String get content => _content;

  set content(String $o) {
    if ($o == _content) return;
    var $old = _content;
    _content = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.content_DP, $old, _content));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.type_DP:
        return type;
      case Vocabulary.content_DP:
        return content;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.type_DP:
        type = $value as String;
        return;
      case Vocabulary.content_DP:
        content = $value as String;
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
  GenericEvent copy() => GenericEvent.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GenericEvent_CLASS;
    if (subKind != null && subKind != Vocabulary.GenericEvent_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.type_DP] = type;
    m[Vocabulary.content_DP] = content;
    return m;
  }
}
