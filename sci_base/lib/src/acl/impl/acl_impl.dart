part of '../../../sci_acl.dart';

class AclContextFactoryImpl implements AclContextFactory {
  @override
  AclContext root(String domain) {
    return AclContextImpl(Acl.ROOT, null, null, domain);
  }

  @override
  Future<AclContext> fromUsername(String domain, String username,
      {List<String>? roles, Acl? teamAcl}) async {
    return AclContextImpl(username, roles, teamAcl, domain);
  }

  @override
  Future<AclContext> fromAuthorization(
          String domain, String authorization) async =>
      AclTokenContextImpl(domain, authorization);
}

class AclTokenContextImpl extends AclContext {
  String authorization;
  @override
  String userAgent;
  @override
  String domain;

  AclTokenContextImpl(this.domain, this.authorization) : userAgent = '';

  @override
  AclContext copy() =>
      AclTokenContextImpl(domain, authorization)..userAgent = userAgent;

  @override
  String get username {
    throw UnimplementedError();
  }

  @override
  Map toJsonWithAcl() {
    throw UnimplementedError();
  }

  @override
  Map toJson() {
    throw UnimplementedError();
  }

  @override
  bool get isAdmin {
    throw UnimplementedError();
  }

  @override
  set teamAcl(Acl? a) {}

  @override
  Acl get teamAcl {
    throw UnimplementedError();
  }

  @override
  set roles(List<String>? l) {}

  @override
  List<String> get roles {
    throw UnimplementedError();
  }

  @override
  set username(String? u) {}

  @override
  bool get isGuest => throw UnimplementedError();
}

class AclContextImpl extends AclContext {
  static const String TYPE = "AclContext";

  @override
  String domain;
  @override
  String username;
  @override
  String userAgent;
  @override
  List<String> roles;
  @override
  Acl teamAcl;

  String? taskId;

  AclContextImpl(this.username, List<String>? roles, Acl? teamAcl, this.domain,
      {this.taskId})
      : teamAcl = teamAcl ?? AclImpl.memberShip(),
        roles = roles ?? [],
        userAgent = '';

  factory AclContextImpl.fromJson(Map m) {
    return AclContextImpl(
        m["username"],
        m["roles"],
        m["teamAcl"] == null
            ? AclImpl.memberShip()
            : AclImpl.fromJson(m["teamAcl"]),
        m["domain"]);
  }

  @override
  AclContext copy() => AclContextImpl.fromJson(toJsonWithAcl());

  @override
  bool get isAdmin {
    if (username == Acl.ROOT) return true;
    if (roles.contains(Acl.ROOT)) return true;
    return false;
  }

  String get type => TYPE;

  @override
  Map toJson() {
    return {"domain": domain, "username": username, "type": type};
  }

  @override
  Map toJsonWithAcl() {
    var m = toJson();
    m['roles'] = roles;
    m['teamAcl'] = teamAcl.toJson();
    return m;
  }

  @override

  bool get isGuest => username == 'guest';
}

class AclImpl implements Acl {
  static const DEFAULT_ACL_TYPE = "default";
  static const GROUP_ACL_TYPE = "group";
  static const MEMBER_ACL_TYPE = "member";
  static const WORKFLOW_RESOURCE_TYPE = "workflow";
  static const SCHEMA_RESOURCE_TYPE = "schema";
  static const OPERATOR_RESOURCE_TYPE = "operator";
  static const PROJECT_RESOURCE_TYPE = "project";

  // Map _data;

  String _owner;
  String _type;
  String _resourceId;
  String _resourceType;
  List<Ace> _aces;

  factory AclImpl.fromJson(Map m) {
    var type = m["type"];
    if (type == DEFAULT_ACL_TYPE) {
      return AclImpl.json(m);
    } else if (type == MEMBER_ACL_TYPE) {
      return AclImpl.json(m);
    } else
      throw "unknown acl type $type";
  }

  factory AclImpl.json(Map data) {
    var acl = AclImpl(
        data["owner"], data["type"]!, data["resourceId"], data["resourceType"]);

    var aces = data['aces'];
    if (aces != null && aces is List) {
      for (var e in aces) {
        acl.addAce(AceImpl.fromJson(e));
      }
    }

    return acl;
  }

  @override
  Map toJson() {
    return {
      "owner": _owner,
      "type": _type,
      "resourceId": _resourceId,
      "resourceType": _resourceType,
      "aces": _aces.map((e) => e.toJson()),
    };
  }

  factory AclImpl.workflow(String workflowId) {
    return AclImpl(null, DEFAULT_ACL_TYPE, workflowId, WORKFLOW_RESOURCE_TYPE);
  }

  factory AclImpl.schema(String schemaId) {
    return AclImpl(null, DEFAULT_ACL_TYPE, schemaId, SCHEMA_RESOURCE_TYPE);
  }

