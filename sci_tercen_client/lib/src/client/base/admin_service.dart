part of sci_client_base;

class AdminServiceBase extends HttpClientService<PersistentObject>
    implements api.AdminService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/admin");
  String get serviceName => "PersistentObject";

  Map toJson(PersistentObject object) => object.toJson();
  PersistentObject fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return PersistentObjectBase.fromJson(m);
    return new PersistentObject.json(m);
  }

  Future<List<Pair>> getSchedulerStatus(
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/admin" + "/" + "getSchedulerStatus");
      var params = {};
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
    return answer as List<Pair>;
  }

  Future<List<Pair>> getConfigSummary({service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/admin" + "/" + "getConfigSummary");
      var params = {};
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
    return answer as List<Pair>;
  }

  Future<String> getGcStatus({service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/admin" + "/" + "getGcStatus");
      var params = {};
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

  Future<String> triggerGcRun({service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/admin" + "/" + "triggerGcRun");
      var params = {};
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

  Future<String> getStorageReport(String domain,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/admin" + "/" + "getStorageReport");
      var params = {};
      params["domain"] = domain;
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

  Future<String> findActivities(int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/admin" + "/" + "findActivities");
      var params = {};
      params["limit"] = limit;
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

  Future<String> listUsers(int limit, {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/admin" + "/" + "listUsers");
      var params = {};
      params["limit"] = limit;
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

  Future<List<String>> grantRole(String username, String role,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/admin" + "/" + "grantRole");
      var params = {};
      params["username"] = username;
      params["role"] = role;
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
    return answer as List<String>;
  }

  Future<List<String>> revokeRole(String username, String role,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/admin" + "/" + "revokeRole");
      var params = {};
      params["username"] = username;
      params["role"] = role;
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
    return answer as List<String>;
  }
}
