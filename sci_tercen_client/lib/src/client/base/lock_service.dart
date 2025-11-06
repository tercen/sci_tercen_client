part of sci_client_base;

class LockServiceBase extends HttpClientService<Lock>
    implements api.LockService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/lock");
  String get serviceName => "Lock";

  Map toJson(Lock object) => object.toJson();
  Lock fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return LockBase.fromJson(m);
    return new Lock.json(m);
  }

  Future<Lock> lock(String name, int wait,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/lock" + "/" + "lock");
      var params = {};
      params["name"] = name;
      params["wait"] = wait;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = LockBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as Lock;
  }

  Future<dynamic> releaseLock(Lock lock,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/lock" + "/" + "releaseLock");
      var params = {};
      params["lock"] = lock.toJson();
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = null;
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as dynamic;
  }
}
