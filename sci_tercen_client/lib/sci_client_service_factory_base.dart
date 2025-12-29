import 'dart:async';
import 'package:sci_tercen_model/sci_model.dart';
import 'package:sci_base/sci_service.dart' as api;

abstract class ServiceFactoryBase {
  static ServiceFactoryBase? CURRENT;
  factory ServiceFactoryBase() => CURRENT!;
  CranLibraryService get cranLibraryService;
  WorkerService get workerService;
  GarbageCollectorService get garbageCollectorService;
  FileService get fileService;
  LockService get lockService;
  SubscriptionPlanService get subscriptionPlanService;
  PersistentService get persistentService;
  ActivityService get activityService;
  FolderService get folderService;
  TableSchemaService get tableSchemaService;
  TaskService get taskService;
  UserSecretService get userSecretService;
  PatchRecordService get patchRecordService;
  EventService get eventService;
  WorkflowService get workflowService;
  UserService get userService;
  QueryService get queryService;
  ProjectDocumentService get projectDocumentService;
  TeamService get teamService;
  ProjectService get projectService;
  DocumentService get documentService;
  OperatorService get operatorService;
}

abstract class CranLibraryService implements api.Service<RLibrary> {
  Stream<List<int>> packagesGz(String repoName, {api.AclContext? aclContext});
  Stream<List<int>> packagesRds(String repoName, {api.AclContext? aclContext});
  Stream<List<int>> packages(String repoName, {api.AclContext? aclContext});
  Stream<List<int>> archive(String repoName, String package, String filename,
      {api.AclContext? aclContext});
  Stream<List<int>> package(String repoName, String package,
      {api.AclContext? aclContext});
  Future<List<RLibrary>> findByOwnerNameVersion(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class WorkerService implements api.Service<Task> {
  Future<dynamic> exec(Task task, {api.AclContext? aclContext});
  Future<dynamic> setPriority(double priority, {api.AclContext? aclContext});
  Future<dynamic> setStatus(String status, {api.AclContext? aclContext});
  Future<dynamic> setHeartBeat(int heartBeat, {api.AclContext? aclContext});
  Future<Worker> getState(String all, {api.AclContext? aclContext});
  Future<List<Pair>> updateTaskEnv(String taskId, List<Pair> env,
      {api.AclContext? aclContext});
  Future<List<Table>> getTaskStats(String taskId, {api.AclContext? aclContext});
}

abstract class GarbageCollectorService implements api.Service<GarbageObject> {
  Future<List<GarbageObject>> findGarbageTasks2ByDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class FileService implements api.Service<FileDocument> {
  Future<FileDocument> upload(FileDocument file, Stream<List> bytes,
      {api.AclContext? aclContext});
  Future<FileDocument> append(FileDocument file, Stream<List> bytes,
      {api.AclContext? aclContext});
  Stream<List<int>> download(String fileDocumentId,
      {api.AclContext? aclContext});
  Future<List<ZipEntry>> listZipContents(String fileDocumentId,
      {api.AclContext? aclContext});
  Stream<List<int>> downloadZipEntry(String fileDocumentId, String entryPath,
      {api.AclContext? aclContext});
  Future<bool> zipEntryExists(String fileDocumentId, String entryPath,
      {api.AclContext? aclContext});
  Future<ZipSummary> getZipSummary(String fileDocumentId,
      {api.AclContext? aclContext});
  Future<List<FileDocument>> findFileByWorkflowIdAndStepId(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<FileDocument>> findByDataUri(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class LockService implements api.Service<Lock> {
  Future<Lock> lock(String name, int wait, {api.AclContext? aclContext});
  Future<dynamic> releaseLock(Lock lock, {api.AclContext? aclContext});
}

abstract class SubscriptionPlanService
    implements api.Service<SubscriptionPlan> {
  Future<List<SubscriptionPlan>> getSubscriptionPlans(String userId,
      {api.AclContext? aclContext});
  Future<List<Plan>> getPlans(String userId, {api.AclContext? aclContext});
  Future<SubscriptionPlan> createSubscriptionPlan(
      String userId, String plan, String successUrl, String cancelUrl,
      {api.AclContext? aclContext});
  Future<dynamic> setSubscriptionPlanStatus(
      String subscriptionPlanId, String status,
      {api.AclContext? aclContext});
  Future<SubscriptionPlan> updatePaymentMethod(
      String subscriptionPlanId, String successUrl, String cancelUrl,
      {api.AclContext? aclContext});
  Future<dynamic> setUpdatePaymentMethodStatus(
      String subscriptionPlanId, String status,
      {api.AclContext? aclContext});
  Future<dynamic> cancelSubscription(String subscriptionPlanId,
      {api.AclContext? aclContext});
  Future<dynamic> upgradeSubscription(String subscriptionPlanId, String plan,
      {api.AclContext? aclContext});
  Future<List<SubscriptionPlan>> findByOwner(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<SubscriptionPlan>> findSubscriptionPlanByCheckoutSessionId(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class PersistentService implements api.Service<PersistentObject> {
  Future<List<String>> createNewIds(int n, {api.AclContext? aclContext});
  Future<Summary> summary(String teamOrProjectId, {api.AclContext? aclContext});
  Future<List<PersistentObject>> getDependentObjects(String id,
      {api.AclContext? aclContext});
  Future<List<String>> getDependentObjectIds(String id,
      {api.AclContext? aclContext});
  Future<List<PersistentObject>> getObjects(
      String startId, String endId, int limit, bool useFactory,
      {api.AclContext? aclContext});
  Future<List<PersistentObject>> findDeleted(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<PersistentObject>> findByKind(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class ActivityService implements api.Service<Activity> {
  Future<List<Activity>> findByUserAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<Activity>> findByTeamAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<Activity>> findByProjectAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class FolderService implements api.Service<FolderDocument> {
  Future<FolderDocument> getOrCreate(String projectId, String path,
      {api.AclContext? aclContext});
  Future<List<FolderDocument>> getExternalStorageFolders(
      String projectId, String volume, String path,
      {api.AclContext? aclContext});
  Future<List<FolderDocument>> findFolderByParentFolderAndName(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class TableSchemaService implements api.Service<Schema> {
  Future<Schema> uploadTable(FileDocument file, Stream<List> bytes,
      {api.AclContext? aclContext});
  Future<List<Schema>> findByQueryHash(List<String> ids,
      {api.AclContext? aclContext});
  Future<Table> select(
      String tableId, List<String> cnames, int offset, int limit,
      {api.AclContext? aclContext});
  Future<Table> selectPairwise(
      String tableId, List<String> cnames, int offset, int limit,
      {api.AclContext? aclContext});
  Stream<List<int>> selectStream(
      String tableId, List<String> cnames, int offset, int limit,
      {api.AclContext? aclContext});
  Stream<List<int>> streamTable(String tableId, List<String> cnames, int offset,
      int limit, String binaryFormat,
      {api.AclContext? aclContext});
  Stream<List<int>> selectFileContentStream(String tableId, String filename,
      {api.AclContext? aclContext});
  Stream<List<int>> getFileMimetypeStream(String tableId, String filename,
      {api.AclContext? aclContext});
  Stream<List<int>> selectCSV(String tableId, List<String> cnames, int offset,
      int limit, String separator, bool quote, String encoding,
      {api.AclContext? aclContext});
  Future<List<Schema>> findSchemaByDataDirectory(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class TaskService implements api.Service<Task> {
  Future<dynamic> runTask(String taskId, {api.AclContext? aclContext});
  Future<dynamic> cancelTask(String taskId, {api.AclContext? aclContext});
  Future<Task> waitDone(String taskId, {api.AclContext? aclContext});
  Future<dynamic> updateWorker(Worker worker, {api.AclContext? aclContext});
  Future<double> taskDurationByTeam(String teamId, int year, int month,
      {api.AclContext? aclContext});
  Future<List<Worker>> getWorkers(List<String> names,
      {api.AclContext? aclContext});
  Future<List<Task>> getTasks(List<String> names, {api.AclContext? aclContext});
  Future<dynamic> setTaskEnvironment(String taskId, List<Pair> environment,
      {api.AclContext? aclContext});
  Future<dynamic> collectTaskStats(String taskId, {api.AclContext? aclContext});
  Future<List<Task>> findByHash(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<Task>> findGCTaskByLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class UserSecretService implements api.Service<UserSecret> {
  Future<String> getSecret(String id, String name,
      {api.AclContext? aclContext});
  Future<List<UserSecret>> findSecretByUserId(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class PatchRecordService implements api.Service<PatchRecords> {
  Future<List<PatchRecords>> findByChannelIdAndSequence(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class EventService implements api.Service<Event> {
  Future<dynamic> sendPersistentChannel(String channel, Event evt,
      {api.AclContext? aclContext});
  Future<dynamic> sendChannel(String channel, Event evt,
      {api.AclContext? aclContext});
  Stream<Event> channel(String name, {api.AclContext? aclContext});
  Stream<TaskEvent> listenTaskChannel(String taskId, bool start,
      {api.AclContext? aclContext});
  Stream<TaskStateEvent> onTaskState(String taskId,
      {api.AclContext? aclContext});
  Future<int> taskListenerCount(String taskId, {api.AclContext? aclContext});
  Future<List<Event>> findByChannelAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class WorkflowService implements api.Service<Workflow> {
  Future<CubeQuery> getCubeQuery(String workflowId, String stepId,
      {api.AclContext? aclContext});
  Future<Workflow> copyApp(String workflowId, String projectId,
      {api.AclContext? aclContext});
}

abstract class UserService implements api.Service<User> {
  Future<String> getSamlMessage(String type, {api.AclContext? aclContext});
  Future<dynamic> cookieConsent(String dummy, {api.AclContext? aclContext});
  Future<dynamic> logout(String reason, {api.AclContext? aclContext});
  Future<UserSession> connect(String usernameOrEmail, String password,
      {api.AclContext? aclContext});
  Future<UserSession> connect2(
      String domain, String usernameOrEmail, String password,
      {api.AclContext? aclContext});
  Future<User> createUser(User user, String password,
      {api.AclContext? aclContext});
  Future<bool> hasUserName(String username, {api.AclContext? aclContext});
  Future<dynamic> updatePassword(String userId, String password,
      {api.AclContext? aclContext});
  Future<BillingInfo> updateBillingInfo(String userId, BillingInfo billingInfo,
      {api.AclContext? aclContext});
  Future<ViesInfo> viesInfo(String country_code, String vatNumber,
      {api.AclContext? aclContext});
  Future<Summary> summary(String userId, {api.AclContext? aclContext});
  Future<ResourceSummary> resourceSummary(String userId,
      {api.AclContext? aclContext});
  Future<Profiles> profiles(String userId, {api.AclContext? aclContext});
  Future<String> createToken(String userId, int validityInSeconds,
      {api.AclContext? aclContext});
  Future<String> createTokenForTask(
      String userId, int validityInSeconds, String taskId,
      {api.AclContext? aclContext});
  Future<bool> isTokenValid(String token, {api.AclContext? aclContext});
  Future<String> setTeamPrivilege(
      String username, Principal principal, Privilege privilege,
      {api.AclContext? aclContext});
  Future<Version> getServerVersion(String module, {api.AclContext? aclContext});
  Future<List<Pair>> getClientConfig(List<String> keys,
      {api.AclContext? aclContext});
  Future<dynamic> getInvited(String email, {api.AclContext? aclContext});
  Future<dynamic> sendValidationMail(String email,
      {api.AclContext? aclContext});
  Future<dynamic> sendResetPasswordEmail(String email,
      {api.AclContext? aclContext});
  Future<dynamic> changeUserPassword(String token, String password,
      {api.AclContext? aclContext});
  Future<dynamic> validateUser(String token, {api.AclContext? aclContext});
  Future<bool> canCreatePrivateProject(String teamOrUserId,
      {api.AclContext? aclContext});
  Future<List<User>> findTeamMembers(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<User>> findUserByCreatedDateAndName(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<User>> findUserByEmail(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class QueryService implements api.Service<PersistentObject> {
  Stream<String> query(String jsonPath, int limit,
      {api.AclContext? aclContext});
  Future<List<PersistentObject>> findByOwnerAndKindAndDate(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<PersistentObject>> findByOwnerAndProjectAndKindAndDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<PersistentObject>> findByOwnerAndKind(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<PersistentObject>> findPublicByKind(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class ProjectDocumentService implements api.Service<ProjectDocument> {
  Future<List<FolderDocument>> getParentFolders(String documentId,
      {api.AclContext? aclContext});
  Future<ProjectDocument> cloneProjectDocument(
      String documentId, String projectId,
      {api.AclContext? aclContext});
  Future<ProjectDocument> getFromPath(
      String projectId, String path, bool useFactory,
      {api.AclContext? aclContext});
  Future<List<ProjectDocument>> findProjectObjectsByLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<ProjectDocument>> findProjectObjectsByFolderAndName(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<ProjectDocument>> findFileByLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<ProjectDocument>> findSchemaByLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<ProjectDocument>> findSchemaByOwnerAndLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<ProjectDocument>> findFileByOwnerAndLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class TeamService implements api.Service<Team> {
  Future<Profiles> profiles(String teamId, {api.AclContext? aclContext});
  Future<ResourceSummary> resourceSummary(String teamId,
      {api.AclContext? aclContext});
  Future<dynamic> transferOwnership(List<String> teamIds, String newOwner,
      {api.AclContext? aclContext});
  Future<List<Team>> findTeamByOwner(
      {required List keys,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class ProjectService implements api.Service<Project> {
  Future<Profiles> profiles(String projectId, {api.AclContext? aclContext});
  Future<ResourceSummary> resourceSummary(String projectId,
      {api.AclContext? aclContext});
  Future<List<Project>> explore(String category, int start, int limit,
      {api.AclContext? aclContext});
  Future<List<Project>> recentProjects(String userId,
      {api.AclContext? aclContext});
  Future<Project> cloneProject(String projectId, Project project,
      {api.AclContext? aclContext});
  Future<List<Project>> findByIsPublicAndLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<Project>> findByTeamAndIsPublicAndLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class DocumentService implements api.Service<Document> {
  Future<SearchResult> search(
      String query, int limit, bool useFactory, String bookmark,
      {api.AclContext? aclContext});
  Future<List<Document>> getLibrary(String projectId, List<String> teamIds,
      List<String> docTypes, List<String> tags, int offset, int limit,
      {api.AclContext? aclContext});
  Future<List<Document>> getTercenLibrary(int offset, int limit,
      {api.AclContext? aclContext});
  Future<List<Operator>> getTercenOperatorLibrary(int offset, int limit,
      {api.AclContext? aclContext});
  Future<List<Document>> getTercenWorkflowLibrary(int offset, int limit,
      {api.AclContext? aclContext});
  Future<List<Document>> getTercenAppLibrary(int offset, int limit,
      {api.AclContext? aclContext});
  Future<List<Document>> getTercenDatasetLibrary(int offset, int limit,
      {api.AclContext? aclContext});
  Future<List<Document>> findWorkflowByTagOwnerCreatedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<Document>> findProjectByOwnersAndName(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<Document>> findProjectByOwnersAndCreatedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<Document>> findOperatorByOwnerLastModifiedDate(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
  Future<List<Document>> findOperatorByUrlAndVersion(
      {startKey,
      endKey,
      int limit = 200,
      int skip = 0,
      bool descending = true,
      bool useFactory = false,
      api.AclContext? aclContext});
}

abstract class OperatorService implements api.Service<Operator> {}
