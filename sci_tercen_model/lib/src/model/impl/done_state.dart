part of sci_model;

class DoneState extends DoneStateBase {
  DoneState() : super();
  DoneState.json(Map m) : super.json(m);

  bool get isFinal => true;
}
