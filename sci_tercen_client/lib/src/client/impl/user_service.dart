part of sci_client;

class UserService extends UserServiceBase {
  UserSession? _session;
  UserSession? get session => _session;

  Future setSession(UserSession s) async {
    _session = s;
    var authClient = httpauth.HttpAuthClient(s.token.token);
    await factory.initializeWith(baseRestUri, authClient);
  }
}
