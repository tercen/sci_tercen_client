part of '../http_io_client.dart';

class BaseClientImpl extends http.BaseClient {
  http.Client? _client;

  http.Client? get client {
    _client ??= http.Client();
    return _client;
  }

  bool _followRedirects = false;
  BaseClientImpl({http.Client? client, bool followRedirects = false}) {
    _client = client;
    _followRedirects = followRedirects;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.followRedirects = _followRedirects;
    request.maxRedirects = 5;
    return client!.send(request);
  }

//X509Certificate
  set badCertificateCallback(bool Function(dynamic, String, int) callback) {
//    InstanceMirror myClassInstanceMirror = reflect(client);
//    var _inner =
//        MirrorSystem.getSymbol('_inner', myClassInstanceMirror.type.owner);
//    var ioclientmirror = myClassInstanceMirror.getField(_inner);
//    ioclientmirror.setField(#badCertificateCallback, callback);
  }

  @override
  void close() {
    if (_client != null) {
      _client!.close();
      _client = null;
    }
  }
}

class LoadBalancerBaseClientImpl extends BaseClientImpl {
  final logger = Logger("LoadBalancerBaseClientImpl");
  List<Uri?>? _uris;
  List<Uri?> _failedUri = [];
  int? _uriIndex;
  Timer? _timer;

  LoadBalancerBaseClientImpl(List<Uri?> list,
      {super.client, super.followRedirects}) {
    uris = list;
    _timer = Timer.periodic(Duration(seconds: 5), _onTimer);
  }

  set uris(List<Uri?> list) {
    _uris = list;
    _uriIndex = 0;
    _failedUri = [];
  }

  int get _maxRetry => _uris!.length + _failedUri.length;

  @override
  void close() {
    super.close();
    if (_timer != null) _timer!.cancel();
    _timer = null;
  }

  _onTimer(Timer t) {
    _uris!.addAll(_failedUri);
    _failedUri = [];
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _send(request, 0);
  }

  Future<http.StreamedResponse> _send(http.BaseRequest request, int retry) {
    Uri? currentUri;
    return Future.sync(() {
      var uri = getLoadBalancedRequest(request);
      var i = _uriIndex! - 1;
      currentUri = _uris![i];
      return super.send(uri);
    }).catchError((e) {
      if (e is iolib.SocketException) {
        var failedUri = currentUri;
        _failedUri.add(failedUri);
        _uris!.remove(failedUri);
        if (retry < _maxRetry) {
          return _send(request, retry++);
        } else {
          throw e;
        }
      }
      throw e as Object;
    });
  }

  http.BaseRequest getLoadBalancedRequest(http.BaseRequest request) {
    if (_uris == null || _uris!.isEmpty) return request;
    http.Request req =
        http.Request(request.method, getLoadBalancedUri(request.url));

    req.persistentConnection = request.persistentConnection;
    req.followRedirects = request.followRedirects;

    req.maxRedirects = request.maxRedirects;
    request.headers.forEach((k, v) {
      req.headers[k] = v;
    });

    if (request is http.Request) {
      req.encoding = request.encoding;
      req.bodyBytes = request.bodyBytes;
    }

    return req;
  }

  Uri getLoadBalancedUri(Uri requestUri) {
    if (_uris == null || _uris!.isEmpty) return requestUri;
    if (_uriIndex! >= _uris!.length) _uriIndex = 0;
    var answer = _uris![_uriIndex!]!;
    answer = requestUri.replace(
        scheme: answer.scheme, host: answer.host, port: answer.port);
    _uriIndex = _uriIndex! + 1;
    return answer;
  }
}

class HttpIOClient implements api.HttpClient {
  final log = Logger("HttpIOClient");

  static api.HttpClient? setAsCurrent() {
    return api.HttpClient.setCurrent(HttpIOClient());
  }

  @override
  WebSocketChannel webSocketChannel(Object uri) =>
      IOWebSocketChannel.connect(uri);

