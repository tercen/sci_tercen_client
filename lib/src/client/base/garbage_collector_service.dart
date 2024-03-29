part of sci_client_base;

class GarbageCollectorServiceBase extends HttpClientService<GarbageObject>
    implements api.GarbageCollectorService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/gc");
  String get serviceName => "GarbageObject";

  Map toJson(GarbageObject object) => object.toJson();
  GarbageObject fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return GarbageObjectBase.fromJson(m);
    return new GarbageObject.json(m);
  }

  Future<List<GarbageObject>> findGarbageTasks2ByDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findGarbageTasks2ByDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }
}
