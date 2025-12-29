part of sci_model_base;

class TaskEventBase extends Event {
  static const List<String> PROPERTY_NAMES = [Vocabulary.taskId_DP];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.taskId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Task", Vocabulary.taskId_DP, isComposite: false)
  ];
  String _taskId;

  TaskEventBase() : _taskId = "";
  TaskEventBase.json(Map m)
      : _taskId = base.defaultValue(
            m[Vocabulary.taskId_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TaskEvent_CLASS, m);
  }

  static TaskEvent createFromJson(Map m) => TaskEventBase.fromJson(m);
  static TaskEvent fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TaskEvent_CLASS:
        return TaskEvent.json(m);
      case Vocabulary.TaskLogEvent_CLASS:
        return TaskLogEvent.json(m);
      case Vocabulary.TaskProgressEvent_CLASS:
        return TaskProgressEvent.json(m);
      case Vocabulary.TaskDataEvent_CLASS:
        return TaskDataEvent.json(m);
      case Vocabulary.TaskStateEvent_CLASS:
        return TaskStateEvent.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TaskEvent_CLASS;
  String get taskId => _taskId;

  set taskId(String $o) {
    if ($o == _taskId) return;
    var $old = _taskId;
    _taskId = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.taskId_DP, $old, _taskId));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.taskId_DP:
        return taskId;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.taskId_DP:
        taskId = $value as String;
        return;
      default:
        super.set($name, $value);
    }
  }

  @override
  Iterable<String> getPropertyNames() =>
      super.getPropertyNames().followedBy(PROPERTY_NAMES);
  @override
  Iterable<base.RefId> refIds() => super.refIds().followedBy(REF_IDS);

  @override
  TaskEvent copy() => TaskEvent.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TaskEvent_CLASS;
    if (subKind != null && subKind != Vocabulary.TaskEvent_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.taskId_DP] = taskId;
    return m;
  }
}
