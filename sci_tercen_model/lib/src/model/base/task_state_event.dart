part of sci_model_base;

class TaskStateEventBase extends TaskEvent {
  static const List<String> PROPERTY_NAMES = [Vocabulary.state_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  State _state;

  TaskStateEventBase() : _state = State() {
    _state.parent = this;
  }

  TaskStateEventBase.json(Map m)
      : _state = StateBase._createFromJson(m[Vocabulary.state_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TaskStateEvent_CLASS, m);
    _state.parent = this;
  }

  static TaskStateEvent createFromJson(Map m) => TaskStateEventBase.fromJson(m);
  static TaskStateEvent _createFromJson(Map? m) =>
      m == null ? TaskStateEvent() : TaskStateEventBase.fromJson(m);
  static TaskStateEvent fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TaskStateEvent_CLASS:
        return TaskStateEvent.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TaskStateEvent_CLASS;
  State get state => _state;

  set state(State $o) {
    if ($o == _state) return;
    _state.parent = null;
    $o.parent = this;
    var $old = _state;
    _state = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.state_OP, $old, _state));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.state_OP:
        return state;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.state_OP:
        state = $value as State;
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
  TaskStateEvent copy() => TaskStateEvent.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TaskStateEvent_CLASS;
    if (subKind != null && subKind != Vocabulary.TaskStateEvent_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.state_OP] = state.toJson();
    return m;
  }
}
