part of sci_model_base;

class StepBase extends IdObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.groupId_DP,
    Vocabulary.name_DP,
    Vocabulary.inputs_OP,
    Vocabulary.outputs_OP,
    Vocabulary.rectangle_OP,
    Vocabulary.state_OP,
    Vocabulary.description_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _groupId;
  String _name;
  final base.ListChanged<InputPort> inputs;
  final base.ListChanged<OutputPort> outputs;
  Rectangle _rectangle;
  StepState _state;
  String _description;

  StepBase()
      : _groupId = "",
        _name = "",
        _description = "",
        inputs = base.ListChanged<InputPort>(),
        outputs = base.ListChanged<OutputPort>(),
        _rectangle = Rectangle(),
        _state = StepState() {
    inputs.parent = this;
    outputs.parent = this;
    _rectangle.parent = this;
    _state.parent = this;
  }

  StepBase.json(Map m)
      : _groupId = base.defaultValue(
            m[Vocabulary.groupId_DP] as String?, base.String_DefaultFactory),
        _name = base.defaultValue(
            m[Vocabulary.name_DP] as String?, base.String_DefaultFactory),
        _description = base.defaultValue(
            m[Vocabulary.description_DP] as String?,
            base.String_DefaultFactory),
        inputs = base.ListChanged<InputPort>.from(
            m[Vocabulary.inputs_OP] as List?, InputPortBase.createFromJson),
        outputs = base.ListChanged<OutputPort>.from(
            m[Vocabulary.outputs_OP] as List?, OutputPortBase.createFromJson),
        _rectangle = (m[Vocabulary.rectangle_OP] as Map?) == null
            ? Rectangle()
            : RectangleBase.fromJson(m[Vocabulary.rectangle_OP] as Map),
        _state = (m[Vocabulary.state_OP] as Map?) == null
            ? StepState()
            : StepStateBase.fromJson(m[Vocabulary.state_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Step_CLASS, m);
    inputs.parent = this;
    outputs.parent = this;
    _rectangle.parent = this;
    _state.parent = this;
  }

  static Step createFromJson(Map m) => StepBase.fromJson(m);
  static Step fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Step_CLASS:
        return Step.json(m);
      case Vocabulary.DataStep_CLASS:
        return DataStep.json(m);
      case Vocabulary.MeltStep_CLASS:
        return MeltStep.json(m);
      case Vocabulary.JoinStep_CLASS:
        return JoinStep.json(m);
      case Vocabulary.WizardStep_CLASS:
        return WizardStep.json(m);
      case Vocabulary.CrossTabStep_CLASS:
        return CrossTabStep.json(m);
      case Vocabulary.GroupStep_CLASS:
        return GroupStep.json(m);
      case Vocabulary.InStep_CLASS:
        return InStep.json(m);
      case Vocabulary.OutStep_CLASS:
        return OutStep.json(m);
      case Vocabulary.TableStep_CLASS:
        return TableStep.json(m);
      case Vocabulary.NamespaceStep_CLASS:
        return NamespaceStep.json(m);
      case Vocabulary.RelationStep_CLASS:
        return RelationStep.json(m);
      case Vocabulary.ExportStep_CLASS:
        return ExportStep.json(m);
      case Vocabulary.ModelStep_CLASS:
        return ModelStep.json(m);
      case Vocabulary.ViewStep_CLASS:
        return ViewStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Step_CLASS;
  String get groupId => _groupId;

  set groupId(String $o) {
    if ($o == _groupId) return;
    var $old = _groupId;
    _groupId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.groupId_DP, $old, _groupId));
    }
  }

  String get name => _name;

  set name(String $o) {
    if ($o == _name) return;
    var $old = _name;
    _name = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.name_DP, $old, _name));
    }
  }

  String get description => _description;

  set description(String $o) {
    if ($o == _description) return;
    var $old = _description;
    _description = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.description_DP, $old, _description));
    }
  }

  Rectangle get rectangle => _rectangle;

  set rectangle(Rectangle $o) {
    if ($o == _rectangle) return;
    _rectangle.parent = null;
    $o.parent = this;
    var $old = _rectangle;
    _rectangle = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.rectangle_OP, $old, _rectangle));
    }
  }

  StepState get state => _state;

  set state(StepState $o) {
    if ($o == _state) return;
    _state.parent = null;
    $o.parent = this;
    var $old = _state;
    _state = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.state_OP, $old, _state));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.groupId_DP:
        return groupId;
      case Vocabulary.name_DP:
        return name;
      case Vocabulary.inputs_OP:
        return inputs;
      case Vocabulary.outputs_OP:
        return outputs;
      case Vocabulary.rectangle_OP:
        return rectangle;
      case Vocabulary.state_OP:
        return state;
      case Vocabulary.description_DP:
        return description;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.groupId_DP:
        groupId = $value as String;
        return;
      case Vocabulary.name_DP:
        name = $value as String;
        return;
      case Vocabulary.description_DP:
        description = $value as String;
        return;
      case Vocabulary.inputs_OP:
        inputs.setValues($value as Iterable<InputPort>);
        return;
      case Vocabulary.outputs_OP:
        outputs.setValues($value as Iterable<OutputPort>);
        return;
      case Vocabulary.rectangle_OP:
        rectangle = $value as Rectangle;
        return;
      case Vocabulary.state_OP:
        state = $value as StepState;
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
  Step copy() => Step.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Step_CLASS;
    if (subKind != null && subKind != Vocabulary.Step_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.groupId_DP] = groupId;
    m[Vocabulary.name_DP] = name;
    m[Vocabulary.inputs_OP] = inputs.toJson();
    m[Vocabulary.outputs_OP] = outputs.toJson();
    m[Vocabulary.rectangle_OP] = rectangle.toJson();
    m[Vocabulary.state_OP] = state.toJson();
    m[Vocabulary.description_DP] = description;
    return m;
  }
}
