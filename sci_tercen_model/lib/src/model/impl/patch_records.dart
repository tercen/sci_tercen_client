part of sci_model;

class PatchRecords extends PatchRecordsBase {
  PatchRecords() : super();
  PatchRecords.json(super.m) : super.json();

  T apply<T extends SciObject>(T object) {
    // print(
    //     'PatchRecords.apply -- ${JsonEncoder.withIndent('  ').convert(this.toJson())}');

    // Group LIST_REMOVE operations by path and collect their indices
    var removesByPath = <String, List<int>>{};
    var otherRecords = <PatchRecord>[];

    for (var record in rs) {
      if (record.type == PatchRecord.LIST_REMOVE_TYPE) {
        var indexes = json.decode(record.data) as List;
        removesByPath
            .putIfAbsent(record.path, () => [])
            .addAll(indexes.cast<int>());
      } else {
        otherRecords.add(record);
      }
    }

    // Apply LIST_REMOVE operations with sorted indices (descending)
    for (var entry in removesByPath.entries) {
      var path = entry.key;
      var indexes = entry.value
        ..sort((a, b) => b.compareTo(a)); // Sort descending

      var consolidatedRecord = PatchRecord()
        ..path = path
        ..type = PatchRecord.LIST_REMOVE_TYPE
        ..data = json.encode(indexes);

      consolidatedRecord.apply(object);
    }

    // Apply all other operations in original order
    for (var record in otherRecords) {
      record.apply(object);
    }

    return object;
  }
}
