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
}
