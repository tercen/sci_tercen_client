part of sci_model;

class PatchRecordListRemove extends PatchRecordListRemoveBase {
  PatchRecordListRemove() : super();
  PatchRecordListRemove.json(Map m) : super.json(m);

  @override
  String get legacyType => PatchRecord.LIST_REMOVE_TYPE;

  @override
  String toLegacyData() {
    return json.encode(this.indexes.toList());
  }
}
