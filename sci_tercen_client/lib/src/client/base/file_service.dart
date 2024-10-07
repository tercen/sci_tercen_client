part of sci_client_base;

class FileServiceBase extends HttpClientService<FileDocument>
    implements api.FileService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/file");
  String get serviceName => "FileDocument";

  Map toJson(FileDocument object) => object.toJson();
  FileDocument fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return FileDocumentBase.fromJson(m);
    return new FileDocument.json(m);
  }

  Future<List<FileDocument>> findFileByWorkflowIdAndStepId(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findFileByWorkflowIdAndStepId",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<List<FileDocument>> findByDataUri(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByDataUri",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<FileDocument> upload(FileDocument file, Stream<List> bytes,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/file" + "/" + "upload");
      var parts = <MultiPart>[];
      parts.add(MultiPart({"Content-Type": "application/json"},
          string: json.encode([file.toJson()])));
      parts.add(MultiPart({"Content-Type": "application/octet-stream"},
          stream: bytes.cast<List<int>>()));
      var frontier = "ab63a1363ab349aa8627be56b0479de2";
      var bodyBytes = await new MultiPartMixTransformer(frontier).encode(parts);
      var headers = {"Content-Type": "multipart/mixed; boundary=${frontier}"};
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(headers, aclContext),
          body: bodyBytes,
          responseType: "arraybuffer");
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = FileDocumentBase.fromJson(
            contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as FileDocument;
  }

  Future<FileDocument> append(FileDocument file, Stream<List> bytes,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/file" + "/" + "append");
      var parts = <MultiPart>[];
      parts.add(MultiPart({"Content-Type": "application/json"},
          string: json.encode([file.toJson()])));
      parts.add(MultiPart({"Content-Type": "application/octet-stream"},
          stream: bytes.cast<List<int>>()));
      var frontier = "ab63a1363ab349aa8627be56b0479de2";
      var bodyBytes = await new MultiPartMixTransformer(frontier).encode(parts);
      var headers = {"Content-Type": "multipart/mixed; boundary=${frontier}"};
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(headers, aclContext),
          body: bodyBytes,
          responseType: "arraybuffer");
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = FileDocumentBase.fromJson(
            contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as FileDocument;
  }

  Stream<List<int>> download(String fileDocumentId,
      {service.AclContext? aclContext}) {
    var answer;
    try {
      var uri = Uri.parse("api/v1/file" + "/" + "download");
      var params = {};
      params["fileDocumentId"] = fileDocumentId;
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
