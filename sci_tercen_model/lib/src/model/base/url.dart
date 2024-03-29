part of sci_model_base;

class UrlBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.uri_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _uri;

  UrlBase() : _uri = "";
  UrlBase.json(Map m)
      : _uri = base.defaultValue(
            m[Vocabulary.uri_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Url_CLASS, m);
  }

  static Url createFromJson(Map m) => UrlBase.fromJson(m);
  static Url _createFromJson(Map? m) => m == null ? Url() : UrlBase.fromJson(m);
  static Url fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Url_CLASS:
        return Url.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Url_CLASS;
  String get uri => _uri;

  set uri(String $o) {
    if ($o == _uri) return;
    var $old = _uri;
    _uri = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.uri_DP, $old, _uri));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.uri_DP:
        return uri;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.uri_DP:
        uri = $value as String;
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
  Url copy() => Url.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Url_CLASS;
    if (subKind != null && subKind != Vocabulary.Url_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.uri_DP] = uri;
    return m;
  }
}
