import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_base/sci_service.dart' as service;

// PatchRecordService extensions
extension PatchRecordServiceExt on PatchRecordService {
  /// Finds patch records by channel ID and sequence number.
  ///
  /// Returns a stream of [PatchRecords] filtered by the specified range.
  ///
  /// Parameters:
  /// - [startKeyChannelId], [endKeyChannelId]: Channel ID range (default: "" to "\uf000")
  /// - [startKeySequence], [endKeySequence]: Sequence number range (default: 0 to 2147483647)
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<PatchRecords> findByChannelIdAndSequenceStream(
      {String startKeyChannelId = "",
      int startKeySequence = 0,
      String endKeyChannelId = "\uf000",
      int endKeySequence = 2147483647,
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByChannelIdAndSequence',
        startKey: [startKeyChannelId, startKeySequence],
        endKey: [endKeyChannelId, endKeySequence],
        (PatchRecords doc) => [doc.cI, doc.s],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// PersistentService extensions
extension PersistentServiceExt on PersistentService {
  /// Finds deleted persistent objects by kind.
  ///
  /// Returns a stream of [PersistentObject] instances that are marked as deleted.
  ///
  /// Parameters:
  /// - [startKeyKind], [endKeyKind]: Kind range filter (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<PersistentObject> findDeletedStream(
      {String startKeyKind = "",
      String endKeyKind = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findDeleted',
        startKey: [startKeyKind],
        endKey: [endKeyKind],
        (PersistentObject doc) => [doc.kind],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds persistent objects by kind.
  ///
  /// Returns a stream of [PersistentObject] instances filtered by kind.
  ///
  /// Parameters:
  /// - [startKeyKind], [endKeyKind]: Kind range filter (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<PersistentObject> findByKindStream(
      {String startKeyKind = "",
      String endKeyKind = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByKind',
        startKey: [startKeyKind],
        endKey: [endKeyKind],
        (PersistentObject doc) => [doc.kind],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// DocumentService extensions
extension DocumentServiceExt on DocumentService {
  /// Finds projects by owner and name.
  ///
  /// Returns a stream of [Document] instances filtered by owner and name range.
  ///
  /// Parameters:
  /// - [startKeyOwner], [endKeyOwner]: Owner ID range (default: "" to "\uf000")
  /// - [startKeyName], [endKeyName]: Name range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Document> findProjectByOwnersAndNameStream(
      {String startKeyOwner = "",
      String startKeyName = "",
      String endKeyOwner = "\uf000",
      String endKeyName = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream('findProjectByOwnersAndName',
        (Document doc) => [doc.acl.owner, doc.name],
        startKey: [startKeyOwner, startKeyName],
        endKey: [endKeyOwner, endKeyName],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds projects by owner and created date.
  ///
  /// Returns a stream of [Document] instances filtered by owner and creation date range.
  ///
  /// Parameters:
  /// - [startKeyOwner], [endKeyOwner]: Owner ID range (default: "" to "\uf000")
  /// - [startKeyCreatedDate], [endKeyCreatedDate]: Created date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Document> findProjectByOwnersAndCreatedDateStream(
      {String startKeyOwner = "",
      String startKeyCreatedDate = "",
      String endKeyOwner = "\uf000",
      String endKeyCreatedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream('findProjectByOwnersAndCreatedDate',
        (Document doc) => [doc.acl.owner, doc.createdDate.value],
        startKey: [startKeyOwner, startKeyCreatedDate],
        endKey: [endKeyOwner, endKeyCreatedDate],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds operators by owner and last modified date.
  ///
  /// Returns a stream of [Document] instances (Operator type) filtered by owner and modification date.
  ///
  /// Parameters:
  /// - [startKeyOwner], [endKeyOwner]: Owner ID range (default: "" to "\uf000")
  /// - [startKeyLastModifiedDate], [endKeyLastModifiedDate]: Last modified date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Document> findOperatorByOwnerLastModifiedDateStream(
      {String startKeyOwner = "",
      String startKeyLastModifiedDate = "",
      String endKeyOwner = "\uf000",
      String endKeyLastModifiedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream('findOperatorByOwnerLastModifiedDate',
        (Document doc) => [doc.acl.owner, doc.lastModifiedDate.value],
        startKey: [startKeyOwner, startKeyLastModifiedDate],
        endKey: [endKeyOwner, endKeyLastModifiedDate],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds operators by URL and version.
  ///
  /// Returns a stream of [Document] instances (Operator type) filtered by URL and version.
  ///
  /// Parameters:
  /// - [startKeyUrl], [endKeyUrl]: URL range (default: "" to "\uf000")
  /// - [startKeyVersion], [endKeyVersion]: Version range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Document> findOperatorByUrlAndVersionStream(
      {String startKeyUrl = "",
      String startKeyVersion = "",
      String endKeyUrl = "\uf000",
      String endKeyVersion = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream('findOperatorByUrlAndVersion',
        (Document doc) => [(doc as Operator).url.uri, doc.version],
        startKey: [startKeyUrl, startKeyVersion],
        endKey: [endKeyUrl, endKeyVersion],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// ProjectDocumentService extensions
extension ProjectDocumentServiceExt on ProjectDocumentService {
  /// Finds project objects by project ID and last modified date.
  ///
  /// Returns a stream of [ProjectDocument] instances (Workflow, TableSchema, FileDocument).
  ///
  /// Parameters:
  /// - [startKeyProjectId], [endKeyProjectId]: Project ID range (default: "" to "\uf000")
  /// - [startKeyLastModifiedDate], [endKeyLastModifiedDate]: Last modified date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<ProjectDocument> findProjectObjectsByLastModifiedDateStream(
      {String startKeyProjectId = "",
      String startKeyLastModifiedDate = "",
      String endKeyProjectId = "\uf000",
      String endKeyLastModifiedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findProjectObjectsByLastModifiedDate',
        startKey: [startKeyProjectId, startKeyLastModifiedDate],
        endKey: [endKeyProjectId, endKeyLastModifiedDate],
        (ProjectDocument doc) => [doc.projectId, doc.lastModifiedDate.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds project objects by project ID, folder ID, and name.
  ///
  /// Returns a stream of [ProjectDocument] instances filtered by project, folder, and name.
  ///
  /// Parameters:
  /// - [startKeyProjectId], [endKeyProjectId]: Project ID range (default: "" to "\uf000")
  /// - [startKeyFolderId], [endKeyFolderId]: Folder ID range (default: "" to "\uf000")
  /// - [startKeyName], [endKeyName]: Name range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<ProjectDocument> findProjectObjectsByFolderAndNameStream(
      {String startKeyProjectId = "",
      String startKeyFolderId = "",
      String startKeyName = "",
      String endKeyProjectId = "\uf000",
      String endKeyFolderId = "\uf000",
      String endKeyName = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findProjectObjectsByFolderAndName',
        startKey: [startKeyProjectId, startKeyFolderId, startKeyName],
        endKey: [endKeyProjectId, endKeyFolderId, endKeyName],
        (ProjectDocument doc) => [doc.projectId, doc.folderId, doc.name],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds files by project ID and last modified date.
  ///
  /// Returns a stream of [ProjectDocument] instances (FileDocument type).
  ///
  /// Parameters:
  /// - [startKeyProjectId], [endKeyProjectId]: Project ID range (default: "" to "\uf000")
  /// - [startKeyLastModifiedDate], [endKeyLastModifiedDate]: Last modified date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<ProjectDocument> findFileByLastModifiedDateStream(
      {String startKeyProjectId = "",
      String startKeyLastModifiedDate = "",
      String endKeyProjectId = "\uf000",
      String endKeyLastModifiedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findFileByLastModifiedDate',
        startKey: [startKeyProjectId, startKeyLastModifiedDate],
        endKey: [endKeyProjectId, endKeyLastModifiedDate],
        (ProjectDocument doc) => [doc.projectId, doc.lastModifiedDate.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds schemas by project ID and last modified date.
  ///
  /// Returns a stream of [ProjectDocument] instances (TableSchema type).
  ///
  /// Parameters:
  /// - [startKeyProjectId], [endKeyProjectId]: Project ID range (default: "" to "\uf000")
  /// - [startKeyLastModifiedDate], [endKeyLastModifiedDate]: Last modified date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<ProjectDocument> findSchemaByLastModifiedDateStream(
      {String startKeyProjectId = "",
      String startKeyLastModifiedDate = "",
      String endKeyProjectId = "\uf000",
      String endKeyLastModifiedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findSchemaByLastModifiedDate',
        startKey: [startKeyProjectId, startKeyLastModifiedDate],
        endKey: [endKeyProjectId, endKeyLastModifiedDate],
        (ProjectDocument doc) => [doc.projectId, doc.lastModifiedDate.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds schemas by owner and last modified date.
  ///
  /// Returns a stream of [ProjectDocument] instances (TableSchema type).
  ///
  /// Parameters:
  /// - [startKeyOwner], [endKeyOwner]: Owner ID range (default: "" to "\uf000")
  /// - [startKeyLastModifiedDate], [endKeyLastModifiedDate]: Last modified date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<ProjectDocument> findSchemaByOwnerAndLastModifiedDateStream(
      {String startKeyOwner = "",
      String startKeyLastModifiedDate = "",
      String endKeyOwner = "\uf000",
      String endKeyLastModifiedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findSchemaByOwnerAndLastModifiedDate',
        startKey: [startKeyOwner, startKeyLastModifiedDate],
        endKey: [endKeyOwner, endKeyLastModifiedDate],
        (ProjectDocument doc) => [doc.acl.owner, doc.lastModifiedDate.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds files by owner and last modified date.
  ///
  /// Returns a stream of [ProjectDocument] instances (FileDocument type).
  ///
  /// Parameters:
  /// - [startKeyOwner], [endKeyOwner]: Owner ID range (default: "" to "\uf000")
  /// - [startKeyLastModifiedDate], [endKeyLastModifiedDate]: Last modified date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<ProjectDocument> findFileByOwnerAndLastModifiedDateStream(
      {String startKeyOwner = "",
      String startKeyLastModifiedDate = "",
      String endKeyOwner = "\uf000",
      String endKeyLastModifiedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findFileByOwnerAndLastModifiedDate',
        startKey: [startKeyOwner, startKeyLastModifiedDate],
        endKey: [endKeyOwner, endKeyLastModifiedDate],
        (ProjectDocument doc) => [doc.acl.owner, doc.lastModifiedDate.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// FolderService extensions
extension FolderServiceExt on FolderService {
  /// Finds folders by parent folder and name.
  ///
  /// Returns a stream of [FolderDocument] instances filtered by project, parent folder, and name.
  ///
  /// Parameters:
  /// - [startKeyProjectId], [endKeyProjectId]: Project ID range (default: "" to "\uf000")
  /// - [startKeyFolderId], [endKeyFolderId]: Parent folder ID range (default: "" to "\uf000")
  /// - [startKeyName], [endKeyName]: Name range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<FolderDocument> findFolderByParentFolderAndNameStream(
      {String startKeyProjectId = "",
      String startKeyFolderId = "",
      String startKeyName = "",
      String endKeyProjectId = "\uf000",
      String endKeyFolderId = "\uf000",
      String endKeyName = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findFolderByParentFolderAndName',
        startKey: [startKeyProjectId, startKeyFolderId, startKeyName],
        endKey: [endKeyProjectId, endKeyFolderId, endKeyName],
        (FolderDocument doc) => [doc.projectId, doc.folderId, doc.name],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// TableSchemaService extensions
extension TableSchemaServiceExt on TableSchemaService {
  /// Finds schemas by data directory.
  ///
  /// Returns a stream of [Schema] instances filtered by data directory.
  ///
  /// Parameters:
  /// - [startKeyDataDirectory], [endKeyDataDirectory]: Data directory range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Schema> findSchemaByDataDirectoryStream(
      {String startKeyDataDirectory = "",
      String endKeyDataDirectory = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findSchemaByDataDirectory',
        startKey: [startKeyDataDirectory],
        endKey: [endKeyDataDirectory],
        (Schema doc) => [doc.dataDirectory],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// ProjectService extensions
extension ProjectServiceExt on ProjectService {
  /// Finds projects by public status and last modified date.
  ///
  /// Returns a stream of [Project] instances filtered by public flag and modification date.
  ///
  /// Parameters:
  /// - [startKeyIsPublic], [endKeyIsPublic]: Public status range (default: false to true)
  /// - [startKeyLastModifiedDate], [endKeyLastModifiedDate]: Last modified date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Project> findByIsPublicAndLastModifiedDateStream(
      {bool startKeyIsPublic = false,
      String startKeyLastModifiedDate = "",
      bool endKeyIsPublic = true,
      String endKeyLastModifiedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByIsPublicAndLastModifiedDate',
        startKey: [startKeyIsPublic, startKeyLastModifiedDate],
        endKey: [endKeyIsPublic, endKeyLastModifiedDate],
        (Project doc) => [doc.isPublic, doc.lastModifiedDate.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds projects by team, public status, and last modified date.
  ///
  /// Returns a stream of [Project] instances filtered by team (owner), public flag, and modification date.
  ///
  /// Parameters:
  /// - [startKeyOwner], [endKeyOwner]: Team/owner ID range (default: "" to "\uf000")
  /// - [startKeyIsPublic], [endKeyIsPublic]: Public status range (default: false to true)
  /// - [startKeyLastModifiedDate], [endKeyLastModifiedDate]: Last modified date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Project> findByTeamAndIsPublicAndLastModifiedDateStream(
      {String startKeyOwner = "",
      bool startKeyIsPublic = false,
      String startKeyLastModifiedDate = "",
      String endKeyOwner = "\uf000",
      bool endKeyIsPublic = true,
      String endKeyLastModifiedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByTeamAndIsPublicAndLastModifiedDate',
        startKey: [startKeyOwner, startKeyIsPublic, startKeyLastModifiedDate],
        endKey: [endKeyOwner, endKeyIsPublic, endKeyLastModifiedDate],
        (Project doc) =>
            [doc.acl.owner, doc.isPublic, doc.lastModifiedDate.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// TeamService extensions
extension TeamServiceExt on TeamService {
  /// Finds teams by owner.
  ///
  /// Returns a stream of [Team] instances filtered by owner ID.
  ///
  /// Parameters:
  /// - [startKeyOwner], [endKeyOwner]: Owner ID range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Team> findTeamByOwnerStream(
      {String startKeyOwner = "",
      String endKeyOwner = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findTeamByOwner',
        startKey: [startKeyOwner],
        endKey: [endKeyOwner],
        (Team doc) => [doc.acl.owner],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// UserService extensions
extension UserServiceExt on UserService {
  /// Finds users by created date and name.
  ///
  /// Returns a stream of [User] instances filtered by creation date and name.
  ///
  /// Parameters:
  /// - [startKeyCreatedDate], [endKeyCreatedDate]: Created date range (default: "" to "\uf000")
  /// - [startKeyName], [endKeyName]: Name range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<User> findUserByCreatedDateAndNameStream(
      {String startKeyCreatedDate = "",
      String startKeyName = "",
      String endKeyCreatedDate = "\uf000",
      String endKeyName = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findUserByCreatedDateAndName',
        startKey: [startKeyCreatedDate, startKeyName],
        endKey: [endKeyCreatedDate, endKeyName],
        (User doc) => [doc.createdDate.value, doc.name],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds users by email address.
  ///
  /// Returns a stream of [User] instances filtered by email.
  ///
  /// Parameters:
  /// - [startKeyEmail], [endKeyEmail]: Email range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<User> findUserByEmailStream(
      {String startKeyEmail = "",
      String endKeyEmail = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findUserByEmail',
        startKey: [startKeyEmail],
        endKey: [endKeyEmail],
        (User doc) => [doc.email],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// UserSecretService extensions
extension UserSecretServiceExt on UserSecretService {
  /// Finds user secrets by user ID.
  ///
  /// Returns a stream of [UserSecret] instances filtered by user ID.
  ///
  /// Parameters:
  /// - [startKeyUserId], [endKeyUserId]: User ID range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<UserSecret> findSecretByUserIdStream(
      {String startKeyUserId = "",
      String endKeyUserId = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findSecretByUserId',
        startKey: [startKeyUserId],
        endKey: [endKeyUserId],
        (UserSecret doc) => [doc.userId],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// SubscriptionPlanService extensions
extension SubscriptionPlanServiceExt on SubscriptionPlanService {
  /// Finds subscription plans by owner.
  ///
  /// Returns a stream of [SubscriptionPlan] instances filtered by owner ID.
  ///
  /// Parameters:
  /// - [startKeyOwner], [endKeyOwner]: Owner ID range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<SubscriptionPlan> findByOwnerStream(
      {String startKeyOwner = "",
      String endKeyOwner = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByOwner',
        startKey: [startKeyOwner],
        endKey: [endKeyOwner],
        (SubscriptionPlan doc) => [doc.acl.owner],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds subscription plans by checkout session ID.
  ///
  /// Returns a stream of [SubscriptionPlan] instances filtered by checkout session ID.
  ///
  /// Parameters:
  /// - [startKeyCheckoutSessionId], [endKeyCheckoutSessionId]: Checkout session ID range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<SubscriptionPlan> findSubscriptionPlanByCheckoutSessionIdStream(
      {String startKeyCheckoutSessionId = "",
      String endKeyCheckoutSessionId = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findSubscriptionPlanByCheckoutSessionId',
        startKey: [startKeyCheckoutSessionId],
        endKey: [endKeyCheckoutSessionId],
        (SubscriptionPlan doc) => [doc.checkoutSessionId],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// FileService extensions
extension FileServiceExt on FileService {
  /// Finds files by data URI.
  ///
  /// Returns a stream of [FileDocument] instances filtered by data URI.
  ///
  /// Parameters:
  /// - [startKeyDataUri], [endKeyDataUri]: Data URI range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<FileDocument> findByDataUriStream(
      {String startKeyDataUri = "",
      String endKeyDataUri = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByDataUri',
        startKey: [startKeyDataUri],
        endKey: [endKeyDataUri],
        (FileDocument doc) => [doc.dataUri],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// TaskService extensions
extension TaskServiceExt on TaskService {
  /// Finds tasks by hash.
  ///
  /// Returns a stream of [Task] instances filtered by task hash.
  ///
  /// Parameters:
  /// - [startKeyTaskHash], [endKeyTaskHash]: Task hash range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Task> findByHashStream(
      {String startKeyTaskHash = "",
      String endKeyTaskHash = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByHash',
        startKey: [startKeyTaskHash],
        endKey: [endKeyTaskHash],
        (Task doc) => [doc.taskHash],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds garbage collection tasks by removal flag and last modified date.
  ///
  /// Returns a stream of [Task] instances (CubeQueryTask type) filtered by GC removal flag and modification date.
  ///
  /// Parameters:
  /// - [startKeyRemoveOnGC], [endKeyRemoveOnGC]: Remove on GC flag range (default: false to true)
  /// - [startKeyLastModifiedDate], [endKeyLastModifiedDate]: Last modified date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Task> findGCTaskByLastModifiedDateStream(
      {bool startKeyRemoveOnGC = false,
      String startKeyLastModifiedDate = "",
      bool endKeyRemoveOnGC = true,
      String endKeyLastModifiedDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findGCTaskByLastModifiedDate',
        startKey: [startKeyRemoveOnGC, startKeyLastModifiedDate],
        endKey: [endKeyRemoveOnGC, endKeyLastModifiedDate],
        (Task doc) =>
            [(doc as CubeQueryTask).removeOnGC, doc.lastModifiedDate.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// GarbageCollectorService extensions
extension GarbageCollectorServiceExt on GarbageCollectorService {
  /// Finds garbage tasks by date.
  ///
  /// Returns a stream of [GarbageObject] instances (GarbageTasks2 type) filtered by date.
  ///
  /// Parameters:
  /// - [startKeyDate], [endKeyDate]: Date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<GarbageObject> findGarbageTasks2ByDateStream(
      {String startKeyDate = "",
      String endKeyDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findGarbageTasks2ByDate',
        startKey: [startKeyDate],
        endKey: [endKeyDate],
        (GarbageObject doc) => [(doc as GarbageTasks2).date],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// EventService extensions
extension EventServiceExt on EventService {
  /// Finds events by channel and date.
  ///
  /// Returns a stream of [Event] instances (PersistentChannelEvent type) filtered by channel and date.
  ///
  /// Parameters:
  /// - [startKeyChannel], [endKeyChannel]: Channel range (default: "" to "\uf000")
  /// - [startKeyDate], [endKeyDate]: Date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Event> findByChannelAndDateStream(
      {String startKeyChannel = "",
      String startKeyDate = "",
      String endKeyChannel = "\uf000",
      String endKeyDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByChannelAndDate',
        startKey: [startKeyChannel, startKeyDate],
        endKey: [endKeyChannel, endKeyDate],
        (Event doc) =>
            [(doc as PersistentChannelEvent).channel, doc.date.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// ActivityService extensions
extension ActivityServiceExt on ActivityService {
  /// Finds activities by user ID and date.
  ///
  /// Returns a stream of [Activity] instances filtered by user ID and date.
  ///
  /// Parameters:
  /// - [startKeyUserId], [endKeyUserId]: User ID range (default: "" to "\uf000")
  /// - [startKeyDate], [endKeyDate]: Date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Activity> findByUserAndDateStream(
      {String startKeyUserId = "",
      String startKeyDate = "",
      String endKeyUserId = "\uf000",
      String endKeyDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByUserAndDate',
        startKey: [startKeyUserId, startKeyDate],
        endKey: [endKeyUserId, endKeyDate],
        (Activity doc) => [doc.userId, doc.date.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds activities by team ID and date.
  ///
  /// Returns a stream of [Activity] instances filtered by team ID and date.
  ///
  /// Parameters:
  /// - [startKeyTeamId], [endKeyTeamId]: Team ID range (default: "" to "\uf000")
  /// - [startKeyDate], [endKeyDate]: Date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Activity> findByTeamAndDateStream(
      {String startKeyTeamId = "",
      String startKeyDate = "",
      String endKeyTeamId = "\uf000",
      String endKeyDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByTeamAndDate',
        startKey: [startKeyTeamId, startKeyDate],
        endKey: [endKeyTeamId, endKeyDate],
        (Activity doc) => [doc.teamId, doc.date.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }

  /// Finds activities by project ID and date.
  ///
  /// Returns a stream of [Activity] instances filtered by project ID and date.
  ///
  /// Parameters:
  /// - [startKeyProjectId], [endKeyProjectId]: Project ID range (default: "" to "\uf000")
  /// - [startKeyDate], [endKeyDate]: Date range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<Activity> findByProjectAndDateStream(
      {String startKeyProjectId = "",
      String startKeyDate = "",
      String endKeyProjectId = "\uf000",
      String endKeyDate = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByProjectAndDate',
        startKey: [startKeyProjectId, startKeyDate],
        endKey: [endKeyProjectId, endKeyDate],
        (Activity doc) => [doc.projectId, doc.date.value],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}

// CranLibraryService extensions
extension CranLibraryServiceExt on CranLibraryService {
  /// Finds R libraries by owner, package name, and version.
  ///
  /// Returns a stream of [RLibrary] instances (RSourceLibrary type) filtered by owner, package, and version.
  ///
  /// Parameters:
  /// - [startKeyOwner], [endKeyOwner]: Owner ID range (default: "" to "\uf000")
  /// - [startKeyPackage], [endKeyPackage]: Package name range (default: "" to "\uf000")
  /// - [startKeyVersion], [endKeyVersion]: Version range (default: "" to "\uf000")
  /// - [descending]: Whether to return results in descending order (default: false)
  /// - [useFactory]: When true, returns concrete subclass instances with full type information.
  ///   When false, returns abstract base type instances. (default: false)
  /// - [aclContext]: Optional access control context for permission filtering
  Stream<RLibrary> findByOwnerNameVersionStream(
      {String startKeyOwner = "",
      String startKeyPackage = "",
      String startKeyVersion = "",
      String endKeyOwner = "\uf000",
      String endKeyPackage = "\uf000",
      String endKeyVersion = "\uf000",
      bool descending = false,
      bool useFactory = false,
      service.AclContext? aclContext}) async* {
    var stream = findStartKeysStream(
        'findByOwnerNameVersion',
        startKey: [startKeyOwner, startKeyPackage, startKeyVersion],
        endKey: [endKeyOwner, endKeyPackage, endKeyVersion],
        (RLibrary doc) => [
              doc.acl.owner,
              (doc as RSourceLibrary).rDescription.Package,
              doc.rDescription.Version
            ],
        descending: descending,
        useFactory: useFactory,
        aclContext: aclContext);
    yield* stream;
  }
}
