part of sci_model;

class PatchRecordSet extends PatchRecordSetBase {
  PatchRecordSet() : super();
  PatchRecordSet.json(Map m) : super.json(m);

  @override
  String get legacyType => PatchRecord.SET_TYPE;

  @override
  String toLegacyData() {
    return json.encode(this.value.toValueJson());
  }
}
