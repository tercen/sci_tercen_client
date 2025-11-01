part of sci_client_base;

class SubscriptionPlanServiceBase extends HttpClientService<SubscriptionPlan>
    implements api.SubscriptionPlanService {
  late ServiceFactoryBase factory;

  @override
  Uri get uri => Uri.parse("api/v1/subscription");
  @override
  String get serviceName => "SubscriptionPlan";

  @override
  Map toJson(SubscriptionPlan object) => object.toJson();
  @override
  SubscriptionPlan fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return SubscriptionPlanBase.fromJson(m);
    return SubscriptionPlan.json(m);
  }

  @override
  Future<List<SubscriptionPlan>> findByOwner(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("findByOwner",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  @override
  Future<List<SubscriptionPlan>> findSubscriptionPlanByCheckoutSessionId(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("checkoutSessionId",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  @override
  Future<List<SubscriptionPlan>> getSubscriptionPlans(String userId,
      {service.AclContext? aclContext}) async {
    List<SubscriptionPlan> answer;
    try {
      var uri = Uri.parse("api/v1/subscription" "/" "getSubscriptionPlans");
      var params = {};
      params["userId"] = userId;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => SubscriptionPlanBase.fromJson(m as Map))
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
  Future<List<Plan>> getPlans(String userId,
      {service.AclContext? aclContext}) async {
    List<Plan> answer;
    try {
      var uri = Uri.parse("api/v1/subscription" "/" "getPlans");
      var params = {};
      params["userId"] = userId;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = (contentCodec.decode(response.body) as List)
            .map((m) => PlanBase.fromJson(m as Map))
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
  Future<SubscriptionPlan> createSubscriptionPlan(
      String userId, String plan, String successUrl, String cancelUrl,
      {service.AclContext? aclContext}) async {
    SubscriptionPlan answer;
    try {
      var uri =
          Uri.parse("api/v1/subscription" "/" "createSubscriptionPlan");
      var params = {};
      params["userId"] = userId;
      params["plan"] = plan;
      params["successUrl"] = successUrl;
      params["cancelUrl"] = cancelUrl;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = SubscriptionPlanBase.fromJson(
            contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<dynamic> setSubscriptionPlanStatus(
      String subscriptionPlanId, String status,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri =
          Uri.parse("api/v1/subscription" "/" "setSubscriptionPlanStatus");
      var params = {};
      params["subscriptionPlanId"] = subscriptionPlanId;
      params["status"] = status;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = null;
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as dynamic;
  }

  @override
  Future<SubscriptionPlan> updatePaymentMethod(
      String subscriptionPlanId, String successUrl, String cancelUrl,
      {service.AclContext? aclContext}) async {
    SubscriptionPlan answer;
    try {
      var uri = Uri.parse("api/v1/subscription" "/" "updatePaymentMethod");
      var params = {};
      params["subscriptionPlanId"] = subscriptionPlanId;
      params["successUrl"] = successUrl;
      params["cancelUrl"] = cancelUrl;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = SubscriptionPlanBase.fromJson(
            contentCodec.decode(response.body) as Map);
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer;
  }

  @override
  Future<dynamic> setUpdatePaymentMethodStatus(
      String subscriptionPlanId, String status,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse(
          "api/v1/subscription" "/" "setUpdatePaymentMethodStatus");
      var params = {};
      params["subscriptionPlanId"] = subscriptionPlanId;
      params["status"] = status;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = null;
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as dynamic;
  }

  @override
  Future<dynamic> cancelSubscription(String subscriptionPlanId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/subscription" "/" "cancelSubscription");
      var params = {};
      params["subscriptionPlanId"] = subscriptionPlanId;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = null;
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as dynamic;
  }

  @override
  Future<dynamic> upgradeSubscription(String subscriptionPlanId, String plan,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/subscription" "/" "upgradeSubscription");
      var params = {};
      params["subscriptionPlanId"] = subscriptionPlanId;
      params["plan"] = plan;
      var response = await client.post(getServiceUri(uri),
          headers: getHeaderForAclContext(
              contentCodec.contentTypeHeader, aclContext),
          responseType: contentCodec.responseType,
          body: contentCodec.encode(params));
      if (response.statusCode != 200) {
        onResponseError(response);
      } else {
        answer = null;
      }
    } on ServiceError {
      rethrow;
    } catch (e, st) {
      onError(e, st);
    }
    return answer as dynamic;
  }
}
