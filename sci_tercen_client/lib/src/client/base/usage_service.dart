part of sci_client_base;

class UsageServiceBase extends HttpClientService<PersistentObject>
    implements api.UsageService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/usage");
  String get serviceName => "PersistentObject";

  Map toJson(PersistentObject object) => object.toJson();
  PersistentObject fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return PersistentObjectBase.fromJson(m);
    return new PersistentObject.json(m);
  }

  Future<String> getUsageReport(
      String scope, String from, String to, String bucket,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/usage" + "/" + "getUsageReport");
      var params = {};
      params["scope"] = scope;
      params["from"] = from;
      params["to"] = to;
      params["bucket"] = bucket;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List).first;
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as String;
  }
}
