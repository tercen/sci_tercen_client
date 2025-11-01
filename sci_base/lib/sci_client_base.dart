import 'dart:async';
import "dart:convert";

import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:sci_http_client/http_client.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:sci_http_client/error.dart';
import 'package:sci_http_client/content_codec.dart';
import 'package:tson/tson.dart' as TSON;

import 'package:sci_base/sci_base.dart' as base;
import 'package:sci_base/sci_service.dart';

abstract class HttpClientService<T extends base.PersistentBase>
    extends Service<T> {
  static Logger logger = Logger("HttpClientService");

  late Uri baseRestUri;
  late http.HttpClient client;

  ContentCodec contentCodec = TsonContentCodec();

  final StreamController<ServiceEvent> _controller =
      StreamController.broadcast();

  Logger getLogger() => logger;

  @override
  DomainConfig get config => DomainConfig();

  @override
  Uri getServiceUri(Uri uri) =>
      http.HttpClient.ResolveUri(baseRestUri, uri.toString());

  Future initialize(Uri baseRestUri, http.HttpClient client) async {
    this.baseRestUri = baseRestUri;
    this.client = client;
  }

  Stream<ServiceEvent> get onEvent => _controller.stream;

  Stream<DeleteServiceEvent> get onDeleteEvent => _controller.stream
      .where((evt) => evt is DeleteServiceEvent)
      .cast<DeleteServiceEvent>();

  Stream<CreatedServiceEvent<T>> get onCreatedEvent => _controller.stream
      .where((evt) => evt is CreatedServiceEvent<T>)
      .cast<CreatedServiceEvent<T>>();

  Stream<UpdateServiceEvent<T>> get onUpdateEvent => _controller.stream
      .where((evt) => evt is UpdateServiceEvent<T>)
      .cast<UpdateServiceEvent<T>>();

  void onResponseError(response) {
    var error = ServiceError(
        response.statusCode, "$serviceName.client.unknown", 'unknown');

    var codec = ContentCodec.contentType(
        response.headers[http.ContentTypeHeaderValue.HEADER_CONTENT_TYPE],
        contentCodec);

    try {
      if (response.headers[http.ContentTypeHeaderValue.HEADER_CONTENT_TYPE] ==
          codec.contentType) {
        var err = codec.decode(response.body);
        if (err is Map) {
          error = ServiceError.fromJson(err);
        } else {
          error = ServiceError.fromJson(err as Map);
        }
      } else {
        if (response.body is String) {
          throw ServiceError(response.statusCode, "$serviceName.client.unknown",
              response.body as String?);
        } else if (response.body is List) {
          throw ServiceError(response.statusCode, "$serviceName.client.unknown",
              utf8.decode(response.body as List<int>));
        }
      }
    } catch (e) {
      if (response.body is String) {
        throw ServiceError(response.statusCode, "$serviceName.client.unknown",
            response.body as String?);
      } else if (response.body is List) {
        throw ServiceError(response.statusCode, "$serviceName.client.unknown",
            utf8.decode(response.body as List<int>));
      }
    }
    throw error;
  }

  void onError(e, st) {
    var trace = Trace.current().terse;
    logger.severe('onError', e, trace);

    if (e is http.HttpClientError) {
      throw ServiceError(e.statusCode, e.error, e.reason)..originalError = e;
    }

//    if (e is SocketException){
//      throw ServiceError(500, "${this.serviceName}.socket", e.toString());
//    }

    throw ServiceError(500, "$serviceName.client.unknown", e.toString())
      ..originalError = e;
  }

  Stream<T> webSocketStream<T>(Uri uri, Map params, decode(object)) {
    WebSocketChannel? channel;
    late StreamController<T> controller;

    var scheme = getServiceUri(uri).scheme == 'http' ? 'ws' : 'wss';

    var wsuri = getServiceUri(uri).replace(
        scheme: scheme, queryParameters: {"params": json.encode(params)});

    Timer? timer;
    StreamSubscription? sub;

    controller = StreamController<T>(
        sync: false,
        onListen: () {
          channel = client.webSocketChannel(wsuri);

//          channel.sink.add(contentCodec.encode(params));

          timer = Timer.periodic(Duration(seconds: 10), (t) {
            channel!.sink.add('__ping__');
          });

          sub = channel!.stream.listen((message) {
            var obj = TSON.decode(message);
            // hack
            // behind nginx connection closed by the server cause missing data on heatmap
            if (obj is Map && obj['kind'] == 'websocketdone') {
              controller.close();
              timer?.cancel();
              sub?.cancel();

              channel!.sink.add(contentCodec.encode(obj));

              channel!.sink.close(1000, '');
            } else {
              try {
                controller.add(decode(obj));
              } catch (e) {
                try {
                  controller.addError(ServiceError.fromJson(obj as Map));
                } catch (ee) {
                  controller.addError(ServiceError.fromError(ee));
                }

                sub?.cancel();
                controller.close();
                timer?.cancel();
                channel?.sink.close(1000, '');
              }
            }
          }, onError: (e) {
            sub?.cancel();
            timer?.cancel();
            controller.addError(e);
          }, onDone: () {
            timer?.cancel();
            sub?.cancel();
            controller.close();
          }, cancelOnError: true);
        },
        onCancel: () {
          timer?.cancel();
          sub?.cancel();
          channel?.sink.close(1000, '');
        });

    return controller.stream;
  }

  @override
  Future<T> create(T object, {AclContext? aclContext}) async {
    T? answer;
    try {
      var response = await client.put(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          body: contentCodec.encode(toJson(object)),
          responseType: contentCodec.responseType);
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }

    _controller.add(CreatedServiceEvent(answer));

    return answer!;
  }

  void sendCreatedEvent(T object) {
    _controller.add(CreatedServiceEvent(object));
  }

//
  void sendUpdateEvent(T object) {
    _controller.add(UpdateServiceEvent(object));
  }

//
//  void sendDeleteEvent(String id, [String rev]) {
//    _controller.add(DeleteServiceEvent()
//      ..id = id
//      ..rev = rev);
//  }

  Future<String> rev(String id, {AclContext? aclContext}) async {
    var doc = await get(id, aclContext: aclContext);
    return doc.rev;
  }

  @override
  Future<T?> getNoneMatchRev(String id, String ifNoneMatchRev,
      {bool useFactory = true, AclContext? aclContext}) async {
    T? answer;
    try {
      var queryParameters = {'id': id};
      queryParameters['useFactory'] = useFactory.toString();

      var response = await client.head(
        getServiceUri(uri).replace(queryParameters: queryParameters),
        headers: getHeaderForAclContext(null, aclContext),
      );
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      logger.severe('getNoneMatchRev', e, st);
      onError(e, st);
    }
    return answer!;
  }

  Map<String, String>? getHeaderForAclContext(
      Map<String, String>? headers, AclContext? aclContext) {
    Map<String, String>? headers;
    if (aclContext is AclTokenContextImpl) {
      headers ??= <String, String>{};
      headers['authorization'] = aclContext.authorization;
    }
    return headers;
  }

  @override
  Future<T> get(String id,
      {bool useFactory = true, AclContext? aclContext}) async {
    T? answer;
    try {
      var queryParameters = {'id': id};
      queryParameters['useFactory'] = useFactory.toString();

      var response = await client.get(
          getServiceUri(uri).replace(queryParameters: queryParameters),
          headers: getHeaderForAclContext(null, aclContext),
          responseType: contentCodec.responseType);
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      logger.severe('get', e, st);
      onError(e, st);
    }
    return answer!;
  }

  @override
  Future<String> patch(PatchCommands commands, {AclContext? aclContext}) async {
    throw 'not impl';
  }

  @override
  Future deleteObject(T? object,
      {AclContext? aclContext,
      bool checkRef = true,
      bool force = false}) async {
    throw 'not impl';
  }

  @override
  Future deleteObjects(List<T?> objects,
      {AclContext? aclContext,
      bool checkRef = true,
      bool force = false}) async {
    throw 'not impl';
  }

  @override
  Future delete(String id, String rev,
      {AclContext? aclContext, bool force = false}) async {
    try {
      var response = await client.delete(
        getServiceUri(uri).replace(queryParameters: {'id': id, 'rev': rev}),
        headers: getHeaderForAclContext(null, aclContext),
      );
      if (response.statusCode != 200) {
        onResponseError(response);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }

    _controller.add(DeleteServiceEvent()
      ..id = id
      ..rev = rev);
  }

  Future<T> applyAndUpdate(T object, void Function(T tt) applyResult) async {
    applyResult(object);
    try {
      await update(object);
      return object;
    } on ServiceError catch (e) {
      if (e.isConflictError) {
        return applyAndUpdate(await get(object.id), applyResult);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<String> update(T object, {AclContext? aclContext}) async {
    try {
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          body: contentCodec.encode(toJson(object)),
          responseType: contentCodec.responseType);
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        object.rev = contentCodec.decode(response.body)[0] as String;
      }

      _controller.add(UpdateServiceEvent(object));
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return object.rev;
  }

  @override
  Future<List<T?>> listNotFound(List<String> ids,
      {AclContext? aclContext, bool useFactory = true}) async {
    List<T?>? answer;
    try {
      var queryParameters = {'useFactory': useFactory.toString()};
      var response = await client.post(
          getServiceUri(uri).replace(
              path: '${getServiceUri(uri).path}/listNotFound',
              queryParameters: queryParameters),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          body: contentCodec.encode(ids),
          responseType: contentCodec.responseType);
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((each) => each == null ? null : fromJson(each as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer!;
  }

  @override
  Future<List<T>> list(List<String> ids,
      {AclContext? aclContext, bool useFactory = true}) async {
    List<T>? answer;
    try {
      var queryParameters = {'useFactory': useFactory.toString()};
      var response = await client.post(
          getServiceUri(uri).replace(
              path: '${getServiceUri(uri).path}/list',
              queryParameters: queryParameters),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          body: contentCodec.encode(ids),
          responseType: contentCodec.responseType);
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((each) => fromJson(each as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer!;
  }

  static bool _identicalKeys(key1, key2) {
    if (key1 == null && key2 == null) return true;
    if (key1 == null) return false;
    if (key2 == null) return false;

    if (key1.runtimeType != key2.runtimeType) return false;

    if (key1 is Comparable) {
      return key1.compareTo(key2) == 0;
    }

    if (key1 is List<Comparable>) {
      if (key1.length != key2.length) return false;
      for (var i = 0; i < key1.length; i++) {
        if (!_identicalKeys(key1[i], key2[i])) return false;
      }
      return true;
    }

    throw ServiceError(500, "identical_keys.unsupported_type",
        "Unsupported type for key comparison: ${key1.runtimeType}");
  }

  Stream<T> findStartKeysStream(
      String viewName, dynamic Function(T object) getKey,
      {startKey,
      endKey,
      int batch = 100,
      bool descending = true,
      bool useFactory = false,
      AclContext? aclContext}) async* {
    var list = await findStartKeys(viewName,
        startKey: startKey,
        endKey: endKey,
        limit: batch,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);

    yield* Stream.fromIterable(list);

    var identicalLastKeys = 0;

    while (list.isNotEmpty) {
      var lastKey = getKey(list.last);

      if (!_identicalKeys(startKey, lastKey)) {
        identicalLastKeys = 0;
        startKey = lastKey;
      }

      identicalLastKeys += list
          .where((object) => _identicalKeys(startKey, getKey(object)))
          .length;

      list = await findStartKeys(viewName,
          startKey: startKey,
          endKey: endKey,
          limit: batch,
          skip: identicalLastKeys,
          descending: descending,
          useFactory: useFactory,
          aclContext: aclContext);

      yield* Stream.fromIterable(list);
    }
  }

  Future<List<T>> findStartKeys(String viewName,
      {startKey,
      endKey,
      int limit = 20,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      AclContext? aclContext}) async {
    late List<T> answer;
    try {
      var queryParameters = {'useFactory': useFactory.toString()};
      var response = await client.post(
          getServiceUri(uri).replace(
              path: '${getServiceUri(uri).path}/$viewName',
              queryParameters: queryParameters),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          body: contentCodec.encode({
            'startKey': startKey,
            'endKey': endKey,
            'limit': limit,
            'skip': skip,
            'descending': descending
          }),
          responseType: contentCodec.responseType);
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((each) => fromJson(each as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  Future<List<T>> findKeys(String viewName,
      {required List keys,
      bool useFactory = false,
      AclContext? aclContext}) async {
    late List<T> answer;
    try {
      var queryParameters = {'useFactory': useFactory.toString()};
      var response = await client.post(
          getServiceUri(uri).replace(
              path: '${getServiceUri(uri).path}/$viewName',
              queryParameters: queryParameters),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          body: contentCodec.encode(keys),
          responseType: contentCodec.responseType);
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((each) => fromJson(each as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }
}
