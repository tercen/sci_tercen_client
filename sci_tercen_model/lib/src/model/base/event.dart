part of sci_model_base;

class EventBase extends PersistentObject {
  static const List<String> PROPERTY_NAMES = [Vocabulary.date_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Date _date;

  EventBase() : _date = Date() {
    _date.parent = this;
  }

  EventBase.json(Map m)
      : _date = DateBase._createFromJson(m[Vocabulary.date_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Event_CLASS, m);
    _date.parent = this;
  }

  static Event createFromJson(Map m) => EventBase.fromJson(m);
  static Event _createFromJson(Map? m) =>
      m == null ? Event() : EventBase.fromJson(m);
  static Event fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Event_CLASS:
        return Event.json(m);
      case Vocabulary.TaskLogEvent_CLASS:
        return TaskLogEvent.json(m);
      case Vocabulary.TaskProgressEvent_CLASS:
        return TaskProgressEvent.json(m);
      case Vocabulary.TaskDataEvent_CLASS:
        return TaskDataEvent.json(m);
      case Vocabulary.TaskStateEvent_CLASS:
        return TaskStateEvent.json(m);
      case Vocabulary.PatchRecords_CLASS:
        return PatchRecords.json(m);
      case Vocabulary.TaskEvent_CLASS:
        return TaskEvent.json(m);
      case Vocabulary.GenericEvent_CLASS:
        return GenericEvent.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Event_CLASS;
  Date get date => _date;

  set date(Date $o) {
    if ($o == _date) return;
    _date.parent = null;
    $o.parent = this;
    var $old = _date;
    _date = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.date_OP, $old, _date));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.date_OP:
        return date;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.date_OP:
        date = $value as Date;
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
  Event copy() => Event.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Event_CLASS;
    if (subKind != null && subKind != Vocabulary.Event_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.date_OP] = date.toJson();
    return m;
  }
}
