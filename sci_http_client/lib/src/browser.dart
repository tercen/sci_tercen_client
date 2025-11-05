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

  XMLHttpRequest newRequest() {
    var request = XMLHttpRequest();
    return request;
  }

  void setHeaders(XMLHttpRequest request, Map<String, String>? headers) {
    if (withCredentials!) {
      request.withCredentials = withCredentials!;
    }
    if (headers == null) return;
    headers.forEach((k, v) => request.setRequestHeader(k, v));
  }

  Future<api.Response> reponseFromRequest(XMLHttpRequest request) {
    if (request.readyState == XMLHttpRequest.DONE) {
      return Future.value(Response(request));
    }
    var completer = Completer<Response>();

    request.addEventListener(
        'load',
        (Event event) {
          completer.complete(Response(request));
        }.toJS);

    request.addEventListener(
        'error',
        (Event evt) {
          var error = api.HttpClientError(
              500, "connection.unvailable", "Host unreachable.");
          completer.completeError(error);
        }.toJS);

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

  void _openRequest(XMLHttpRequest request, verb, url) {
    request.open(verb as String, url.toString(), true);
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

    request.addEventListener(
        'error',
        (Event evt) {
          if (!completer.isCompleted) {
            completer.completeError('$this : failed : $evt');
          }
        }.toJS);

    request.addEventListener(
        'readystatechange',
        (Event evt) {
          if (request.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
            if (!completer.isCompleted) {
              completer.complete(response);
            }
          }
        }.toJS);

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
      request.upload.addEventListener(
          'progress',
          (Event event) {
            progressCallback(event);
          }.toJS);
    }

    setHeaders(request, headers);
    dynamic data;
    if (body != null) {
      if (body is String) {
        data = body;
      } else if (body is List) {
        data = body;
        if (data is Uint8List) {
          data = Blob([data.toJS].toJS);
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
  XMLHttpRequest request;
  Response(this.request);
  @override
  int? get statusCode => request.status;
  @override
  Map get headers {
    final headersMap = <String, String>{};
    final headersString = request.getAllResponseHeaders();
    if (headersString.isNotEmpty) {
      for (var line in headersString.split('\r\n')) {
        if (line.isEmpty) continue;
        var idx = line.indexOf(':');
        if (idx > 0) {
          headersMap[line.substring(0, idx).trim()] =
              line.substring(idx + 1).trim();
        }
      }
    }
    return headersMap;
  }

  @override
  Object? get body {
    final response = request.response;
    // Convert ArrayBuffer to ByteBuffer for wasm compatibility
    if (response != null &&
        response is JSArrayBuffer &&
        request.responseType == 'arraybuffer') {
      // In wasm, response is a JSArrayBuffer; convert to Dart ByteBuffer
      return response.toDart;
    }
    return response;
  }
}

class StreamResponse extends api.StreamResponse {
  XMLHttpRequest request;
  String? responseType;
  Encoding? encoding;
  int _bytesOffset;

  late StreamController _controler;

  StreamResponse(this.request, {this.responseType, this.encoding})
      : _bytesOffset = 0 {
    assert(request.readyState < XMLHttpRequest.LOADING);
    assert(request.responseType == api.HttpClient.RESPONSE_TYPE_STRING);

    _controler = StreamController(sync: false);

    request.addEventListener(
        'error',
        (Event event) {
          _controler.addError(event);
        }.toJS);

    request.addEventListener(
        'readystatechange',
        (Event evt) {
          var bytes = _readNextBytes(evt);
          if (bytes != null) {
            _controler.add(bytes);
          }
          if (request.readyState == XMLHttpRequest.DONE) {
            Future.delayed(Duration(milliseconds: 1), () {
              if (!_controler.isClosed) {
                _controler.close();
              }
            });
          }
        }.toJS);
  }
  @override
  int? get statusCode => request.status;
  @override
  Map get headers {
    final headersMap = <String, String>{};
    final headersString = request.getAllResponseHeaders();
    if (headersString.isNotEmpty) {
      for (var line in headersString.split('\r\n')) {
        if (line.isEmpty) continue;
        var idx = line.indexOf(':');
        if (idx > 0) {
          headersMap[line.substring(0, idx).trim()] =
              line.substring(idx + 1).trim();
        }
      }
    }
    return headersMap;
  }

  @override
  Stream get stream => _controler.stream;

  _readNextBytes(evt) {
    if (request.readyState < XMLHttpRequest.LOADING) return null;

    var str = request.responseText;
    if (str.isEmpty) return null;

    var bytes = Uint8List.fromList(str.substring(_bytesOffset).codeUnits);
    _bytesOffset += bytes.length;
    if (bytes.isEmpty) return null;
    return bytes;
  }
}
