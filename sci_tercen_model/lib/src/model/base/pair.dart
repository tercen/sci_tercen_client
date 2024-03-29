part of sci_model_base;

class PairBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.key_DP,
    Vocabulary.value_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _key;
  String _value;

  PairBase()
      : _key = "",
        _value = "";
  PairBase.json(Map m)
      : _key = base.defaultValue(
            m[Vocabulary.key_DP] as String?, base.String_DefaultFactory),
        _value = base.defaultValue(
            m[Vocabulary.value_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Pair_CLASS, m);
  }

  static Pair createFromJson(Map m) => PairBase.fromJson(m);
  static Pair _createFromJson(Map? m) =>
      m == null ? Pair() : PairBase.fromJson(m);
  static Pair fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Pair_CLASS:
        return Pair.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Pair_CLASS;
  String get key => _key;

  set key(String $o) {
    if ($o == _key) return;
    var $old = _key;
    _key = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.key_DP, $old, _key));
    }
  }

  String get value => _value;

  set value(String $o) {
    if ($o == _value) return;
    var $old = _value;
    _value = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.value_DP, $old, _value));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.key_DP:
        return key;
      case Vocabulary.value_DP:
        return value;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.key_DP:
        key = $value as String;
        return;
      case Vocabulary.value_DP:
        value = $value as String;
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
  Pair copy() => Pair.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Pair_CLASS;
    if (subKind != null && subKind != Vocabulary.Pair_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.key_DP] = key;
    m[Vocabulary.value_DP] = value;
    return m;
  }
}
