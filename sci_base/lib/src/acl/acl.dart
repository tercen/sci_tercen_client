part of '../../sci_acl.dart';

abstract class AclContextFactory {
  static AclContextFactory? _CURRENT;
  static setCurrent(AclContextFactory current) {
    _CURRENT = current;
  }

  factory AclContextFactory() {
    _CURRENT ??= AclContextFactoryImpl();
    return _CURRENT!;
  }
//  AclContext aclContextFromJson(Map m);
  Future<AclContext> fromUsername(String domain, String username);
//  AclContext fromWorkflowId(String workflowId);
  AclContext root(String domain);
  Future<AclContext> fromAuthorization(String domain, String authorization);
}

class AccessManagerEvent {
  static const String TYPE_CREATE = 'create';
  static const String TYPE_UPDATE = 'update';
  static const String TYPE_DELETE = 'delete';
  String type;
  AclContext context;
  dynamic object;

  AccessManagerEvent.create(this.context, this.object) : type = TYPE_CREATE;
  AccessManagerEvent.update(this.context, this.object) : type = TYPE_UPDATE;
  AccessManagerEvent.delete(this.context, this.object) : type = TYPE_DELETE;

  bool get isCreate => type == TYPE_CREATE;
  bool get isUpdate => type == TYPE_UPDATE;
  bool get isDelete => type == TYPE_DELETE;
}

abstract class AccessManager {
  Future<bool> canAccessObjects(
      String accessType, AclContext? context, List objects);
  Future<List<T>> filterCanAccessObjects<T>(
      String accessType, AclContext? context, List<T> objects);
  Future<bool> canAccess(String accessType, AclContext? context, Acl acl);
  Stream<AccessManagerEvent> get events;

  void sendEvent(AccessManagerEvent evt);
}

class NullAccessManager extends AccessManager {
  @override
  Future<bool> canAccessObjects(
      String accessType, AclContext? context, List objects) async {
    if (context == null) return false;
    return true;
  }

  @override
  Future<List<T>> filterCanAccessObjects<T>(
      String accessType, AclContext? context, List<T> objects) async {
    if (context == null) return [];
    return objects;
  }

  @override
  Future<bool> canAccess(
      String accessType, AclContext? context, Acl acl) async {
    if (context == null) return false;
    return true;
  }

  @override
  // TODO: implement events
  Stream<AccessManagerEvent> get events => throw UnimplementedError();

  @override
  void sendEvent(AccessManagerEvent evt) {
    // TODO: implement sendEvent
  }
}

typedef AclContextProgressCallback = dynamic Function(dynamic evt);

abstract class AclContext {
  static String ACL_CONTEXT_HEADER = "x-sci-acl-context";
  AclContextProgressCallback? aclContextProgressCallback;
  String get domain;
  String get username;
  set username(String u);
  String get userAgent;
  set userAgent(String u);
  List<String> get roles;
  set roles(List<String> l);
  Acl get teamAcl;
  set teamAcl(Acl a);
  bool get isAdmin;
  bool get isGuest;
  bool get isAdminDelegate {
    if (roles.contains(Acl.ROOT_DELEGATE)) return true;
    return false;
  }

  Map toJson();
  Map toJsonWithAcl();

  AclContext copy();

  AclContext asAdminDelegate() {
    var ctx = copy();
    if (!ctx.roles.contains(Acl.ROOT_DELEGATE)) {
      ctx.roles.add(Acl.ROOT_DELEGATE);
    }
    return ctx;
  }
}

abstract class Acl {
  static const ROOT_DELEGATE = Principal.ROOT_DELEGATE;
  static const ROOT = Principal.ROOT;
  static const GUEST = Principal.GUEST;

  String get type;
  String get owner;
  String? get resourceId;
  String? get resourceType;
  List<Ace> get aces;
  bool get isPrivate;
  bool get isPublicWrite;
  bool get isPublicRead;

  bool canAccess(String accessType, String username);

  bool canAccessRead(String username);
  bool canAccessWrite(String username);
  bool canAccessDelete(String username);
  bool canAccessAdmin(String username);

  Ace? findFirstAce(String principalId);

  Map toJson();
}

abstract class Ace {
  List<Principal> get principals;
  List<Privilege> get privileges;
  Map toJson();
}

abstract class Principal {
  static const ROOT_DELEGATE = "_admin_delegate";
  static const ROOT = "admin";
  static const GUEST = "guest";

  static const EVERYBODY = "everybody";
  static const USER = "user";
  static const TEAM = "team";

  String get type;
  String get id;
  Map toJson();
}

abstract class Privilege {
  static const READWRITE = "readwrite";
  static const READ = "read";
  static const ADMIN = "admin";
  static const DELETE = "delete";
  String get type;
  Map toJson();

  bool get canRead;
  bool get canWrite;
  bool get canDelete;
  bool get canAdmin;

  bool hasAccessType(String type);
}
