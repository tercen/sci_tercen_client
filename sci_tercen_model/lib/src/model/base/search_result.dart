part of sci_model_base;

class SearchResultBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.total_rows_DP,
    Vocabulary.bookmark_DP,
    Vocabulary.rows_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _total_rows;
  String _bookmark;
  final base.ListChanged<PersistentObject> rows;

  SearchResultBase()
      : _total_rows = 0,
        _bookmark = "",
        rows = base.ListChanged<PersistentObject>() {
    rows.parent = this;
  }

  SearchResultBase.json(Map m)
      : _total_rows = base.defaultValue(
            m[Vocabulary.total_rows_DP] as int?, base.int_DefaultFactory),
        _bookmark = base.defaultValue(
            m[Vocabulary.bookmark_DP] as String?, base.String_DefaultFactory),
        rows = base.ListChanged<PersistentObject>.from(
            m[Vocabulary.rows_OP] as List?,
            PersistentObjectBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.SearchResult_CLASS, m);
    rows.parent = this;
  }

  static SearchResult createFromJson(Map m) => SearchResultBase.fromJson(m);
  static SearchResult _createFromJson(Map? m) =>
      m == null ? SearchResult() : SearchResultBase.fromJson(m);
  static SearchResult fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.SearchResult_CLASS:
        return SearchResult.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.SearchResult_CLASS;
  int get total_rows => _total_rows;

  set total_rows(int $o) {
    if ($o == _total_rows) return;
    var $old = _total_rows;
    _total_rows = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.total_rows_DP, $old, _total_rows));
    }
  }

  String get bookmark => _bookmark;

  set bookmark(String $o) {
    if ($o == _bookmark) return;
    var $old = _bookmark;
    _bookmark = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.bookmark_DP, $old, _bookmark));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.total_rows_DP:
        return total_rows;
      case Vocabulary.bookmark_DP:
        return bookmark;
      case Vocabulary.rows_OP:
        return rows;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.total_rows_DP:
        total_rows = $value as int;
        return;
      case Vocabulary.bookmark_DP:
        bookmark = $value as String;
        return;
      case Vocabulary.rows_OP:
        rows.setValues($value as Iterable<PersistentObject>);
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
  SearchResult copy() => SearchResult.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.SearchResult_CLASS;
    if (subKind != null && subKind != Vocabulary.SearchResult_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.total_rows_DP] = total_rows;
    m[Vocabulary.bookmark_DP] = bookmark;
    m[Vocabulary.rows_OP] = rows.toJson();
    return m;
  }
}
