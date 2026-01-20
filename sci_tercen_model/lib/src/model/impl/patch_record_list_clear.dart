part of sci_model;

class PatchRecordListClear extends PatchRecordListClearBase {
  PatchRecordListClear() : super();
  PatchRecordListClear.json(Map m) : super.json(m);

  @override
  String get legacyType => PatchRecord.LIST_CLEAR_TYPE;

  @override
  String toLegacyData() {
    return '';
  }
}
