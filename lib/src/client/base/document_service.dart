part of sci_client_base;

class DocumentServiceBase extends HttpClientService<Document>
    implements api.DocumentService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/d");
  String get serviceName => "Document";

  Map toJson(Document object) => object.toJson();
  Document fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return DocumentBase.fromJson(m);
    return new Document.json(m);
  }

  Future<List<Document>> findWorkflowByTagOwnerCreatedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findWorkflowByTagOwnerCreatedDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<List<Document>> findProjectByOwnersAndName(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findProjectByOwnersAndName",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<List<Document>> findProjectByOwnersAndCreatedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findProjectByOwnersAndCreatedDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<List<Document>> findOperatorByOwnerLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findOperatorByOwnerLastModifiedDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<List<Document>> findOperatorByUrlAndVersion(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findOperatorByUrlAndVersion",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<SearchResult> search(
      String query, int limit, bool useFactory, String bookmark,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/d" + "/" + "search");
      var params = {};
      params["query"] = query;
      params["limit"] = limit;
      params["useFactory"] = useFactory;
      params["bookmark"] = bookmark;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = SearchResultBase.fromJson(
            contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as SearchResult;
  }

  Future<List<Document>> getLibrary(String projectId, List<String> teamIds,
      List<String> docTypes, List<String> tags, int offset, int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/d" + "/" + "getLibrary");
      var params = {};
      params["projectId"] = projectId;
      params["teamIds"] = teamIds;
      params["docTypes"] = docTypes;
      params["tags"] = tags;
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => DocumentBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<Document>;
  }

  Future<List<Document>> getTercenLibrary(int offset, int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/d" + "/" + "getTercenLibrary");
      var params = {};
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => DocumentBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<Document>;
  }

  Future<List<Operator>> getTercenOperatorLibrary(int offset, int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/d" + "/" + "getTercenOperatorLibrary");
      var params = {};
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => OperatorBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<Operator>;
  }

  Future<List<Document>> getTercenWorkflowLibrary(int offset, int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/d" + "/" + "getTercenWorkflowLibrary");
      var params = {};
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => DocumentBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<Document>;
  }

  Future<List<Document>> getTercenAppLibrary(int offset, int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/d" + "/" + "getTercenAppLibrary");
      var params = {};
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => DocumentBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<Document>;
  }

  Future<List<Document>> getTercenDatasetLibrary(int offset, int limit,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/d" + "/" + "getTercenDatasetLibrary");
      var params = {};
      params["offset"] = offset;
      params["limit"] = limit;
      var response = await client.post(getServiceUri(uri),
          headers: contentCodec.contentTypeHeader,
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => DocumentBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<Document>;
  }
}
