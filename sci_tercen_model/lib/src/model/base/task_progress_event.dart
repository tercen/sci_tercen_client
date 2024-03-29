part of sci_model_base;

class TaskProgressEventBase extends TaskEvent {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.message_DP,
    Vocabulary.total_DP,
    Vocabulary.actual_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _message;
  int _total;
  int _actual;

  TaskProgressEventBase()
      : _message = "",
        _total = 0,
        _actual = 0;
  TaskProgressEventBase.json(Map m)
      : _message = base.defaultValue(
            m[Vocabulary.message_DP] as String?, base.String_DefaultFactory),
        _total = base.defaultValue(
            m[Vocabulary.total_DP] as int?, base.int_DefaultFactory),
        _actual = base.defaultValue(
            m[Vocabulary.actual_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TaskProgressEvent_CLASS, m);
  }

  static TaskProgressEvent createFromJson(Map m) =>
      TaskProgressEventBase.fromJson(m);
  static TaskProgressEvent _createFromJson(Map? m) =>
      m == null ? TaskProgressEvent() : TaskProgressEventBase.fromJson(m);
  static TaskProgressEvent fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TaskProgressEvent_CLASS:
        return TaskProgressEvent.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TaskProgressEvent_CLASS;
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

  int get total => _total;

  set total(int $o) {
    if ($o == _total) return;
    var $old = _total;
    _total = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.total_DP, $old, _total));
    }
  }

  int get actual => _actual;

  set actual(int $o) {
    if ($o == _actual) return;
    var $old = _actual;
    _actual = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.actual_DP, $old, _actual));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.message_DP:
        return message;
      case Vocabulary.total_DP:
        return total;
      case Vocabulary.actual_DP:
        return actual;
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
      case Vocabulary.total_DP:
        total = $value as int;
        return;
      case Vocabulary.actual_DP:
        actual = $value as int;
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
  TaskProgressEvent copy() => TaskProgressEvent.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TaskProgressEvent_CLASS;
    if (subKind != null && subKind != Vocabulary.TaskProgressEvent_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.message_DP] = message;
    m[Vocabulary.total_DP] = total;
    m[Vocabulary.actual_DP] = actual;
    return m;
  }
}
