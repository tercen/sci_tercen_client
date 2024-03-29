part of sci_model_base;

class InStepBase extends RelationStep {
  static const List<String> PROPERTY_NAMES = [Vocabulary.groupPortPosition_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Point _groupPortPosition;

  InStepBase() : _groupPortPosition = Point() {
    _groupPortPosition.parent = this;
  }

  InStepBase.json(Map m)
      : _groupPortPosition = PointBase._createFromJson(
            m[Vocabulary.groupPortPosition_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.InStep_CLASS, m);
    _groupPortPosition.parent = this;
  }

  static InStep createFromJson(Map m) => InStepBase.fromJson(m);
  static InStep _createFromJson(Map? m) =>
      m == null ? InStep() : InStepBase.fromJson(m);
  static InStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.InStep_CLASS:
        return InStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.InStep_CLASS;
  Point get groupPortPosition => _groupPortPosition;

  set groupPortPosition(Point $o) {
    if ($o == _groupPortPosition) return;
    _groupPortPosition.parent = null;
    $o.parent = this;
    var $old = _groupPortPosition;
    _groupPortPosition = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.groupPortPosition_OP, $old, _groupPortPosition));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.groupPortPosition_OP:
        return groupPortPosition;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.groupPortPosition_OP:
        groupPortPosition = $value as Point;
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
  InStep copy() => InStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.InStep_CLASS;
    if (subKind != null && subKind != Vocabulary.InStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.groupPortPosition_OP] = groupPortPosition.toJson();
    return m;
  }
}
