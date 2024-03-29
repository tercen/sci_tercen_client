part of sci_client_base;

class TableSchemaServiceBase extends HttpClientService<Schema>
    implements api.TableSchemaService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/schema");
  String get serviceName => "Schema";

  Map toJson(Schema object) => object.toJson();
  Schema fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return SchemaBase.fromJson(m);
    return new Schema.json(m);
  }

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

  Future<List<Schema>> findByQueryHash(List<String> ids,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/schema" + "/" + "findByQueryHash");
      var params = {};
      params["ids"] = ids;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
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
    return answer as List<Schema>;
  }

  Future<Table> select(
      String tableId, List<String> cnames, int offset, int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/schema" + "/" + "select");
      var params = {};
      params["tableId"] = tableId;
      params["cnames"] = cnames;
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
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
    return answer as Table;
  }

  Future<Table> selectPairwise(
      String tableId, List<String> cnames, int offset, int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/schema" + "/" + "selectPairwise");
      var params = {};
      params["tableId"] = tableId;
      params["cnames"] = cnames;
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
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
    return answer as Table;
  }

  Stream<List<int>> selectStream(
      String tableId, List<String> cnames, int offset, int limit,
      {service.AclContext? aclContext}) {
    var answer;
    try {
      var uri = Uri.parse("api/v1/schema" + "/" + "selectStream");
      var params = {};
      params["tableId"] = tableId;
      params["cnames"] = cnames;
      params["offset"] = offset;
      params["limit"] = limit;
      var resFut = client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
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

  Stream<List<int>> selectFileContentStream(String tableId, String filename,
      {service.AclContext? aclContext}) {
    var answer;
    try {
      var uri = Uri.parse("api/v1/schema" + "/" + "selectFileContentStream");
      var params = {};
      params["tableId"] = tableId;
      params["filename"] = filename;
      var geturi = getServiceUri(uri)
          .replace(queryParameters: {"params": json.encode(params)});
      var resFut = client.get(geturi, responseType: contentCodec.responseType);
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

  Stream<List<int>> selectCSV(String tableId, List<String> cnames, int offset,
      int limit, String separator, bool quote, String encoding,
      {service.AclContext? aclContext}) {
    var answer;
    try {
      var uri = Uri.parse("api/v1/schema" + "/" + "selectCSV");
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
      var resFut = client.get(geturi, responseType: contentCodec.responseType);
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
