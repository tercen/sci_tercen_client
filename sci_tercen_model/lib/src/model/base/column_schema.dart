part of sci_model_base;

class ColumnSchemaBase extends IdObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.name_DP,
    Vocabulary.type_DP,
    Vocabulary.nRows_DP,
    Vocabulary.size_DP,
    Vocabulary.metaData_OP,
    Vocabulary.storageSize_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _name;
  String _type;
  int _nRows;
  int _size;
  ColumnSchemaMetaData _metaData;
  double _storageSize;

  ColumnSchemaBase()
      : _name = "",
        _type = "",
        _nRows = 0,
        _size = 0,
        _storageSize = 0.0,
        _metaData = ColumnSchemaMetaData() {
    _metaData.parent = this;
  }

  ColumnSchemaBase.json(Map m)
      : _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _type = base.defaultValue(
            m[Vocabulary.type_DP] as String?, base.String_DefaultFactory),
        _nRows = base.defaultValue(
            m[Vocabulary.nRows_DP] as int?, base.int_DefaultFactory),
        _size = base.defaultValue(
            m[Vocabulary.size_DP] as int?, base.int_DefaultFactory),
        _storageSize = base.defaultDouble(m[Vocabulary.storageSize_DP] as num?),
        _metaData = ColumnSchemaMetaDataBase._createFromJson(
            m[Vocabulary.metaData_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ColumnSchema_CLASS, m);
    _metaData.parent = this;
  }

  static ColumnSchema createFromJson(Map m) => ColumnSchemaBase.fromJson(m);
  static ColumnSchema _createFromJson(Map? m) =>
      m == null ? ColumnSchema() : ColumnSchemaBase.fromJson(m);
  static ColumnSchema fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ColumnSchema_CLASS:
        return ColumnSchema.json(m);
      case Vocabulary.Column_CLASS:
        return Column.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ColumnSchema_CLASS;
  String get name => _name;

  set name(String $o) {
    if ($o == _name) return;
    var $old = _name;
    _name = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.name_DP, $old, _name));
    }
  }

  String get type => _type;

  set type(String $o) {
    if ($o == _type) return;
    var $old = _type;
    _type = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.type_DP, $old, _type));
    }
  }

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

  double get storageSize => _storageSize;

  set storageSize(double $o) {
    if ($o == _storageSize) return;
    var $old = _storageSize;
    _storageSize = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.storageSize_DP, $old, _storageSize));
    }
  }

  ColumnSchemaMetaData get metaData => _metaData;

  set metaData(ColumnSchemaMetaData $o) {
    if ($o == _metaData) return;
    _metaData.parent = null;
    $o.parent = this;
    var $old = _metaData;
    _metaData = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.metaData_OP, $old, _metaData));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.type_DP:
        return type;
      case Vocabulary.nRows_DP:
        return nRows;
      case Vocabulary.size_DP:
        return size;
      case Vocabulary.metaData_OP:
        return metaData;
      case Vocabulary.storageSize_DP:
        return storageSize;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.type_DP:
        type = $value as String;
        return;
      case Vocabulary.nRows_DP:
        nRows = $value as int;
        return;
      case Vocabulary.size_DP:
        size = $value as int;
        return;
      case Vocabulary.storageSize_DP:
        storageSize = $value as double;
        return;
      case Vocabulary.metaData_OP:
        metaData = $value as ColumnSchemaMetaData;
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
  ColumnSchema copy() => ColumnSchema.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ColumnSchema_CLASS;
    if (subKind != null && subKind != Vocabulary.ColumnSchema_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.type_DP] = type;
    m[Vocabulary.nRows_DP] = nRows;
    m[Vocabulary.size_DP] = size;
    m[Vocabulary.metaData_OP] = metaData.toJson();
    m[Vocabulary.storageSize_DP] = storageSize;
    return m;
  }
}
