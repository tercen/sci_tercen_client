part of sci_client_base;

class TableSchemaServiceBase extends HttpClientService<Schema>
    implements api.TableSchemaService {
  late ServiceFactoryBase factory;

  @override
  Uri get uri => Uri.parse("api/v1/schema");
  @override
  String get serviceName => "Schema";

  @override
  Map toJson(Schema object) => object.toJson();
  @override
  Schema fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return SchemaBase.fromJson(m);
    return Schema.json(m);
  }

  @override
  Future<List<Schema>> findSchemaByDataDirectory(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findSchemaByDataDirectory",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  @override
  Future<Schema> uploadTable(FileDocument file, Stream<List> bytes,
      {service.AclContext? aclContext}) async {
    Schema answer;
    try {
      var uri = Uri.parse("api/v1/schema" "/" "uploadTable");
      var parts = <MultiPart>[];
      parts.add(MultiPart({"Content-Type": "application/json"},
          string: json.encode([file.toJson()])));
      parts.add(MultiPart({"Content-Type": "application/octet-stream"},
          stream: bytes.cast<List<int>>()));
      var frontier = "ab63a1363ab349aa8627be56b0479de2";
      var bodyBytes = await MultiPartMixTransformer(frontier).encode(parts);
      var headers = {"Content-Type": "multipart/mixed; boundary=$frontier"};
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(headers, aclContext),
          body: bodyBytes,
          responseType: "arraybuffer");
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = SchemaBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<List<Schema>> findByQueryHash(List<String> ids,
      {service.AclContext? aclContext}) async {
    List<Schema> answer;
    try {
      var uri = Uri.parse("api/v1/schema" "/" "findByQueryHash");
      var params = {};
      params["ids"] = ids;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => SchemaBase.fromJson(m as Map))
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
  Future<Table> select(
      String tableId, List<String> cnames, int offset, int limit,
      {service.AclContext? aclContext}) async {
    Table answer;
    try {
      var uri = Uri.parse("api/v1/schema" "/" "select");
      var params = {};
      params["tableId"] = tableId;
      params["cnames"] = cnames;
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = TableBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<Table> selectPairwise(
      String tableId, List<String> cnames, int offset, int limit,
      {service.AclContext? aclContext}) async {
    Table answer;
    try {
      var uri = Uri.parse("api/v1/schema" "/" "selectPairwise");
      var params = {};
      params["tableId"] = tableId;
      params["cnames"] = cnames;
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = TableBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Stream<List<int>> selectStream(
      String tableId, List<String> cnames, int offset, int limit,
      {service.AclContext? aclContext}) {
    Stream<List<int>> answer;
    try {
      var uri = Uri.parse("api/v1/schema" "/" "selectStream");
      var params = {};
      params["tableId"] = tableId;
      params["cnames"] = cnames;
      params["offset"] = offset;
      params["limit"] = limit;
      var resFut = client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      resFut = resFut.then((response) {
        if (response.statusCode != 200) onResponseError(response);
        return response;
      });

      var resFut2 = resFut.then((response) => Stream.fromIterable(
          [Uint8List.view(response.body as ByteBuffer)]));
      answer = async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Stream<List<int>> streamTable(String tableId, List<String> cnames, int offset,
      int limit, String binaryFormat,
      {service.AclContext? aclContext}) {
    Stream<List<int>> answer;
    try {
      var uri = Uri.parse("api/v1/schema" "/" "streamTable");
      var params = {};
      params["tableId"] = tableId;
      params["cnames"] = cnames;
      params["offset"] = offset;
      params["limit"] = limit;
      params["binaryFormat"] = binaryFormat;
      var resFut = client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      resFut = resFut.then((response) {
        if (response.statusCode != 200) onResponseError(response);
        return response;
      });

      var resFut2 = resFut.then((response) => Stream.fromIterable(
          [Uint8List.view(response.body as ByteBuffer)]));
      answer = async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Stream<List<int>> selectFileContentStream(String tableId, String filename,
      {service.AclContext? aclContext}) {
    Stream<List<int>> answer;
    try {
      var uri = Uri.parse("api/v1/schema" "/" "selectFileContentStream");
      var params = {};
      params["tableId"] = tableId;
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

      var resFut2 = resFut.then((response) => Stream.fromIterable(
          [Uint8List.view(response.body as ByteBuffer)]));
      answer = async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Stream<List<int>> getFileMimetypeStream(String tableId, String filename,
      {service.AclContext? aclContext}) {
    Stream<List<int>> answer;
    try {
      var uri = Uri.parse("api/v1/schema" "/" "getFileMimetypeStream");
      var params = {};
      params["tableId"] = tableId;
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

      var resFut2 = resFut.then((response) => Stream.fromIterable(
          [Uint8List.view(response.body as ByteBuffer)]));
      answer = async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Stream<List<int>> selectCSV(String tableId, List<String> cnames, int offset,
      int limit, String separator, bool quote, String encoding,
      {service.AclContext? aclContext}) {
    Stream<List<int>> answer;
    try {
      var uri = Uri.parse("api/v1/schema" "/" "selectCSV");
      var params = {};
      params["tableId"] = tableId;
      params["cnames"] = cnames;
      params["offset"] = offset;
      params["limit"] = limit;
      params["separator"] = separator;
      params["quote"] = quote;
      params["encoding"] = encoding;
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

      var resFut2 = resFut.then((response) => Stream.fromIterable(
          [Uint8List.view(response.body as ByteBuffer)]));
      answer = async.LazyStream(() => resFut2).cast<List<int>>();
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }
}
