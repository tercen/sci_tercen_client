part of sci_client_base;

class QueryServiceBase extends HttpClientService<PersistentObject>
    implements api.QueryService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/query");
  String get serviceName => "PersistentObject";

  Map toJson(PersistentObject object) => object.toJson();
  PersistentObject fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return PersistentObjectBase.fromJson(m);
    return new PersistentObject.json(m);
  }

  Future<List<PersistentObject>> findByOwnerAndKindAndDate(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("findByOwnerAndKindAndDate",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  Future<List<PersistentObject>> findByOwnerAndProjectAndKindAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByOwnerAndProjectAndKindAndDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<List<PersistentObject>> findByOwnerAndKind(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("findByOwnerAndKind",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  Future<List<PersistentObject>> findPublicByKind(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("findPublicByKind",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  Future<List<PersistentObject>> findByProjectAndKindAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByProjectAndKindAndDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Stream<String> query(String jsonPath, int limit,
      {service.AclContext? aclContext}) {
    try {
      var uri = Uri.parse("api/v1/query" + "/" + "query");
      var params = {};
      params["jsonPath"] = jsonPath;
      params["limit"] = limit;
      // String stream - TSON.decode returns the string directly
      var decode = (s) => s as String;
      return this.webSocketStream<String>(uri, params, decode);
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    throw "should not happen";
  }
}
