part of sci_client_base;

class ServiceFactoryBase implements api.ServiceFactory {
  late WorkerService workerService;
  late GarbageCollectorService garbageCollectorService;
  late FileService fileService;
  late LockService lockService;
  late SubscriptionPlanService subscriptionPlanService;
  late PersistentService persistentService;
  late ActivityService activityService;
  late FolderService folderService;
  late TableSchemaService tableSchemaService;
  late TaskService taskService;
  late UserSecretService userSecretService;
  late PatchRecordService patchRecordService;
  late EventService eventService;
  late WorkflowService workflowService;
  late UserService userService;
  late ProjectDocumentService projectDocumentService;
  late CranLibraryService cranLibraryService;
  late TeamService teamService;
  late ProjectService projectService;
  late DocumentService documentService;
  late OperatorService operatorService;
  ServiceFactoryBase() {
    workerService = new WorkerService()..factory = this;
    garbageCollectorService = new GarbageCollectorService()..factory = this;
    fileService = new FileService()..factory = this;
    lockService = new LockService()..factory = this;
    subscriptionPlanService = new SubscriptionPlanService()..factory = this;
    persistentService = new PersistentService()..factory = this;
    activityService = new ActivityService()..factory = this;
    folderService = new FolderService()..factory = this;
    tableSchemaService = new TableSchemaService()..factory = this;
    taskService = new TaskService()..factory = this;
    userSecretService = new UserSecretService()..factory = this;
    patchRecordService = new PatchRecordService()..factory = this;
    eventService = new EventService()..factory = this;
    workflowService = new WorkflowService()..factory = this;
    userService = new UserService()..factory = this;
    projectDocumentService = new ProjectDocumentService()..factory = this;
    cranLibraryService = new CranLibraryService()..factory = this;
    teamService = new TeamService()..factory = this;
    projectService = new ProjectService()..factory = this;
    documentService = new DocumentService()..factory = this;
    operatorService = new OperatorService()..factory = this;
  }
  Future initialize() async {}
  Future initializeWith(Uri uri, [HttpClient? client]) async {
    if (client == null) client = new HttpClient();
    await workerService.initialize(uri, client);
    await garbageCollectorService.initialize(uri, client);
    await fileService.initialize(uri, client);
    await lockService.initialize(uri, client);
    await subscriptionPlanService.initialize(uri, client);
    await persistentService.initialize(uri, client);
    await activityService.initialize(uri, client);
    await folderService.initialize(uri, client);
    await tableSchemaService.initialize(uri, client);
    await taskService.initialize(uri, client);
    await userSecretService.initialize(uri, client);
    await patchRecordService.initialize(uri, client);
    await eventService.initialize(uri, client);
    await workflowService.initialize(uri, client);
    await userService.initialize(uri, client);
    await projectDocumentService.initialize(uri, client);
    await cranLibraryService.initialize(uri, client);
    await teamService.initialize(uri, client);
    await projectService.initialize(uri, client);
    await documentService.initialize(uri, client);
    await operatorService.initialize(uri, client);
  }
}
