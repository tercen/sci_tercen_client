part of sci_model;

class State extends StateBase {
  static const int FAILED_STATUS = -142;
  static const int CANCELED_STATUS = -142;

  State() : super();
  State.json(Map m) : super.json(m);

  bool get isFinal => false;

  void throwIfNotDone() {
    var self = this;
    if (self is DoneState) return;
    if (self is FailedState) self.throwError();
    if (self is CanceledState) self.throwError();

    throw ServiceError.bad('state.not.done.${self.runtimeType}',
        'state.not.done.${self.runtimeType}');
  }
}
