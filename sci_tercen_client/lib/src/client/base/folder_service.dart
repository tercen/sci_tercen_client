part of sci_client_base;

class FolderServiceBase extends HttpClientService<FolderDocument>
    implements api.FolderService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/folder");
  String get serviceName => "FolderDocument";

  Map toJson(FolderDocument object) => object.toJson();
  FolderDocument fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return FolderDocumentBase.fromJson(m);
    return new FolderDocument.json(m);
  }

  Future<List<FolderDocument>> findFolderByParentFolderAndName(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findFolderByParentFolderAndName",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<FolderDocument> getOrCreate(String projectId, String path,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/folder" + "/" + "getOrCreate");
      var params = {};
      params["projectId"] = projectId;
      params["path"] = path;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = FolderDocumentBase.fromJson(
            contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as FolderDocument;
  }

  Future<List<FolderDocument>> getExternalStorageFolders(
      String projectId, String volume, String path,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/folder" + "/" + "getExternalStorageFolders");
      var params = {};
      params["projectId"] = projectId;
      params["volume"] = volume;
      params["path"] = path;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => FolderDocumentBase.fromJson(m as Map))
            .toList();
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as List<FolderDocument>;
  }
}
