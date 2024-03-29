part of sci_model_base;

class TableSummaryBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.n_DP,
    Vocabulary.size_DP,
    Vocabulary.nr_DP,
    Vocabulary.nc_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _n;
  int _size;
  int _nr;
  int _nc;

  TableSummaryBase()
      : _n = 0,
        _size = 0,
        _nr = 0,
        _nc = 0;
  TableSummaryBase.json(Map m)
      : _n = base.defaultValue(
            m[Vocabulary.n_DP] as int?, base.int_DefaultFactory),
        _size = base.defaultValue(
            m[Vocabulary.size_DP] as int?, base.int_DefaultFactory),
        _nr = base.defaultValue(
            m[Vocabulary.nr_DP] as int?, base.int_DefaultFactory),
        _nc = base.defaultValue(
            m[Vocabulary.nc_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TableSummary_CLASS, m);
  }

  static TableSummary createFromJson(Map m) => TableSummaryBase.fromJson(m);
  static TableSummary _createFromJson(Map? m) =>
      m == null ? TableSummary() : TableSummaryBase.fromJson(m);
  static TableSummary fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TableSummary_CLASS:
        return TableSummary.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TableSummary_CLASS;
  int get n => _n;

  set n(int $o) {
    if ($o == _n) return;
    var $old = _n;
    _n = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.n_DP, $old, _n));
    }
  }

  int get size => _size;

  set size(int $o) {
    if ($o == _size) return;
    var $old = _size;
    _size = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.size_DP, $old, _size));
    }
  }

  int get nr => _nr;

  set nr(int $o) {
    if ($o == _nr) return;
    var $old = _nr;
    _nr = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nr_DP, $old, _nr));
    }
  }

  int get nc => _nc;

  set nc(int $o) {
    if ($o == _nc) return;
    var $old = _nc;
    _nc = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.nc_DP, $old, _nc));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.n_DP:
        return n;
      case Vocabulary.size_DP:
        return size;
      case Vocabulary.nr_DP:
        return nr;
      case Vocabulary.nc_DP:
        return nc;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.n_DP:
        n = $value as int;
        return;
      case Vocabulary.size_DP:
        size = $value as int;
        return;
      case Vocabulary.nr_DP:
        nr = $value as int;
        return;
      case Vocabulary.nc_DP:
        nc = $value as int;
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
  TableSummary copy() => TableSummary.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TableSummary_CLASS;
    if (subKind != null && subKind != Vocabulary.TableSummary_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.n_DP] = n;
    m[Vocabulary.size_DP] = size;
    m[Vocabulary.nr_DP] = nr;
    m[Vocabulary.nc_DP] = nc;
    return m;
  }
}
