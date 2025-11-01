part of sci_client_base;

class WorkflowServiceBase extends HttpClientService<Workflow>
    implements api.WorkflowService {
  late ServiceFactoryBase factory;

  @override
  Uri get uri => Uri.parse("api/v1/workflow");
  @override
  String get serviceName => "Workflow";

  @override
  Map toJson(Workflow object) => object.toJson();
  @override
  Workflow fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return WorkflowBase.fromJson(m);
    return Workflow.json(m);
  }

  @override
  Future<CubeQuery> getCubeQuery(String workflowId, String stepId,
      {service.AclContext? aclContext}) async {
    CubeQuery answer;
    try {
      var uri = Uri.parse("api/v1/workflow" "/" "getCubeQuery");
      var params = {};
      params["workflowId"] = workflowId;
      params["stepId"] = stepId;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            CubeQueryBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<Workflow> copyApp(String workflowId, String projectId,
      {service.AclContext? aclContext}) async {
    Workflow answer;
    try {
      var uri = Uri.parse("api/v1/workflow" "/" "copyApp");
      var params = {};
      params["workflowId"] = workflowId;
      params["projectId"] = projectId;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer =
            WorkflowBase.fromJson(contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }
}
