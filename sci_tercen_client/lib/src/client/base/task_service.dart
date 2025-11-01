part of sci_client_base;

class TaskServiceBase extends HttpClientService<Task>
    implements api.TaskService {
  late ServiceFactoryBase factory;

  @override
  Uri get uri => Uri.parse("api/v1/task");
  @override
  String get serviceName => "Task";

  @override
  Map toJson(Task object) => object.toJson();
  @override
  Task fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return TaskBase.fromJson(m);
    return Task.json(m);
  }

  @override
  Future<List<Task>> findByHash(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByHash",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  @override
  Future<List<Task>> findGCTaskByLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findGCTaskByLastModifiedDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  @override
  Future<dynamic> runTask(String taskId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/task" "/" "runTask");
      var params = {};
      params["taskId"] = taskId;
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
  Future<dynamic> cancelTask(String taskId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/task" "/" "cancelTask");
      var params = {};
      params["taskId"] = taskId;
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
  Future<Task> waitDone(String taskId, {service.AclContext? aclContext}) async {
    Task answer;
    try {
      var uri = Uri.parse("api/v1/task" "/" "waitDone");
      var params = {};
      params["taskId"] = taskId;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = TaskBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<dynamic> updateWorker(Worker worker,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/task" "/" "updateWorker");
      var params = {};
      params["worker"] = worker.toJson();
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
  Future<double> taskDurationByTeam(String teamId, int year, int month,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/task" "/" "taskDurationByTeam");
      var params = {};
      params["teamId"] = teamId;
      params["year"] = year;
      params["month"] = month;
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
    return answer as double;
  }

  @override
  Future<List<Worker>> getWorkers(List<String> names,
      {service.AclContext? aclContext}) async {
    List<Worker> answer;
    try {
      var uri = Uri.parse("api/v1/task" "/" "getWorkers");
      var params = {};
      params["names"] = names;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => WorkerBase.fromJson(m as Map))
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
  Future<List<Task>> getTasks(List<String> names,
      {service.AclContext? aclContext}) async {
    List<Task> answer;
    try {
      var uri = Uri.parse("api/v1/task" "/" "getTasks");
      var params = {};
      params["names"] = names;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => TaskBase.fromJson(m as Map))
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
  Future<dynamic> setTaskEnvironment(String taskId, List<Pair> environment,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/task" "/" "setTaskEnvironment");
      var params = {};
      params["taskId"] = taskId;
      params["environment"] = environment.map((each) => each.toJson()).toList();
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
  Future<dynamic> collectTaskStats(String taskId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/task" "/" "collectTaskStats");
      var params = {};
      params["taskId"] = taskId;
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
