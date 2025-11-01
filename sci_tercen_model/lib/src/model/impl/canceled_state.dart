part of sci_model;

class CanceledState extends CanceledStateBase {
  CanceledState() : super();
  CanceledState.json(super.m) : super.json();

  @override
  bool get isFinal => true;

  void throwError() =>
      throw ServiceError(State.CANCELED_STATUS, 'state.canceled', 'Canceled');
}
