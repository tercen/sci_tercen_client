part of sci_client_base;

class OperatorServiceBase extends HttpClientService<Operator>
    implements api.OperatorService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/operator");
  String get serviceName => "Operator";

  Map toJson(Operator object) => object.toJson();
  Operator fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return OperatorBase.fromJson(m);
    return new Operator.json(m);
  }
}
