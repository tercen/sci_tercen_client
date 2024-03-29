part of sci_model_base;

class TableRelationBase extends SimpleRelation {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.meta_data_OP,
    Vocabulary.nRows_DP,
    Vocabulary.data_dir_DP,
    Vocabulary.attributes_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Pair> meta_data;
  int _nRows;
  String _data_dir;
  final base.ListChanged<Attribute> attributes;

  TableRelationBase()
      : _nRows = 0,
        _data_dir = "",
        meta_data = base.ListChanged<Pair>(),
        attributes = base.ListChanged<Attribute>() {
    meta_data.parent = this;
    attributes.parent = this;
  }

  TableRelationBase.json(Map m)
      : _nRows = base.defaultValue(
            m[Vocabulary.nRows_DP] as int?, base.int_DefaultFactory),
        _data_dir = base.defaultValue(
            m[Vocabulary.data_dir_DP] as String?, base.String_DefaultFactory),
        meta_data = base.ListChanged<Pair>.from(
            m[Vocabulary.meta_data_OP] as List?, PairBase.createFromJson),
        attributes = base.ListChanged<Attribute>.from(
            m[Vocabulary.attributes_OP] as List?, AttributeBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TableRelation_CLASS, m);
    meta_data.parent = this;
    attributes.parent = this;
  }

  static TableRelation createFromJson(Map m) => TableRelationBase.fromJson(m);
  static TableRelation _createFromJson(Map? m) =>
      m == null ? TableRelation() : TableRelationBase.fromJson(m);
  static TableRelation fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TableRelation_CLASS:
        return TableRelation.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TableRelation_CLASS;
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

  String get data_dir => _data_dir;

  set data_dir(String $o) {
    if ($o == _data_dir) return;
    var $old = _data_dir;
    _data_dir = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.data_dir_DP, $old, _data_dir));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.meta_data_OP:
        return meta_data;
      case Vocabulary.nRows_DP:
        return nRows;
      case Vocabulary.data_dir_DP:
        return data_dir;
      case Vocabulary.attributes_OP:
        return attributes;
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
      case Vocabulary.data_dir_DP:
        data_dir = $value as String;
        return;
      case Vocabulary.meta_data_OP:
        meta_data.setValues($value as Iterable<Pair>);
        return;
      case Vocabulary.attributes_OP:
        attributes.setValues($value as Iterable<Attribute>);
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
  TableRelation copy() => TableRelation.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TableRelation_CLASS;
    if (subKind != null && subKind != Vocabulary.TableRelation_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.meta_data_OP] = meta_data.toJson();
    m[Vocabulary.nRows_DP] = nRows;
    m[Vocabulary.data_dir_DP] = data_dir;
    m[Vocabulary.attributes_OP] = attributes.toJson();
    return m;
  }
}
