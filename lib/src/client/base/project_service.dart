part of sci_client_base;

class ProjectServiceBase extends HttpClientService<Project>
    implements api.ProjectService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/project");
  String get serviceName => "Project";

  Map toJson(Project object) => object.toJson();
  Project fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return ProjectBase.fromJson(m);
    return new Project.json(m);
  }

  Future<List<Project>> findByIsPublicAndLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByIsPublicAndLastModifiedDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<List<Project>> findByTeamAndIsPublicAndLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByTeamAndIsPublicAndLastModifiedDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<Profiles> profiles(String projectId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/project" + "/" + "profiles");
      var params = {};
      params["projectId"] = projectId;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
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

  Future<ResourceSummary> resourceSummary(String projectId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/project" + "/" + "resourceSummary");
      var params = {};
      params["projectId"] = projectId;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
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

  Future<List<Project>> explore(String category, int start, int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/project" + "/" + "explore");
      var params = {};
      params["category"] = category;
      params["start"] = start;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => ProjectBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<Project>;
  }

  Future<List<Project>> recentProjects(String userId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/project" + "/" + "recentProjects");
      var params = {};
      params["userId"] = userId;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => ProjectBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<Project>;
  }

  Future<Project> cloneProject(String projectId, Project project,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/project" + "/" + "cloneProject");
      var params = {};
      params["projectId"] = projectId;
      params["project"] = project.toJson();
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            ProjectBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as Project;
  }
}
