part of sci_client_base;

class SubscriptionPlanServiceBase extends HttpClientService<SubscriptionPlan>
    implements api.SubscriptionPlanService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/subscription");
  String get serviceName => "SubscriptionPlan";

  Map toJson(SubscriptionPlan object) => object.toJson();
  SubscriptionPlan fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return SubscriptionPlanBase.fromJson(m);
    return new SubscriptionPlan.json(m);
  }

  Future<List<SubscriptionPlan>> findByOwner(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("findByOwner",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  Future<List<SubscriptionPlan>> findSubscriptionPlanByCheckoutSessionId(
      {required List keys,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findKeys("checkoutSessionId",
        keys: keys, useFactory: useFactory, aclContext: aclContext);
  }

  Future<List<SubscriptionPlan>> getSubscriptionPlans(String userId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/subscription" + "/" + "getSubscriptionPlans");
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
    return answer as List<SubscriptionPlan>;
  }

  Future<List<Plan>> getPlans(String userId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/subscription" + "/" + "getPlans");
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
    return answer as List<Plan>;
  }

  Future<SubscriptionPlan> createSubscriptionPlan(
      String userId, String plan, String successUrl, String cancelUrl,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri =
          Uri.parse("api/v1/subscription" + "/" + "createSubscriptionPlan");
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
    return answer as SubscriptionPlan;
  }

  Future<dynamic> setSubscriptionPlanStatus(
      String subscriptionPlanId, String status,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri =
          Uri.parse("api/v1/subscription" + "/" + "setSubscriptionPlanStatus");
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

  Future<SubscriptionPlan> updatePaymentMethod(
      String subscriptionPlanId, String successUrl, String cancelUrl,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/subscription" + "/" + "updatePaymentMethod");
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
    return answer as SubscriptionPlan;
  }

  Future<dynamic> setUpdatePaymentMethodStatus(
      String subscriptionPlanId, String status,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse(
          "api/v1/subscription" + "/" + "setUpdatePaymentMethodStatus");
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

  Future<dynamic> cancelSubscription(String subscriptionPlanId,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/subscription" + "/" + "cancelSubscription");
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

  Future<dynamic> upgradeSubscription(String subscriptionPlanId, String plan,
      {service.AclContext? aclContext}) async {
    var answer;
    try {
      var uri = Uri.parse("api/v1/subscription" + "/" + "upgradeSubscription");
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
