part of sci_client_base;

class ActivityServiceBase extends HttpClientService<Activity>
    implements api.ActivityService {
  late ServiceFactoryBase factory;

  Uri get uri => Uri.parse("api/v1/activity");
  String get serviceName => "Activity";

  Map toJson(Activity object) => object.toJson();
  Activity fromJson(Map m, {bool useFactory = true}) {
    if (useFactory) return ActivityBase.fromJson(m);
    return new Activity.json(m);
  }

  Future<List<Activity>> findByUserAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByUserAndDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<List<Activity>> findByTeamAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByTeamAndDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }

  Future<List<Activity>> findByProjectAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      service.AclContext? aclContext}) {
    return findStartKeys("findByProjectAndDate",
        startKey: startKey,
        endKey: endKey,
        limit: limit,
        skip: skip,
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
  }
}
