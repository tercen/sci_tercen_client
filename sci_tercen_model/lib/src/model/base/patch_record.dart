part of sci_model_base;

class PatchRecordBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.p_DP,
    Vocabulary.t_DP,
    Vocabulary.d_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _p;
  String _t;
  String _d;

  PatchRecordBase()
      : _p = "",
        _t = "",
        _d = "";
  PatchRecordBase.json(Map m)
      : _p = base.defaultValue(
            m[Vocabulary.p_DP] as String?, base.String_DefaultFactory),
        _t = base.defaultValue(
            m[Vocabulary.t_DP] as String?, base.String_DefaultFactory),
        _d = base.defaultValue(
            m[Vocabulary.d_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PatchRecord_CLASS, m);
  }

  static PatchRecord createFromJson(Map m) => PatchRecordBase.fromJson(m);
  static PatchRecord _createFromJson(Map? m) =>
      m == null ? PatchRecord() : PatchRecordBase.fromJson(m);
  static PatchRecord fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PatchRecord_CLASS:
        return PatchRecord.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PatchRecord_CLASS;
  String get p => _p;

  set p(String $o) {
    if ($o == _p) return;
    var $old = _p;
    _p = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.p_DP, $old, _p));
    }
  }

  String get t => _t;

  set t(String $o) {
    if ($o == _t) return;
    var $old = _t;
    _t = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.t_DP, $old, _t));
    }
  }

  String get d => _d;

  set d(String $o) {
    if ($o == _d) return;
    var $old = _d;
    _d = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.d_DP, $old, _d));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.p_DP:
        return p;
      case Vocabulary.t_DP:
        return t;
      case Vocabulary.d_DP:
        return d;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.p_DP:
        p = $value as String;
        return;
      case Vocabulary.t_DP:
        t = $value as String;
        return;
      case Vocabulary.d_DP:
        d = $value as String;
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
  PatchRecord copy() => PatchRecord.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PatchRecord_CLASS;
    if (subKind != null && subKind != Vocabulary.PatchRecord_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.p_DP] = p;
    m[Vocabulary.t_DP] = t;
    m[Vocabulary.d_DP] = d;
    return m;
  }
}
