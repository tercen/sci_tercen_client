part of sci_model_base;

class RProxyBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.targetUrl_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  String _targetUrl;

  RProxyBase()
      : _name = "",
        _targetUrl = "";
  RProxyBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _targetUrl = base.defaultValue(
            m[Vocabulary.targetUrl_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RProxy_CLASS, m);
  }

  static RProxy createFromJson(Map m) => RProxyBase.fromJson(m);
  static RProxy _createFromJson(Map? m) =>
      m == null ? RProxy() : RProxyBase.fromJson(m);
  static RProxy fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RProxy_CLASS:
        return RProxy.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RProxy_CLASS;
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

  String get targetUrl => _targetUrl;

  set targetUrl(String $o) {
    if ($o == _targetUrl) return;
    var $old = _targetUrl;
    _targetUrl = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.targetUrl_DP, $old, _targetUrl));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.targetUrl_DP:
        return targetUrl;
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
      case Vocabulary.targetUrl_DP:
        targetUrl = $value as String;
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
  RProxy copy() => RProxy.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RProxy_CLASS;
    if (subKind != null && subKind != Vocabulary.RProxy_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.targetUrl_DP] = targetUrl;
    return m;
  }
}
