part of sci_client_base;

class UserServiceBase extends HttpClientService<User>
    implements api.UserService {
  late ServiceFactoryBase factory;

  @override
  Uri get uri => Uri.parse("api/v1/user");
  @override
  String get serviceName => "User";

  @override
  Map toJson(User object) => object.toJson();
  @override
  User fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return UserBase.fromJson(m);
    return User.json(m);
  }

  @override
  Future<List<User>> findTeamMembers(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("teamMembers",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  @override
  Future<List<User>> findUserByCreatedDateAndName(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findUserByCreatedDateAndName",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  @override
  Future<List<User>> findUserByEmail(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("userByEmail",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  @override
  Future<String> getSamlMessage(String type,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "getSamlMessage");
      var params = {};
      params["type"] = type;
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

  @override
  Future<dynamic> cookieConsent(String dummy,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "cookieConsent");
      var params = {};
      params["dummy"] = dummy;
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

  @override
  Future<dynamic> logout(String reason,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "logout");
      var params = {};
      params["reason"] = reason;
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

  @override
  Future<UserSession> connect(String usernameOrEmail, String password,
      {service.AclContext? aclContext}) async {
    UserSession answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "connect");
      var params = {};
      params["usernameOrEmail"] = usernameOrEmail;
      params["password"] = password;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            UserSessionBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<UserSession> connect2(
      String domain, String usernameOrEmail, String password,
      {service.AclContext? aclContext}) async {
    UserSession answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "connect2");
      var params = {};
      params["domain"] = domain;
      params["usernameOrEmail"] = usernameOrEmail;
      params["password"] = password;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            UserSessionBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<User> createUser(User user, String password,
      {service.AclContext? aclContext}) async {
    User answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "createUser");
      var params = {};
      params["user"] = user.toJson();
      params["password"] = password;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = UserBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<bool> hasUserName(String username,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "hasUserName");
      var params = {};
      params["username"] = username;
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
    return answer as bool;
  }

  @override
  Future<dynamic> updatePassword(String userId, String password,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "updatePassword");
      var params = {};
      params["userId"] = userId;
      params["password"] = password;
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

  @override
  Future<BillingInfo> updateBillingInfo(String userId, BillingInfo billingInfo,
      {service.AclContext? aclContext}) async {
    BillingInfo answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "updateBillingInfo");
      var params = {};
      params["userId"] = userId;
      params["billingInfo"] = billingInfo.toJson();
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            BillingInfoBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<ViesInfo> viesInfo(String countryCode, String vatNumber,
      {service.AclContext? aclContext}) async {
    ViesInfo answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "viesInfo");
      var params = {};
      params["country_code"] = countryCode;
      params["vatNumber"] = vatNumber;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            ViesInfoBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<Summary> summary(String userId,
      {service.AclContext? aclContext}) async {
    Summary answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "summary");
      var params = {};
      params["userId"] = userId;
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
  Future<ResourceSummary> resourceSummary(String userId,
      {service.AclContext? aclContext}) async {
    ResourceSummary answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "resourceSummary");
      var params = {};
      params["userId"] = userId;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = ResourceSummaryBase.fromJson(
            contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<Profiles> profiles(String userId,
      {service.AclContext? aclContext}) async {
    Profiles answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "profiles");
      var params = {};
      params["userId"] = userId;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            ProfilesBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<String> createToken(String userId, int validityInSeconds,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "createToken");
      var params = {};
      params["userId"] = userId;
      params["validityInSeconds"] = validityInSeconds;
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

  @override
  Future<String> createTokenForTask(
      String userId, int validityInSeconds, String taskId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "createTokenForTask");
      var params = {};
      params["userId"] = userId;
      params["validityInSeconds"] = validityInSeconds;
      params["taskId"] = taskId;
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

  @override
  Future<bool> isTokenValid(String token,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "isTokenValid");
      var params = {};
      params["token"] = token;
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
    return answer as bool;
  }

  @override
  Future<String> setTeamPrivilege(
      String username, Principal principal, Privilege privilege,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "setTeamPrivilege");
      var params = {};
      params["username"] = username;
      params["principal"] = principal.toJson();
      params["privilege"] = privilege.toJson();
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

  @override
  Future<Version> getServerVersion(String module,
      {service.AclContext? aclContext}) async {
    Version answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "getServerVersion");
      var params = {};
      params["module"] = module;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            VersionBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<List<Pair>> getClientConfig(List<String> keys,
      {service.AclContext? aclContext}) async {
    List<Pair> answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "getClientConfig");
      var params = {};
      params["keys"] = keys;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => PairBase.fromJson(m as Map))
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
  Future<dynamic> getInvited(String email,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "getInvited");
      var params = {};
      params["email"] = email;
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

  @override
  Future<dynamic> sendValidationMail(String email,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "sendValidationMail");
      var params = {};
      params["email"] = email;
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

  @override
  Future<dynamic> sendResetPasswordEmail(String email,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "sendResetPasswordEmail");
      var params = {};
      params["email"] = email;
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

  @override
  Future<dynamic> changeUserPassword(String token, String password,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "changeUserPassword");
      var params = {};
      params["token"] = token;
      params["password"] = password;
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

  @override
  Future<dynamic> validateUser(String token,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "validateUser");
      var params = {};
      params["token"] = token;
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

  @override
  Future<bool> canCreatePrivateProject(String teamOrUserId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/user" "/" "canCreatePrivateProject");
      var params = {};
      params["teamOrUserId"] = teamOrUserId;
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
    return answer as bool;
  }
}
