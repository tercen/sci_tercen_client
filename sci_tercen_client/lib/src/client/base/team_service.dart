part of sci_client_base;

class TeamServiceBase extends HttpClientService<Team>
    implements api.TeamService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/team");
  String get serviceName => "Team";

  Map toJson(Team object) => object.toJson();
  Team fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return TeamBase.fromJson(m);
    return new Team.json(m);
  }

  Future<List<Team>> findTeamByOwner(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("teamByOwner",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  Future<Profiles> profiles(String teamId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/team" + "/" + "profiles");
      var params = {};
      params["teamId"] = teamId;
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
    return answer as Profiles;
  }

  Future<ResourceSummary> resourceSummary(String teamId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/team" + "/" + "resourceSummary");
      var params = {};
      params["teamId"] = teamId;
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
    return answer as ResourceSummary;
  }

  Future<dynamic> transferOwnership(List<String> teamIds, String newOwner,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/team" + "/" + "transferOwnership");
      var params = {};
      params["teamIds"] = teamIds;
      params["newOwner"] = newOwner;
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
