part of sci_model;

class PatchRecordListAdd extends PatchRecordListAddBase {
  PatchRecordListAdd() : super();
  PatchRecordListAdd.json(Map m) : super.json(m);

  @override
  String get legacyType => PatchRecord.LIST_ADD_TYPE;

  @override
  String toLegacyData() {
    return json.encode(this.value.map((each) => each.toValueJson()).toList());
  }
}
