part of sci_client_base;

class OperatorServiceBase extends HttpClientService<Operator>
    implements api.OperatorService {
  late ServiceFactoryBase factory;

  @override
  Uri get uri => Uri.parse("api/v1/operator");
  @override
  String get serviceName => "Operator";

  @override
  Map toJson(Operator object) => object.toJson();
  @override
  Operator fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return OperatorBase.fromJson(m);
    return Operator.json(m);
  }
}
