part of sci_model;

class DoneState extends DoneStateBase {
  DoneState() : super();
  DoneState.json(super.m) : super.json();

  @override
  bool get isFinal => true;
}
