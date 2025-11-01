part of sci_model;

class FailedState extends FailedStateBase {
  FailedState() : super();
  FailedState.json(super.m) : super.json();

  @override
  bool get isFinal => true;

  void throwError() => throw serviceError;

  ServiceError get serviceError =>
      ServiceError(State.FAILED_STATUS, error, reason);
}