  factory AclImpl.operator(String operatorId) {
    return AclImpl(null, DEFAULT_ACL_TYPE, operatorId, OPERATOR_RESOURCE_TYPE);
  }

  factory AclImpl.project(String ownerUsername) {
    return AclImpl(
        ownerUsername, DEFAULT_ACL_TYPE, null, PROJECT_RESOURCE_TYPE);
  }

  factory AclImpl.memberShip([owner]) {
    return AclImpl(owner, MEMBER_ACL_TYPE, null, null);
  }

  AclImpl(String? owner, this._type, String? resourceId, String? resourceType)
      : _owner = owner ?? '',
        _resourceId = resourceId ?? '',
        _resourceType = resourceType ?? '',
        _aces = [];

  @override
  List<Ace> get aces => _aces;

  void addAce(AceImpl ace) {
    _aces.add(ace);
  }

  @override
  Ace? findFirstAce(String username) {
    return aces.firstWhereOrNull((ace) {
      if (ace.principals.isEmpty) return false;
      return ace.principals.first.id == username;
    });
  }

  /*
  if privilege is null, the user is remove from the team
   */
  void setAce(Principal principal, Privilege privilege) {
    var list = aces;
    AceImpl? ace = list.firstWhereOrNull((ace) {
      if (ace.principals.isEmpty) return false;
      return ace.principals.first.id == principal.id;
    }) as AceImpl?;
    if (ace == null) {
      ace = AceImpl()
        ..addPrincipal(principal as PrincipalImpl)
        ..addPrivilege(privilege as PrivilegeImpl);
      list.add(ace);
    } else {
      ace
        ..removePrivileges()
        ..addPrivilege(privilege as PrivilegeImpl);
    }
    _aces = list.toList();
  }

  void setAceNull(Principal principal, Privilege? privilege) {
    var list = aces;
    AceImpl? ace = list.firstWhereOrNull((ace) {
      if (ace.principals.isEmpty) return false;
      return ace.principals.first.id == principal.id;
    }) as AceImpl?;
    if (ace == null) {
      if (privilege != null) {
        ace = AceImpl()
          ..addPrincipal(principal as PrincipalImpl)
          ..addPrivilege(privilege as PrivilegeImpl);
        list.add(ace);
      }
    } else {
      if (privilege != null) {
        ace
          ..removePrivileges()
          ..addPrivilege(privilege as PrivilegeImpl);
      } else {
        list.remove(ace);
      }
    }
    _aces = list.toList();
  }

  void removeAce(AceImpl ace) {
    if (ace.principals.isEmpty) return;
    var username = ace.principals.first.id;
    _aces = _aces.where((ac) {
      if (ac.principals.isEmpty) return true;
      return ac.principals.first.id != username;
    }).toList();
  }

  @override
  String get owner => _owner;

  set owner(String o) {
    _owner = o;
  }

  @override
  String get resourceId => _resourceId;

  @override
  String get resourceType => _resourceType;

  @override
  String get type => _type;

  @override
  bool get isPrivate => !aces.any((ace) => ace.principals.isNotEmpty);

  @override
  bool get isPublicRead {
    var flag = aces
        .any((ace) => ace.principals.any((p) => p.type == Principal.EVERYBODY));
    if (!flag) return false;
    return aces
        .any((ace) => ace.privileges.any((p) => p.type == Privilege.READ));
  }

  @override
  bool get isPublicWrite {
    var flag = aces
        .any((ace) => ace.principals.any((p) => p.type == Principal.EVERYBODY));
    if (!flag) return false;
    return aces
        .any((ace) => ace.privileges.any((p) => p.type == Privilege.READWRITE));
  }

  @override
  bool canAccessRead(String username) {
    if (username == Acl.ROOT) return true;
    if (isPublicRead || isPublicWrite) return true;
    if (owner == username) return true;

    var ace = findFirstAce(username);

    if (ace == null) return false;
    var b = (ace as AceImpl).hasReadPrivilege;

    return b;
  }

  @override
  bool canAccessWrite(String username) {
    if (username == Acl.ROOT) return true;
    if (isPublicWrite) return true;
    if (owner == username) {
      return true;
    }
    var ace = findFirstAce(username);
    if (ace == null) {
      return false;
    }
    return (ace as AceImpl).hasWritePrivilege;
  }

  @override
  bool canAccessDelete(String username) {
    if (username == Acl.ROOT) return true;
    if (owner == username) return true;
    var ace = findFirstAce(username);
    if (ace == null) return false;
    return (ace as AceImpl).hasDeletePrivilege;
  }

