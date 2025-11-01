part of sci_client_base;

class PersistentServiceBase extends HttpClientService<PersistentObject>
    implements api.PersistentService {
  late ServiceFactoryBase factory;

  @override
  Uri get uri => Uri.parse("api/v1/po");
  @override
  String get serviceName => "PersistentObject";

  @override
  Map toJson(PersistentObject object) => object.toJson();
  @override
  PersistentObject fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return PersistentObjectBase.fromJson(m);
    return PersistentObject.json(m);
  }

  @override
  Future<List<PersistentObject>> findDeleted(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("findDeleted",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  @override
  Future<List<PersistentObject>> findByKind(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("findByKind",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  @override
  Future<List<String>> createNewIds(int n,
      {service.AclContext? aclContext}) async {
    List<String> answer;
    try {
      var uri = Uri.parse("api/v1/po" "/" "createNewIds");
      var params = {};
      params["n"] = n;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List).cast<String>();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<Summary> summary(String teamOrProjectId,
      {service.AclContext? aclContext}) async {
    Summary answer;
    try {
      var uri = Uri.parse("api/v1/po" "/" "summary");
      var params = {};
      params["teamOrProjectId"] = teamOrProjectId;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            SummaryBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<List<PersistentObject>> getDependentObjects(String id,
      {service.AclContext? aclContext}) async {
    List<PersistentObject> answer;
    try {
      var uri = Uri.parse("api/v1/po" "/" "getDependentObjects");
      var params = {};
      params["id"] = id;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => PersistentObjectBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<List<String>> getDependentObjectIds(String id,
      {service.AclContext? aclContext}) async {
    List<String> answer;
    try {
      var uri = Uri.parse("api/v1/po" "/" "getDependentObjectIds");
      var params = {};
      params["id"] = id;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List).cast<String>();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<List<PersistentObject>> getObjects(
      String startId, String endId, int limit, bool useFactory,
      {service.AclContext? aclContext}) async {
    List<PersistentObject> answer;
    try {
      var uri = Uri.parse("api/v1/po" "/" "getObjects");
      var params = {};
      params["startId"] = startId;
      params["endId"] = endId;
      params["limit"] = limit;
      params["useFactory"] = useFactory;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => PersistentObjectBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }
}
