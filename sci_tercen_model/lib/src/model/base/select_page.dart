part of sci_model_base;

class SelectPageBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.table_OP,
    Vocabulary.nextCursor_DP,
    Vocabulary.oversized_DP,
    Vocabulary.bytes_DP,
    Vocabulary.rows_DP,
    Vocabulary.certainty_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  static const List<base.PropertyConstraint> CONSTRAINTS = [];
  Table _table;
  String _nextCursor;
  bool _oversized;
  int _bytes;
  int _rows;
  String _certainty;

  SelectPageBase()
      : _nextCursor = "",
        _oversized = true,
        _bytes = 0,
        _rows = 0,
        _certainty = "",
        _table = Table() {
    _table.parent = this;
  }

  SelectPageBase.json(Map m)
      : _nextCursor = base.defaultValue(
            m[Vocabulary.nextCursor_DP] as String?, base.String_DefaultFactory),
        _oversized = base.defaultValue(
            m[Vocabulary.oversized_DP] as bool?, base.bool_DefaultFactory),
        _bytes = base.defaultValue(
            m[Vocabulary.bytes_DP] as int?, base.int_DefaultFactory),
        _rows = base.defaultValue(
            m[Vocabulary.rows_DP] as int?, base.int_DefaultFactory),
        _certainty = base.defaultValue(
            m[Vocabulary.certainty_DP] as String?, base.String_DefaultFactory),
        _table = (m[Vocabulary.table_OP] as Map?) == null
            ? Table()
            : TableBase.fromJson(m[Vocabulary.table_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.SelectPage_CLASS, m);
    _table.parent = this;
  }

  static SelectPage createFromJson(Map m) => SelectPageBase.fromJson(m);
  static SelectPage fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.SelectPage_CLASS:
        return SelectPage.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.SelectPage_CLASS;
  String get nextCursor => _nextCursor;

  set nextCursor(String $o) {
    if ($o == _nextCursor) return;
    var $old = _nextCursor;
    _nextCursor = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.nextCursor_DP, $old, _nextCursor));
    }
  }

  bool get oversized => _oversized;

  set oversized(bool $o) {
    if ($o == _oversized) return;
    var $old = _oversized;
    _oversized = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.oversized_DP, $old, _oversized));
    }
  }

  int get bytes => _bytes;

  set bytes(int $o) {
    if ($o == _bytes) return;
    var $old = _bytes;
    _bytes = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.bytes_DP, $old, _bytes));
    }
  }

  int get rows => _rows;

  set rows(int $o) {
    if ($o == _rows) return;
    var $old = _rows;
    _rows = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.rows_DP, $old, _rows));
    }
  }

  String get certainty => _certainty;

  set certainty(String $o) {
    if ($o == _certainty) return;
    var $old = _certainty;
    _certainty = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.certainty_DP, $old, _certainty));
    }
  }

  Table get table => _table;

  set table(Table $o) {
    if ($o == _table) return;
    _table.parent = null;
    $o.parent = this;
    var $old = _table;
    _table = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.table_OP, $old, _table));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.table_OP:
        return table;
      case Vocabulary.nextCursor_DP:
        return nextCursor;
      case Vocabulary.oversized_DP:
        return oversized;
      case Vocabulary.bytes_DP:
        return bytes;
      case Vocabulary.rows_DP:
        return rows;
      case Vocabulary.certainty_DP:
        return certainty;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.nextCursor_DP:
        nextCursor = $value as String;
        return;
      case Vocabulary.oversized_DP:
        oversized = $value as bool;
        return;
      case Vocabulary.bytes_DP:
        bytes = $value as int;
        return;
      case Vocabulary.rows_DP:
        rows = $value as int;
        return;
      case Vocabulary.certainty_DP:
        certainty = $value as String;
        return;
      case Vocabulary.table_OP:
        table = $value as Table;
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
  Iterable<base.PropertyConstraint> constraints() =>
      super.constraints().followedBy(CONSTRAINTS);

  @override
  SelectPage copy() => SelectPage.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.SelectPage_CLASS;
    if (subKind != null && subKind != Vocabulary.SelectPage_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.table_OP] = table.toJson();
    m[Vocabulary.nextCursor_DP] = nextCursor;
    m[Vocabulary.oversized_DP] = oversized;
    m[Vocabulary.bytes_DP] = bytes;
    m[Vocabulary.rows_DP] = rows;
    m[Vocabulary.certainty_DP] = certainty;
    return m;
  }
}
