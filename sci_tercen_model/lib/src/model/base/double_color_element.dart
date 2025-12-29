part of sci_model_base;

class DoubleColorElementBase extends ColorElement {
  static const List<String> PROPERTY_NAMES = [Vocabulary.stringValue_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _stringValue;

  DoubleColorElementBase() : _stringValue = "";
  DoubleColorElementBase.json(Map m)
      : _stringValue = base.defaultValue(
            m[Vocabulary.stringValue_DP] as String?,
            base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.DoubleColorElement_CLASS, m);
  }

  static DoubleColorElement createFromJson(Map m) =>
      DoubleColorElementBase.fromJson(m);
  static DoubleColorElement fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.DoubleColorElement_CLASS:
        return DoubleColorElement.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.DoubleColorElement_CLASS;
  String get stringValue => _stringValue;

  set stringValue(String $o) {
    if ($o == _stringValue) return;
    var $old = _stringValue;
    _stringValue = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.stringValue_DP, $old, _stringValue));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.stringValue_DP:
        return stringValue;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.stringValue_DP:
        stringValue = $value as String;
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
  DoubleColorElement copy() => DoubleColorElement.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.DoubleColorElement_CLASS;
    if (subKind != null && subKind != Vocabulary.DoubleColorElement_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.stringValue_DP] = stringValue;
    return m;
  }
}