  BaseClientImpl client;

  factory HttpIOClient(
      {http.Client? client,
      List<Uri?>? loadBalancedUris,
      bool followRedirects = true}) {
    if (loadBalancedUris != null) {
      return HttpIOClient._(LoadBalancerBaseClientImpl(loadBalancedUris,
          client: client, followRedirects: followRedirects));
    } else {
      return HttpIOClient._(
          BaseClientImpl(client: client, followRedirects: followRedirects));
    }
  }

  HttpIOClient._(this.client);

  @override
  Uri resolveUri(Uri uri, String path) => api.HttpClient.ResolveUri(uri, path);

  set badCertificateCallback(
      bool Function(dynamic cert, String host, int port) callback) {
    client.badCertificateCallback = callback;
  }

  @override
  Future<api.Response> head(url, {Map<String, String>? headers}) {
    var uri = url is Uri ? url : Uri.parse(url.toString());
    return client.head(uri, headers: headers).then((rep) => IOResponse(rep));
  }

  @override
  Future<api.Response> get(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding encoding = utf8}) {
    var uri = url is Uri ? url : Uri.parse(url as String);

    if (body != null) {
      var request = http.Request("GET", uri);
      if (body != null) request.body = body as String;
      if (headers != null) {
        request.headers.addAll(headers);
      }
      request.encoding = encoding;
      return client
          .send(request)
          .then(http.Response.fromStream)
          .then((response) {
        return IOResponse(response, responseType: responseType);
      });
    } else {
      return client
          .get(uri, headers: headers)
          .then((rep) => IOResponse(rep, responseType: responseType));
    }
  }

  @override
  Future<api.Response> post(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding? encoding = utf8,
      api.ProgressCallback? progressCallback}) {
    var uri = url is Uri ? url : Uri.parse(url.toString());

    return client
        .post(uri, headers: headers, body: body, encoding: encoding)
        .then((rep) => IOResponse(rep, responseType: responseType));
  }

  @override
  Future<api.Response> put(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding? encoding = utf8,
      api.ProgressCallback? progressCallback}) {
    var uri = url is Uri ? url : Uri.parse(url.toString());

    return client
        .put(uri, headers: headers, body: body, encoding: encoding)
        .then((rep) => IOResponse(rep, responseType: responseType));
  }

  @override
  Future<api.Response> delete(url, {Map<String, String>? headers}) {
    var uri = url is Uri ? url : Uri.parse(url.toString());

    return client.delete(uri, headers: headers).then((rep) => IOResponse(rep));
  }

  @override
  void close({bool? force}) {

    if (force != null && force) client.close();
  }

  Future<api.Response> search(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding? encoding}) {
    var uri = url is Uri ? url : Uri.parse(url as String);
    var request = http.Request("SEARCH", uri);
    if (body != null) request.body = body as String;
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (encoding != null) {
      request.encoding = encoding;
    }
    return client.send(request).then(http.Response.fromStream).then((response) {
      return IOResponse(response, responseType: responseType);
    });
  }

  @override
  Future<api.StreamResponse> getStream(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding encoding = utf8}) {
    throw UnimplementedError();
  }
}

class IOResponse extends api.Response {
  http.Response response;
  String? responseType;

  IOResponse(this.response, {this.responseType});

  @override
  int get statusCode => response.statusCode;
  @override
  Map get headers => response.headers;
  @override
  Object get body {
    if (responseType == "arraybuffer") return response.bodyBytes.buffer;
    var contentType = headers['content-type'] as String?;
    var media = contentType != null
        ? MediaType.parse(contentType)
        : MediaType('application', 'octet-stream');
    var charset = media.parameters['charset'];
    var encoding = charset == null
        ? Encoding.getByName("utf-8")!
        : Encoding.getByName(charset)!;
    return encoding.decode(response.bodyBytes);
  }
}
