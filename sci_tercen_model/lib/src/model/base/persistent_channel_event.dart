part of sci_model_base;

class PersistentChannelEventBase extends Event {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.channel_DP,
    Vocabulary.event_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _channel;
  Event _event;

  PersistentChannelEventBase()
      : _channel = "",
        _event = Event() {
    _event.parent = this;
  }

  PersistentChannelEventBase.json(Map m)
      : _channel = base.defaultValue(
            m[Vocabulary.channel_DP] as String?, base.String_DefaultFactory),
        _event = EventBase._createFromJson(m[Vocabulary.event_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.PersistentChannelEvent_CLASS, m);
    _event.parent = this;
  }

  static PersistentChannelEvent createFromJson(Map m) =>
      PersistentChannelEventBase.fromJson(m);
  static PersistentChannelEvent _createFromJson(Map? m) => m == null
      ? PersistentChannelEvent()
      : PersistentChannelEventBase.fromJson(m);
  static PersistentChannelEvent fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.PersistentChannelEvent_CLASS:
        return PersistentChannelEvent.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.PersistentChannelEvent_CLASS;
  String get channel => _channel;

  set channel(String $o) {
    if ($o == _channel) return;
    var $old = _channel;
    _channel = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.channel_DP, $old, _channel));
    }
  }

  Event get event => _event;

  set event(Event $o) {
    if ($o == _event) return;
    _event.parent = null;
    $o.parent = this;
    var $old = _event;
    _event = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.event_OP, $old, _event));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.channel_DP:
        return channel;
      case Vocabulary.event_OP:
        return event;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.channel_DP:
        channel = $value as String;
        return;
      case Vocabulary.event_OP:
        event = $value as Event;
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
  PersistentChannelEvent copy() => PersistentChannelEvent.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.PersistentChannelEvent_CLASS;
    if (subKind != null && subKind != Vocabulary.PersistentChannelEvent_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.channel_DP] = channel;
    m[Vocabulary.event_OP] = event.toJson();
    return m;
  }
}
