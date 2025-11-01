part of sci_client_base;

class ServiceFactoryBase implements api.ServiceFactory {
  @override
  late WorkerService workerService;
  @override
  late GarbageCollectorService garbageCollectorService;
  @override
  late FileService fileService;
  @override
  late LockService lockService;
  @override
  late SubscriptionPlanService subscriptionPlanService;
  @override
  late PersistentService persistentService;
  @override
  late ActivityService activityService;
  @override
  late FolderService folderService;
  @override
  late TableSchemaService tableSchemaService;
  @override
  late TaskService taskService;
  @override
  late UserSecretService userSecretService;
  @override
  late PatchRecordService patchRecordService;
  @override
  late EventService eventService;
  @override
  late WorkflowService workflowService;
  @override
  late UserService userService;
  @override
  late ProjectDocumentService projectDocumentService;
  @override
  late CranLibraryService cranLibraryService;
  @override
  late TeamService teamService;
  @override
  late ProjectService projectService;
  @override
  late DocumentService documentService;
  @override
  late OperatorService operatorService;
  ServiceFactoryBase() {
    workerService = WorkerService()..factory = this;
    garbageCollectorService = GarbageCollectorService()..factory = this;
    fileService = FileService()..factory = this;
    lockService = LockService()..factory = this;
    subscriptionPlanService = SubscriptionPlanService()..factory = this;
    persistentService = PersistentService()..factory = this;
    activityService = ActivityService()..factory = this;
    folderService = FolderService()..factory = this;
    tableSchemaService = TableSchemaService()..factory = this;
    taskService = TaskService()..factory = this;
    userSecretService = UserSecretService()..factory = this;
    patchRecordService = PatchRecordService()..factory = this;
    eventService = EventService()..factory = this;
    workflowService = WorkflowService()..factory = this;
    userService = UserService()..factory = this;
    projectDocumentService = ProjectDocumentService()..factory = this;
    cranLibraryService = CranLibraryService()..factory = this;
    teamService = TeamService()..factory = this;
    projectService = ProjectService()..factory = this;
    documentService = DocumentService()..factory = this;
    operatorService = OperatorService()..factory = this;
  }
  Future initialize() async {}
  Future initializeWith(Uri uri, [HttpClient? client]) async {
    client ??= HttpClient();
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
