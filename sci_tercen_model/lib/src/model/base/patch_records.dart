part of sci_model_base;

class PatchRecordsBase extends Event {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.u_DP,
    Vocabulary.cI_DP,
    Vocabulary.oI_DP,
    Vocabulary.oR_DP,
    Vocabulary.oK_DP,
    Vocabulary.s_DP,
    Vocabulary.rs_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _u;
  String _cI;
  String _oI;
  String _oR;
  String _oK;
  int _s;
  final base.ListChanged<PatchRecord> rs;

  PatchRecordsBase()
      : _u = "",
        _cI = "",
        _oI = "",
        _oR = "",
        _oK = "",
        _s = 0,
        rs = base.ListChanged<PatchRecord>() {
    rs.parent = this;
  }

  PatchRecordsBase.json(Map m)
      : _u = base.defaultValue(
            m[Vocabulary.u_DP] as String?, base.String_DefaultFactory),
        _cI = base.defaultValue(
            m[Vocabulary.cI_DP] as String?, base.String_DefaultFactory),
        _oI = base.defaultValue(
            m[Vocabulary.oI_DP] as String?, base.String_DefaultFactory),
        _oR = base.defaultValue(
            m[Vocabulary.oR_DP] as String?, base.String_DefaultFactory),
        _oK = base.defaultValue(
            m[Vocabulary.oK_DP] as String?, base.String_DefaultFactory),
        _s = base.defaultValue(
            m[Vocabulary.s_DP] as int?, base.int_DefaultFactory),
        rs = base.ListChanged<PatchRecord>.from(
            m[Vocabulary.rs_OP] as List?, PatchRecordBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PatchRecords_CLASS, m);
    rs.parent = this;
  }

  static PatchRecords createFromJson(Map m) => PatchRecordsBase.fromJson(m);
  static PatchRecords _createFromJson(Map? m) =>
      m == null ? PatchRecords() : PatchRecordsBase.fromJson(m);
  static PatchRecords fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PatchRecords_CLASS:
        return PatchRecords.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PatchRecords_CLASS;
  String get u => _u;

  set u(String $o) {
    if ($o == _u) return;
    var $old = _u;
    _u = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.u_DP, $old, _u));
    }
  }

  String get cI => _cI;

  set cI(String $o) {
    if ($o == _cI) return;
    var $old = _cI;
    _cI = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.cI_DP, $old, _cI));
    }
  }

  String get oI => _oI;

  set oI(String $o) {
    if ($o == _oI) return;
    var $old = _oI;
    _oI = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.oI_DP, $old, _oI));
    }
  }

  String get oR => _oR;

  set oR(String $o) {
    if ($o == _oR) return;
    var $old = _oR;
    _oR = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.oR_DP, $old, _oR));
    }
  }

  String get oK => _oK;

  set oK(String $o) {
    if ($o == _oK) return;
    var $old = _oK;
    _oK = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.oK_DP, $old, _oK));
    }
  }

  int get s => _s;

  set s(int $o) {
    if ($o == _s) return;
    var $old = _s;
    _s = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.s_DP, $old, _s));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.u_DP:
        return u;
      case Vocabulary.cI_DP:
        return cI;
      case Vocabulary.oI_DP:
        return oI;
      case Vocabulary.oR_DP:
        return oR;
      case Vocabulary.oK_DP:
        return oK;
      case Vocabulary.s_DP:
        return s;
      case Vocabulary.rs_OP:
        return rs;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.u_DP:
        u = $value as String;
        return;
      case Vocabulary.cI_DP:
        cI = $value as String;
        return;
      case Vocabulary.oI_DP:
        oI = $value as String;
        return;
      case Vocabulary.oR_DP:
        oR = $value as String;
        return;
      case Vocabulary.oK_DP:
        oK = $value as String;
        return;
      case Vocabulary.s_DP:
        s = $value as int;
        return;
      case Vocabulary.rs_OP:
        rs.setValues($value as Iterable<PatchRecord>);
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
  PatchRecords copy() => PatchRecords.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PatchRecords_CLASS;
    if (subKind != null && subKind != Vocabulary.PatchRecords_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.u_DP] = u;
    m[Vocabulary.cI_DP] = cI;
    m[Vocabulary.oI_DP] = oI;
    m[Vocabulary.oR_DP] = oR;
    m[Vocabulary.oK_DP] = oK;
    m[Vocabulary.s_DP] = s;
    m[Vocabulary.rs_OP] = rs.toJson();
    return m;
  }
}
