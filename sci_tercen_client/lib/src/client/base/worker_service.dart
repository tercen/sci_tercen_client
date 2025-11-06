part of sci_client_base;

class WorkerServiceBase extends HttpClientService<Task>
    implements api.WorkerService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/worker");
  String get serviceName => "Task";

  Map toJson(Task object) => object.toJson();
  Task fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return TaskBase.fromJson(m);
    return new Task.json(m);
  }

  Future<dynamic> exec(Task task, {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/worker" + "/" + "exec");
      var params = {};
      params["task"] = task.toJson();
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

  Future<dynamic> setPriority(double priority,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/worker" + "/" + "setPriority");
      var params = {};
      params["priority"] = priority;
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

  Future<dynamic> setStatus(String status,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/worker" + "/" + "setStatus");
      var params = {};
      params["status"] = status;
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

  Future<dynamic> setHeartBeat(int heartBeat,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/worker" + "/" + "setHeartBeat");
      var params = {};
      params["heartBeat"] = heartBeat;
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

  Future<Worker> getState(String all, {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/worker" + "/" + "getState");
      var params = {};
      params["all"] = all;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = WorkerBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as Worker;
  }

  Future<List<Pair>> updateTaskEnv(String taskId, List<Pair> env,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/worker" + "/" + "updateTaskEnv");
      var params = {};
      params["taskId"] = taskId;
      params["env"] = env.map((each) => each.toJson()).toList();
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

  Future<List<Table>> getTaskStats(String taskId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/worker" + "/" + "getTaskStats");
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
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => TableBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<Table>;
  }
}
