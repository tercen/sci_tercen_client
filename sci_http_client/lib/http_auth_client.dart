library http_auth_client;

import 'dart:convert';
import 'dart:async';
import 'http_client.dart' as api;
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class HttpAuthBaseClient implements api.HttpClient {
  api.HttpClient? _client;

  HttpAuthBaseClient([this._client]) {
    _client ??= api.HttpClient();
  }

  @override
  WebSocketChannel webSocketChannel(url) =>
      throw UnimplementedError('webSocketChannel');

  @override
  Uri resolveUri(Uri uri, String path) => api.HttpClient.ResolveUri(uri, path);

  Future<Map<String, String>> addAuthHeader(Map<String, String>? headers);

  @override
  void close({bool? force}) => _client!.close(force: force);

  @override
  Future<api.Response> put(url,
      {Map<String, String>? headers,
      body,
      Encoding? encoding,
      String? responseType,
      api.ProgressCallback? progressCallback}) {
    return addAuthHeader(headers).then((h) {
      return _client!.put(url,
          headers: h,
          body: body,
          encoding: encoding,
          responseType: responseType,
          progressCallback: progressCallback);
    });
  }

  @override
  Future<api.Response> get(url,
      {Map<String, String>? headers, String? responseType}) {
    return addAuthHeader(headers).then((h) {
      return _client!.get(url, headers: h, responseType: responseType);
    });
  }

  @override
  Future<api.Response> delete(url, {Map<String, String>? headers}) {
    return addAuthHeader(headers).then((h) {
      return _client!.delete(url, headers: h);
    });
  }

  @override
  Future<api.Response> head(url, {Map<String, String>? headers}) {
    return addAuthHeader(headers).then((h) {
      return _client!.head(url, headers: h);
    });
  }

  @override
  Future<api.Response> post(url,
      {Map<String, String>? headers,
      body,
      Encoding? encoding,
      String? responseType,
      api.ProgressCallback? progressCallback}) {
    return addAuthHeader(headers).then((h) {
      return _client!.post(url,
          headers: h,
          body: body,
          encoding: encoding,
          responseType: responseType,
          progressCallback: progressCallback);
    });
  }

  @override
  Future<api.StreamResponse> getStream(url,
      {Map<String, String>? headers,
      body,
      String? responseType,
      Encoding encoding = utf8}) {
    throw 'not impl';
  }
}

class HttpAuthClient extends HttpAuthBaseClient {
  String authorization;

  HttpAuthClient(this.authorization, [api.HttpClient? client]) : super(client);

  @override
  WebSocketChannel webSocketChannel(url) {
    Uri uri;
    if (url is Uri) {
      uri = url;
    } else if (url is String) {
      uri = Uri.parse(url);
    } else {
      throw 'webSocketChannel : bad url';
    }
    var params = Map<String, String>.from(uri.queryParameters);
    params['authorization'] = authorization;
    uri = uri.replace(queryParameters: params);
    return _client!.webSocketChannel(uri);
  }

  @override
  Future<Map<String, String>> addAuthHeader(
      Map<String, String>? headers) async {
    var map = headers ?? <String, String>{};
    map["authorization"] = authorization;
    return map;
  }
}
