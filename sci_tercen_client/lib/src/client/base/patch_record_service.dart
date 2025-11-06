part of sci_client_base;

class PatchRecordServiceBase extends HttpClientService<PatchRecords>
    implements api.PatchRecordService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/pr");
  String get serviceName => "PatchRecords";

  Map toJson(PatchRecords object) => object.toJson();
  PatchRecords fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return PatchRecordsBase.fromJson(m);
    return new PatchRecords.json(m);
  }

  Future<List<PatchRecords>> findByChannelIdAndSequence(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByChannelIdAndSequence",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }
}
