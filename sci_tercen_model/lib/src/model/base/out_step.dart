part of sci_model_base;

class OutStepBase extends RelationStep {
  static const List<String> PROPERTY_NAMES = [Vocabulary.groupPortPosition_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Point _groupPortPosition;

  OutStepBase() : _groupPortPosition = Point() {
    _groupPortPosition.parent = this;
  }

  OutStepBase.json(Map m)
      : _groupPortPosition = PointBase._createFromJson(
            m[Vocabulary.groupPortPosition_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.OutStep_CLASS, m);
    _groupPortPosition.parent = this;
  }

  static OutStep createFromJson(Map m) => OutStepBase.fromJson(m);
  static OutStep _createFromJson(Map? m) =>
      m == null ? OutStep() : OutStepBase.fromJson(m);
  static OutStep fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.OutStep_CLASS:
        return OutStep.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.OutStep_CLASS;
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
  OutStep copy() => OutStep.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.OutStep_CLASS;
    if (subKind != null && subKind != Vocabulary.OutStep_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.groupPortPosition_OP] = groupPortPosition.toJson();
    return m;
  }
}
