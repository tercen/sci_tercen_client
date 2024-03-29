part of sci_model_base;

class TableProfileBase extends Profile {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.nRows_DP,
    Vocabulary.nCols_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _nRows;
  int _nCols;

  TableProfileBase()
      : _nRows = 0,
        _nCols = 0;
  TableProfileBase.json(Map m)
      : _nRows = base.defaultValue(
            m[Vocabulary.nRows_DP] as int?, base.int_DefaultFactory),
        _nCols = base.defaultValue(
            m[Vocabulary.nCols_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TableProfile_CLASS, m);
  }

  static TableProfile createFromJson(Map m) => TableProfileBase.fromJson(m);
  static TableProfile _createFromJson(Map? m) =>
      m == null ? TableProfile() : TableProfileBase.fromJson(m);
  static TableProfile fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TableProfile_CLASS:
        return TableProfile.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TableProfile_CLASS;
  int get nRows => _nRows;

  set nRows(int $o) {
    if ($o == _nRows) return;
    var $old = _nRows;
    _nRows = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nRows_DP, $old, _nRows));
    }
  }

  int get nCols => _nCols;

  set nCols(int $o) {
    if ($o == _nCols) return;
    var $old = _nCols;
    _nCols = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nCols_DP, $old, _nCols));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.nRows_DP:
        return nRows;
      case Vocabulary.nCols_DP:
        return nCols;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.nRows_DP:
        nRows = $value as int;
        return;
      case Vocabulary.nCols_DP:
        nCols = $value as int;
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
  TableProfile copy() => TableProfile.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TableProfile_CLASS;
    if (subKind != null && subKind != Vocabulary.TableProfile_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.nRows_DP] = nRows;
    m[Vocabulary.nCols_DP] = nCols;
    return m;
  }
}
