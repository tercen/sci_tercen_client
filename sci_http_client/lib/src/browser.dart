part of '../http_browser_client.dart';

class HttpClient extends HttpBrowserClient {
  HttpClient({super.withCredentials});
}

class HttpBrowserClient implements api.HttpClient {
  @override
  WebSocketChannel webSocketChannel(uri) => HtmlWebSocketChannel.connect(uri);

  static void setAsCurrent() {
    api.HttpClient.setCurrent(HttpBrowserClient());
  }

  static bool IS_ASYNC = true;

  final log = Logger("HttpBrowserClient");

  bool? withCredentials;

  HttpBrowserClient({bool this.withCredentials = false});

  @override
  Uri resolveUri(Uri uri, String path) => api.HttpClient.ResolveUri(uri, path);

  HttpRequest newRequest() {
    var request = HttpRequest();
    return request;
  }

  void setHeaders(HttpRequest request, Map<String, String>? headers) {
    if (withCredentials!) {
      request.withCredentials = withCredentials;
    }
    if (headers == null) return;
    headers.forEach((k, v) => request.setRequestHeader(k, v));
  }

  Future<api.Response> reponseFromRequest(HttpRequest request) {
    if (request.readyState == HttpRequest.DONE) {
      return Future.value(Response(request));
    }
    var completer = Completer<Response>();

    request.onLoad.listen((event) {
      completer.complete(Response(request));
    });

    request.onError.listen((ProgressEvent evt) {
      var error = api.HttpClientError(
          500, "connection.unvailable", "Host unreachable.");
      completer.completeError(error);
    });

    return completer.future;
  }

  @override
  Future<api.Response> head(url, {Map<String, String>? headers}) {
//    log.finest("head $url $headers");
    var request = newRequest();
    request.open("HEAD", url.toString());
    setHeaders(request, headers);
    request.send();
    return reponseFromRequest(request);
  }

  void _openRequest(HttpRequest request, verb, url) {
    request.open(verb as String, url.toString(), async: true);
  }

  @override
  Future<api.StreamResponse> getStream(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding encoding = utf8}) async {
    var request = newRequest();
    request.responseType = api.HttpClient.RESPONSE_TYPE_STRING;
    _openRequest(request, "GET", url.toString());
    setHeaders(request, headers);
    StreamResponse response;
    response =
        StreamResponse(request, responseType: responseType, encoding: encoding);
    if (body != null) {
      dynamic data;
      if (body is String) {
        data = body;
      } else if (body is List) {
        data = body;
      } else if (body is Map) {
        request.setRequestHeader(
            "Content-Type", "application/x-www-form-urlencoded");
        data = mapToQuery(body as Map<String, String>, encoding: encoding);
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }

      request.send(data);
    } else {
      request.send();
    }

    var completer = Completer<api.StreamResponse>();

    request.onError.listen((evt) {
      if (!completer.isCompleted) {
        completer.completeError('$this : failed : $evt');
      }
    });

    request.onReadyStateChange.listen((evt) {
      if (request.readyState == HttpRequest.HEADERS_RECEIVED) {
        if (!completer.isCompleted) {
          completer.complete(response);
        }
      }
    });

    return completer.future;
  }

  @override
  Future<api.Response> get(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding encoding = utf8}) {
    var request = newRequest();
    if (responseType != null) request.responseType = responseType;
    _openRequest(request, "GET", url.toString());
    setHeaders(request, headers);

    if (body != null) {
      dynamic data;
      if (body is String) {
        data = body;
      } else if (body is List) {
        data = body;
      } else if (body is Map) {
        request.setRequestHeader(
            "Content-Type", "application/x-www-form-urlencoded");
        data = mapToQuery(body as Map<String, String>, encoding: encoding);
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
      request.send(data);
    } else {
      request.send();
    }

    return reponseFromRequest(request);
  }

  @override
  Future<api.Response> post(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding? encoding = utf8,
      api.ProgressCallback? progressCallback}) {
    return putOrPost("POST", url,
        headers: headers,
        body: body,
        responseType: responseType,
        encoding: encoding,
        progressCallback: progressCallback);
  }

  Future<api.Response> putOrPost(String verb, url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding? encoding,
      api.ProgressCallback? progressCallback}) {
    var request = newRequest();
    if (responseType != null) request.responseType = responseType;
    _openRequest(request, verb, url.toString());

    if (progressCallback != null) {
      request.upload.onProgress.listen(progressCallback);
    }

    setHeaders(request, headers);
    dynamic data;
    if (body != null) {
      if (body is String) {
        data = body;
      } else if (body is List) {
        data = body;
        if (data is Uint8List) {
          data = Blob([data]);

          Blob([data]);
        }
      } else if (body is Map) {
        request.setRequestHeader(
            "Content-Type", "application/x-www-form-urlencoded");
        data = mapToQuery(body as Map<String, String>, encoding: encoding);
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    request.send(data);
    return reponseFromRequest(request);
  }

  @override
  Future<api.Response> put(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding? encoding = utf8,
      api.ProgressCallback? progressCallback}) {
    return putOrPost("PUT", url,
        headers: headers,
        body: body,
        responseType: responseType,
        encoding: encoding,
        progressCallback: progressCallback);
  }

  @override
  Future<api.Response> delete(url, {Map<String, String>? headers}) {
    var request = newRequest();
    _openRequest(request, "DELETE", url.toString());
    setHeaders(request, headers);
    request.send();
    return reponseFromRequest(request);
  }

  @override
  void close({bool? force}) {}

  String mapToQuery(Map<String, String> map, {Encoding? encoding}) {
    var pairs = <List<String>>[];
    map.forEach((key, value) => pairs.add([
          Uri.encodeQueryComponent(key, encoding: encoding!),
          Uri.encodeQueryComponent(value, encoding: encoding)
        ]));
    return pairs.map((pair) => "${pair[0]}=${pair[1]}").join("&");
  }
}

class Response implements api.Response {
  HttpRequest request;
  Response(this.request);
  @override
  int? get statusCode => request.status;
  @override
  Map get headers => request.responseHeaders;
  @override
  Object? get body => request.response;
}

class StreamResponse extends api.StreamResponse {
  HttpRequest request;
  String? responseType;
  Encoding? encoding;
  int _bytesOffset;

  late StreamController _controler;

  StreamResponse(this.request, {this.responseType, this.encoding})
      : _bytesOffset = 0 {
    assert(request.readyState < HttpRequest.LOADING);
    assert(request.responseType == api.HttpClient.RESPONSE_TYPE_STRING);

    _controler = StreamController(sync: false);

    request.onError.listen(_controler.addError);

    request.onReadyStateChange.listen((evt) {
      var bytes = _readNextBytes(evt);
      if (bytes != null) {
        _controler.add(bytes);
      }
      if (request.readyState == HttpRequest.DONE) {
        Future.delayed(Duration(milliseconds: 1), () {
          if (!_controler.isClosed) {
            _controler.close();
          }
        });
      }
    });
  }
  @override
  int? get statusCode => request.status;
  @override
  Map get headers => request.responseHeaders;
  @override
  Stream get stream => _controler.stream;

  _readNextBytes(evt) {
    if (request.readyState < HttpRequest.LOADING) return null;

    var str = request.responseText;
    if (str == null) return null;

    var bytes = Uint8List.fromList(str.substring(_bytesOffset).codeUnits);
    _bytesOffset += bytes.length;
    if (bytes.isEmpty) return null;
    return bytes;
  }
}
