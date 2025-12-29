part of sci_model_base;

class RLibraryBase extends Document {
  static const List<String> PROPERTY_NAMES = [Vocabulary.rDescription_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  RDescription _rDescription;

  RLibraryBase() : _rDescription = RDescription() {
    _rDescription.parent = this;
  }

  RLibraryBase.json(Map m)
      : _rDescription = (m[Vocabulary.rDescription_OP] as Map?) == null
            ? RDescription()
            : RDescriptionBase.fromJson(m[Vocabulary.rDescription_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.RLibrary_CLASS, m);
    _rDescription.parent = this;
  }

  static RLibrary createFromJson(Map m) => RLibraryBase.fromJson(m);
  static RLibrary fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.RLibrary_CLASS:
        return RLibrary.json(m);
      case Vocabulary.RSourceLibrary_CLASS:
        return RSourceLibrary.json(m);
      case Vocabulary.RenvInstalledLibrary_CLASS:
        return RenvInstalledLibrary.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.RLibrary_CLASS;
  RDescription get rDescription => _rDescription;

  set rDescription(RDescription $o) {
    if ($o == _rDescription) return;
    _rDescription.parent = null;
    $o.parent = this;
    var $old = _rDescription;
    _rDescription = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.rDescription_OP, $old, _rDescription));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.rDescription_OP:
        return rDescription;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.rDescription_OP:
        rDescription = $value as RDescription;
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
  RLibrary copy() => RLibrary.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.RLibrary_CLASS;
    if (subKind != null && subKind != Vocabulary.RLibrary_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.rDescription_OP] = rDescription.toJson();
    return m;
  }
}
