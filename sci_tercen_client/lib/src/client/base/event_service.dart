part of sci_client_base;

class EventServiceBase extends HttpClientService<Event>
    implements api.EventService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/evt");
  String get serviceName => "Event";

  Map toJson(Event object) => object.toJson();
  Event fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return EventBase.fromJson(m);
    return new Event.json(m);
  }

  Future<dynamic> sendChannel(String channel, Event evt,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/evt" + "/" + "sendChannel");
      var params = {};
      params["channel"] = channel;
      params["evt"] = evt.toJson();
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

  Stream<Event> channel(String name, {service.AclContext? aclContext}) {
    try {
      var uri = Uri.parse("api/v1/evt" + "/" + "channel");
      var params = {};
      params["name"] = name;
      var decode = (s) => EventBase.fromJson(s as Map);
      return this.webSocketStream<Event>(uri, params, decode);
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    throw "should not happen";
  }

  Stream<TaskEvent> listenTaskChannel(String taskId, bool start,
      {service.AclContext? aclContext}) {
    try {
      var uri = Uri.parse("api/v1/evt" + "/" + "listenTaskChannel");
      var params = {};
      params["taskId"] = taskId;
      params["start"] = start;
      var decode = (s) => TaskEventBase.fromJson(s as Map);
      return this.webSocketStream<TaskEvent>(uri, params, decode);
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    throw "should not happen";
  }

  Stream<TaskStateEvent> onTaskState(String taskId,
      {service.AclContext? aclContext}) {
    try {
      var uri = Uri.parse("api/v1/evt" + "/" + "onTaskState");
      var params = {};
      params["taskId"] = taskId;
      var decode = (s) => TaskStateEventBase.fromJson(s as Map);
      return this.webSocketStream<TaskStateEvent>(uri, params, decode);
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    throw "should not happen";
  }

  Future<int> taskListenerCount(String taskId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/evt" + "/" + "taskListenerCount");
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
        answer = (contentCodec.decode(response.body) as List).first;
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as int;
  }
}
