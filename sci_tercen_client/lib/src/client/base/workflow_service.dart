part of sci_client_base;

class WorkflowServiceBase extends HttpClientService<Workflow>
    implements api.WorkflowService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/workflow");
  String get serviceName => "Workflow";

  Map toJson(Workflow object) => object.toJson();
  Workflow fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return WorkflowBase.fromJson(m);
    return new Workflow.json(m);
  }

  Future<CubeQuery> getCubeQuery(String workflowId, String stepId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/workflow" + "/" + "getCubeQuery");
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
    return answer as CubeQuery;
  }

  Future<Workflow> copyApp(String workflowId, String projectId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/workflow" + "/" + "copyApp");
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
    return answer as Workflow;
  }
}
