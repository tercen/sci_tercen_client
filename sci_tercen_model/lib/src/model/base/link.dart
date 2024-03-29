part of sci_model_base;

class LinkBase extends IdObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.inputId_DP,
    Vocabulary.outputId_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _inputId;
  String _outputId;

  LinkBase()
      : _inputId = "",
        _outputId = "";
  LinkBase.json(Map m)
      : _inputId = base.defaultValue(
            m[Vocabulary.inputId_DP] as String?, base.String_DefaultFactory),
        _outputId = base.defaultValue(
            m[Vocabulary.outputId_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Link_CLASS, m);
  }

  static Link createFromJson(Map m) => LinkBase.fromJson(m);
  static Link _createFromJson(Map? m) =>
      m == null ? Link() : LinkBase.fromJson(m);
  static Link fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Link_CLASS:
        return Link.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Link_CLASS;
  String get inputId => _inputId;

  set inputId(String $o) {
    if ($o == _inputId) return;
    var $old = _inputId;
    _inputId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.inputId_DP, $old, _inputId));
    }
  }

  String get outputId => _outputId;

  set outputId(String $o) {
    if ($o == _outputId) return;
    var $old = _outputId;
    _outputId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.outputId_DP, $old, _outputId));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.inputId_DP:
        return inputId;
      case Vocabulary.outputId_DP:
        return outputId;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.inputId_DP:
        inputId = $value as String;
        return;
      case Vocabulary.outputId_DP:
        outputId = $value as String;
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
  Link copy() => Link.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Link_CLASS;
    if (subKind != null && subKind != Vocabulary.Link_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.inputId_DP] = inputId;
    m[Vocabulary.outputId_DP] = outputId;
    return m;
  }
}
