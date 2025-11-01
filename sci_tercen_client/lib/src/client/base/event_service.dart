part of sci_client_base;

class EventServiceBase extends HttpClientService<Event>
    implements api.EventService {
  late ServiceFactoryBase factory;

  @override
  Uri get uri => Uri.parse("api/v1/evt");
  @override
  String get serviceName => "Event";

  @override
  Map toJson(Event object) => object.toJson();
  @override
  Event fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return EventBase.fromJson(m);
    return Event.json(m);
  }

  @override
  Future<List<Event>> findByChannelAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByChannelAndDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  @override
  Future<dynamic> sendPersistentChannel(String channel, Event evt,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/evt" "/" "sendPersistentChannel");
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

  @override
  Future<dynamic> sendChannel(String channel, Event evt,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/evt" "/" "sendChannel");
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

  @override
  Stream<Event> channel(String name, {service.AclContext? aclContext}) {
    try {
      var uri = Uri.parse("api/v1/evt" "/" "channel");
      var params = {};
      params["name"] = name;
      Event decode(s) => EventBase.fromJson(s as Map);
      return webSocketStream<Event>(uri, params, decode);
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    throw "should not happen";
  }

  @override
  Stream<TaskEvent> listenTaskChannel(String taskId, bool start,
      {service.AclContext? aclContext}) {
    try {
      var uri = Uri.parse("api/v1/evt" "/" "listenTaskChannel");
      var params = {};
      params["taskId"] = taskId;
      params["start"] = start;
      TaskEvent decode(s) => TaskEventBase.fromJson(s as Map);
      return webSocketStream<TaskEvent>(uri, params, decode);
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    throw "should not happen";
  }

  @override
  Stream<TaskStateEvent> onTaskState(String taskId,
      {service.AclContext? aclContext}) {
    try {
      var uri = Uri.parse("api/v1/evt" "/" "onTaskState");
      var params = {};
      params["taskId"] = taskId;
      TaskStateEvent decode(s) => TaskStateEventBase.fromJson(s as Map);
      return webSocketStream<TaskStateEvent>(uri, params, decode);
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    throw "should not happen";
  }

  @override
  Future<int> taskListenerCount(String taskId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/evt" "/" "taskListenerCount");
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
