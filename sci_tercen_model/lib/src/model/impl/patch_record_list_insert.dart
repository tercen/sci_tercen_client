part of sci_model;

class PatchRecordListInsert extends PatchRecordListInsertBase {
  PatchRecordListInsert() : super();
  PatchRecordListInsert.json(Map m) : super.json(m);

  @override
  String get legacyType => PatchRecord.LIST_INSERT_TYPE;

  @override
  String toLegacyData() {
    return json.encode([this.index, this.value.toValueJson()]);
  }
}
