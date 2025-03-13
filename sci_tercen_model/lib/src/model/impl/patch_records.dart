part of sci_model;

class PatchRecords extends PatchRecordsBase {
  PatchRecords() : super();
  PatchRecords.json(Map m) : super.json(m);

  T apply<T extends SciObject>(T object) {
    // print(
    //     'PatchRecords.apply -- ${JsonEncoder.withIndent('  ').convert(this.toJson())}');

    for (var record in rs) {
      record.apply(object);
    }
    return object;
  }
}
