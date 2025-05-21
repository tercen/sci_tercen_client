part of sci_model_base;

class FileSummaryBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.n_DP,
    Vocabulary.size_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _n;
  int _size;

  FileSummaryBase()
      : _n = 0,
        _size = 0;
  FileSummaryBase.json(Map m)
      : _n = base.defaultValue(
            m[Vocabulary.n_DP] as int?, base.int_DefaultFactory),
        _size = base.defaultValue(
            m[Vocabulary.size_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FileSummary_CLASS, m);
  }

  static FileSummary createFromJson(Map m) => FileSummaryBase.fromJson(m);
  static FileSummary _createFromJson(Map? m) =>
      m == null ? FileSummary() : FileSummaryBase.fromJson(m);
  static FileSummary fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FileSummary_CLASS:
        return FileSummary.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FileSummary_CLASS;
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

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.n_DP:
        return n;
      case Vocabulary.size_DP:
        return size;
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
  FileSummary copy() => FileSummary.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FileSummary_CLASS;
    if (subKind != null && subKind != Vocabulary.FileSummary_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.n_DP] = n;
    m[Vocabulary.size_DP] = size;
    return m;
  }
}
