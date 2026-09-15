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
}
