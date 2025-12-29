part of sci_model_base;

class TaskLogEventBase extends TaskEvent {
  static const List<String> PROPERTY_NAMES = [Vocabulary.message_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _message;

  TaskLogEventBase() : _message = "";
  TaskLogEventBase.json(Map m)
      : _message = base.defaultValue(
            m[Vocabulary.message_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TaskLogEvent_CLASS, m);
  }

  static TaskLogEvent createFromJson(Map m) => TaskLogEventBase.fromJson(m);
  static TaskLogEvent fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TaskLogEvent_CLASS:
        return TaskLogEvent.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TaskLogEvent_CLASS;
  String get message => _message;

  set message(String $o) {
    if ($o == _message) return;
    var $old = _message;
    _message = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.message_DP, $old, _message));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.message_DP:
        return message;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.message_DP:
        message = $value as String;
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
  TaskLogEvent copy() => TaskLogEvent.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TaskLogEvent_CLASS;
    if (subKind != null && subKind != Vocabulary.TaskLogEvent_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.message_DP] = message;
    return m;
  }
}
