part of sci_model_base;

class ApiCallProfileBase extends Profile {
  static const List<String> PROPERTY_NAMES = [Vocabulary.nCalls_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _nCalls;

  ApiCallProfileBase() : _nCalls = 0;
  ApiCallProfileBase.json(Map m)
      : _nCalls = base.defaultValue(
            m[Vocabulary.nCalls_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ApiCallProfile_CLASS, m);
  }

  static ApiCallProfile createFromJson(Map m) => ApiCallProfileBase.fromJson(m);
  static ApiCallProfile _createFromJson(Map? m) =>
      m == null ? ApiCallProfile() : ApiCallProfileBase.fromJson(m);
  static ApiCallProfile fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ApiCallProfile_CLASS:
        return ApiCallProfile.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ApiCallProfile_CLASS;
  int get nCalls => _nCalls;

  set nCalls(int $o) {
    if ($o == _nCalls) return;
    var $old = _nCalls;
    _nCalls = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nCalls_DP, $old, _nCalls));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.nCalls_DP:
        return nCalls;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.nCalls_DP:
        nCalls = $value as int;
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
  ApiCallProfile copy() => ApiCallProfile.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ApiCallProfile_CLASS;
    if (subKind != null && subKind != Vocabulary.ApiCallProfile_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.nCalls_DP] = nCalls;
    return m;
  }
}