  @override
  bool canAccessAdmin(String username) {
    if (username == Acl.ROOT) return true;
    if (owner == username) return true;
    var ace = findFirstAce(username);
    if (ace == null) return false;
    return (ace as AceImpl).hasAdminPrivilege;
  }

  @override
  bool canAccess(String accessType, String username) {
    if (username == Acl.ROOT) return true;
    if (accessType == Privilege.READ) {
      return canAccessRead(username);
    } else if (accessType == Privilege.READWRITE) {
      return canAccessWrite(username);
    } else if (accessType == Privilege.DELETE) {
      return canAccessDelete(username);
    } else if (accessType == Privilege.ADMIN) {
      return canAccessAdmin(username);
    } else {
      throw ServiceError(
          400, "acl.access.type.unknown", "acl.access.type.unknown");
    }
  }
}

class AceImpl implements Ace {
  Map _data;

  factory AceImpl.publicWrite() {
    var ace = AceImpl();
    ace.addPrincipal(PrincipalImpl.everybody());
    ace.addPrivilege(PrivilegeImpl.readwrite());
    return ace;
  }

  factory AceImpl.publicRead() {
    var ace = AceImpl();
    ace.addPrincipal(PrincipalImpl.everybody());
    ace.addPrivilege(PrivilegeImpl.read());
    return ace;
  }

  factory AceImpl.userReadWrite(String username) {
    var ace = AceImpl();
    ace.addPrincipal(PrincipalImpl.fromUsername(username));
    ace.addPrivilege(PrivilegeImpl.readwrite());
    return ace;
  }

  factory AceImpl.userAdmin(String username) {
    var ace = AceImpl();
    ace.addPrincipal(PrincipalImpl.fromUsername(username));
    ace.addPrivilege(PrivilegeImpl.admin());
    return ace;
  }

  AceImpl.fromJson(this._data);

  AceImpl() : _data = {"principals": [], "privileges": []};

  @override
  List<Principal> get principals => (_data["principals"] as List)
      .map((m) => PrincipalImpl.fromJson(m))
      .toList();

  void addPrincipal(PrincipalImpl principal) {
    (_data["principals"] as List).add(principal.toJson());
  }

  @override
  List<Privilege> get privileges => (_data["privileges"] as List)
      .map((m) => PrivilegeImpl.fromJson(m))
      .toList();

  void addPrivilege(PrivilegeImpl privilege) {
    (_data["privileges"] as List).add(privilege.toJson());
  }

  void removePrivileges() {
    _data["privileges"] = [];
  }

  @override
  Map toJson() => _data;

  bool get hasReadPrivilege {
    return privileges.any((Privilege p) => p.canRead);
  }

  bool get hasWritePrivilege {
    return privileges.any((Privilege p) => p.canWrite);
  }

  bool get hasDeletePrivilege {
    return privileges.any((Privilege p) => p.canDelete);
  }

  bool get hasAdminPrivilege {
    return privileges.any((Privilege p) => p.canAdmin);
  }

  bool hasPrivilege(String type) {
    return privileges.any((Privilege p) => p.hasAccessType(type));
  }
}

class PrincipalImpl implements Principal {
  final Map _data;

  PrincipalImpl.everybody() : _data = {"type": Principal.EVERYBODY};

  PrincipalImpl.fromUsername(String username)
      : _data = {"id": username, "type": Principal.USER};

  PrincipalImpl.fromTeamName(String teamName)
      : _data = {"id": teamName, "type": Principal.TEAM};

  PrincipalImpl(String id, String type) : _data = {"id": id, "type": type};

  PrincipalImpl.fromJson(this._data);

  @override
  String get id => _data["id"];

  @override
  Map toJson() => _data;

  @override
  String get type => _data["type"];
}

class PrivilegeImpl implements Privilege {
  @override
  String type;

  PrivilegeImpl.admin() : type = Privilege.ADMIN;

  PrivilegeImpl.readwrite() : type = Privilege.READWRITE;

  PrivilegeImpl.read() : type = Privilege.READ;

  PrivilegeImpl(this.type);

  PrivilegeImpl.fromJson(Map data) : type = data["type"];

  @override
  Map toJson() => {'type': type};

  @override
  bool get canRead {
    return type == Privilege.READWRITE ||
        type == Privilege.READ ||
        type == Privilege.ADMIN;
  }

  @override
  bool get canWrite {
    return type == Privilege.ADMIN || type == Privilege.READWRITE;
  }

  @override
  bool get canDelete => canWrite;

  @override
  bool get canAdmin => type == Privilege.ADMIN;

  @override
  bool hasAccessType(String accessType) {
    if (accessType == Privilege.READ) return canRead;
    if (accessType == Privilege.READWRITE) return canWrite;
    if (accessType == Privilege.DELETE) return canDelete;
    if (accessType == Privilege.ADMIN) return canAdmin;
    return false;
  }
}
