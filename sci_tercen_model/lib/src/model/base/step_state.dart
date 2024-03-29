part of sci_model_base;

class StepStateBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.taskId_DP,
    Vocabulary.taskState_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.taskId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("Task", Vocabulary.taskId_DP, isComposite: true)
  ];
  String _taskId;
  State _taskState;

  StepStateBase()
      : _taskId = "",
        _taskState = State() {
    _taskState.parent = this;
  }

  StepStateBase.json(Map m)
      : _taskId = base.defaultValue(
            m[Vocabulary.taskId_DP] as String?, base.String_DefaultFactory),
        _taskState =
            StateBase._createFromJson(m[Vocabulary.taskState_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.StepState_CLASS, m);
    _taskState.parent = this;
  }

  static StepState createFromJson(Map m) => StepStateBase.fromJson(m);
  static StepState _createFromJson(Map? m) =>
      m == null ? StepState() : StepStateBase.fromJson(m);
  static StepState fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.StepState_CLASS:
        return StepState.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.StepState_CLASS;
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

  State get taskState => _taskState;

  set taskState(State $o) {
    if ($o == _taskState) return;
    _taskState.parent = null;
    $o.parent = this;
    var $old = _taskState;
    _taskState = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.taskState_OP, $old, _taskState));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.taskId_DP:
        return taskId;
      case Vocabulary.taskState_OP:
        return taskState;
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
      case Vocabulary.taskState_OP:
        taskState = $value as State;
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
  StepState copy() => StepState.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.StepState_CLASS;
    if (subKind != null && subKind != Vocabulary.StepState_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.taskId_DP] = taskId;
    m[Vocabulary.taskState_OP] = taskState.toJson();
    return m;
  }
}
