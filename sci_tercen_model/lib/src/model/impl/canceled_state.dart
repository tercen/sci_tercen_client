part of sci_model;

class CanceledState extends CanceledStateBase {
  CanceledState() : super();
  CanceledState.json(Map m) : super.json(m);

  bool get isFinal => true;

  void throwError() =>
      throw ServiceError(State.CANCELED_STATUS, 'state.canceled', 'Canceled');
}
