part of sci_client_base;

class UserSecretServiceBase extends HttpClientService<UserSecret>
    implements api.UserSecretService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/userSecret");
  String get serviceName => "UserSecret";

  Map toJson(UserSecret object) => object.toJson();
  UserSecret fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return UserSecretBase.fromJson(m);
    return new UserSecret.json(m);
  }

  Future<List<UserSecret>> findSecretByUserId(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("secret",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  Future<String> getSecret(String id, String name,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/userSecret" + "/" + "getSecret");
      var params = {};
      params["id"] = id;
      params["name"] = name;
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
