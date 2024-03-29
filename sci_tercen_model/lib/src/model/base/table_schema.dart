part of sci_model_base;

class TableSchemaBase extends Schema {
  static const List<String> PROPERTY_NAMES = [];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];

  TableSchemaBase();
  TableSchemaBase.json(Map m) : super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TableSchema_CLASS, m);
  }

  static TableSchema createFromJson(Map m) => TableSchemaBase.fromJson(m);
  static TableSchema _createFromJson(Map? m) =>
      m == null ? TableSchema() : TableSchemaBase.fromJson(m);
  static TableSchema fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TableSchema_CLASS:
        return TableSchema.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TableSchema_CLASS;

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  TableSchema copy() => TableSchema.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TableSchema_CLASS;
    if (subKind != null && subKind != Vocabulary.TableSchema_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    return m;
  }
}
