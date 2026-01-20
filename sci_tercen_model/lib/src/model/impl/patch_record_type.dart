part of sci_model;

class PatchRecordType extends PatchRecordTypeBase {
  PatchRecordType() : super();
  PatchRecordType.json(Map m) : super.json(m);

  String get legacyType => '';

  String toLegacyData() {
    throw "subclass responsibility";
  }
}
