part of sci_base;

mixin class EventSource {
  static StreamController<ChangedEvent> NULL_STREAM_CONTROLLER =
      StreamController.broadcast(sync: true);

  bool noEvent = false;
  EventSource? _parent;
  StreamController<ChangedEvent>? _changedController;

  EventSource? get parent => _parent;

  dynamic toJson() => {};

  set parent(EventSource? p) {
    _parent = p;
  }

  EventSource? getParent() {
    if (parent == null) return null;
    assert(parent is! ListChangedBase);
    if (parent is ListChanged) {
      return parent!.parent;
    } else {
      return parent;
    }
  }

  bool get hasListener =>
      !noEvent &&
      ((_changedController != null && _changedController!.hasListener) ||
          (_parent != null && _parent!.hasListener));

  void onChildChanged(ChangedEvent evt) {
    sendChangeEvent(evt);
  }

  void noEventDo(void Function() fun) {
    var old = noEvent;
    noEvent = true;
    try {
      fun();
    } finally {
      noEvent = old;
    }
  }

  Stream<ChangedEvent> get onChange {
    _changedController ??= StreamController.broadcast(sync: true);
    return _changedController!.stream;
  }

  void sendChangeEvent(ChangedEvent evt) {
    if (noEvent) return;

    var parent = _parent;
    if (parent != null) {
      parent.onChildChanged(evt);
    }

    var controller = _changedController;

    if (controller != null && controller.hasListener) {
      controller.add(evt);
    }
  }
}
