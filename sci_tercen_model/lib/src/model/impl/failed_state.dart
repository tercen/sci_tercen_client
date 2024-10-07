part of sci_model;

class FailedState extends FailedStateBase {
  FailedState() : super();
  FailedState.json(Map m) : super.json(m);

  bool get isFinal => true;

  void throwError() => throw serviceError;

  ServiceError get serviceError =>
      ServiceError(State.FAILED_STATUS, error, reason);
}
