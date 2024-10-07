part of sci_client_base;

class CranLibraryServiceBase extends HttpClientService<RLibrary>
    implements api.CranLibraryService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/rlib");
  String get serviceName => "RLibrary";

  Map toJson(RLibrary object) => object.toJson();
  RLibrary fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return RLibraryBase.fromJson(m);
    return new RLibrary.json(m);
  }

  Future<List<RLibrary>> findByOwnerNameVersion(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByOwnerNameVersion",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Stream<List<int>> packagesGz(String repoName,
      {service.AclContext? aclContext}) {
    var answer;
    try {
      var uri = Uri.parse("api/v1/rlib" + "/" + "packagesGz");
      var params = {};
      params["repoName"] = repoName;
      var geturi = getServiceUri(uri)
          .replace(queryParameters: {"params": json.encode(params)});
      var resFut = client.get(geturi,
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType);
      resFut = resFut.then((response) {
        if (response.statusCode != 200) onResponseError(response);
        return response;
      });

      var resFut2 = resFut.then((response) => new Stream.fromIterable(
          [new Uint8List.view(response.body as ByteBuffer)]));
      answer = new async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as Stream<List<int>>;
  }

  Stream<List<int>> packagesRds(String repoName,
      {service.AclContext? aclContext}) {
    var answer;
    try {
      var uri = Uri.parse("api/v1/rlib" + "/" + "packagesRds");
      var params = {};
      params["repoName"] = repoName;
      var geturi = getServiceUri(uri)
          .replace(queryParameters: {"params": json.encode(params)});
      var resFut = client.get(geturi,
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType);
      resFut = resFut.then((response) {
        if (response.statusCode != 200) onResponseError(response);
        return response;
      });

      var resFut2 = resFut.then((response) => new Stream.fromIterable(
          [new Uint8List.view(response.body as ByteBuffer)]));
      answer = new async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as Stream<List<int>>;
  }

  Stream<List<int>> packages(String repoName,
      {service.AclContext? aclContext}) {
    var answer;
    try {
      var uri = Uri.parse("api/v1/rlib" + "/" + "packages");
      var params = {};
      params["repoName"] = repoName;
      var geturi = getServiceUri(uri)
          .replace(queryParameters: {"params": json.encode(params)});
      var resFut = client.get(geturi,
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType);
      resFut = resFut.then((response) {
        if (response.statusCode != 200) onResponseError(response);
        return response;
      });

      var resFut2 = resFut.then((response) => new Stream.fromIterable(
          [new Uint8List.view(response.body as ByteBuffer)]));
      answer = new async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as Stream<List<int>>;
  }

  Stream<List<int>> archive(String repoName, String package, String filename,
      {service.AclContext? aclContext}) {
    var answer;
    try {
      var uri = Uri.parse("api/v1/rlib" + "/" + "archive");
      var params = {};
      params["repoName"] = repoName;
      params["package"] = package;
      params["filename"] = filename;
      var geturi = getServiceUri(uri)
          .replace(queryParameters: {"params": json.encode(params)});
      var resFut = client.get(geturi,
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType);
      resFut = resFut.then((response) {
        if (response.statusCode != 200) onResponseError(response);
        return response;
      });

      var resFut2 = resFut.then((response) => new Stream.fromIterable(
          [new Uint8List.view(response.body as ByteBuffer)]));
      answer = new async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as Stream<List<int>>;
  }

  Stream<List<int>> package(String repoName, String package,
      {service.AclContext? aclContext}) {
    var answer;
    try {
      var uri = Uri.parse("api/v1/rlib" + "/" + "package");
      var params = {};
      params["repoName"] = repoName;
      params["package"] = package;
      var geturi = getServiceUri(uri)
          .replace(queryParameters: {"params": json.encode(params)});
      var resFut = client.get(geturi,
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType);
      resFut = resFut.then((response) {
        if (response.statusCode != 200) onResponseError(response);
        return response;
      });

      var resFut2 = resFut.then((response) => new Stream.fromIterable(
          [new Uint8List.view(response.body as ByteBuffer)]));
      answer = new async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as Stream<List<int>>;
  }
}
