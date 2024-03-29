part of sci_model_base;

class TaskDataEventBase extends TaskEvent {
  static const List<String> PROPERTY_NAMES = [Vocabulary.bytes_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Uint8List _bytes;

  TaskDataEventBase() : _bytes = Uint8List(0);
  TaskDataEventBase.json(Map m)
      : _bytes = base.defaultValue(m[Vocabulary.bytes_DP] as Uint8List?,
            base.Uint8List_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TaskDataEvent_CLASS, m);
  }

  static TaskDataEvent createFromJson(Map m) => TaskDataEventBase.fromJson(m);
  static TaskDataEvent _createFromJson(Map? m) =>
      m == null ? TaskDataEvent() : TaskDataEventBase.fromJson(m);
  static TaskDataEvent fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TaskDataEvent_CLASS:
        return TaskDataEvent.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TaskDataEvent_CLASS;
  Uint8List get bytes => _bytes;

  set bytes(Uint8List $o) {
    if ($o == _bytes) return;
    var $old = _bytes;
    _bytes = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.bytes_DP, $old, _bytes));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.bytes_DP:
        return bytes;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.bytes_DP:
        bytes = $value as Uint8List;
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
  TaskDataEvent copy() => TaskDataEvent.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TaskDataEvent_CLASS;
    if (subKind != null && subKind != Vocabulary.TaskDataEvent_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.bytes_DP] = bytes;
    return m;
  }
}
