part of sci_model_base;

class WebAppOperatorBase extends GitOperator {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.isViewOnly_DP,
    Vocabulary.entryType_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  bool _isViewOnly;
  String _entryType;

  WebAppOperatorBase()
      : _isViewOnly = true,
        _entryType = "";
  WebAppOperatorBase.json(Map m)
      : _isViewOnly = base.defaultValue(
            m[Vocabulary.isViewOnly_DP] as bool?, base.bool_DefaultFactory),
        _entryType = base.defaultValue(
            m[Vocabulary.entryType_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.WebAppOperator_CLASS, m);
  }

  static WebAppOperator createFromJson(Map m) => WebAppOperatorBase.fromJson(m);
  static WebAppOperator _createFromJson(Map? m) =>
      m == null ? WebAppOperator() : WebAppOperatorBase.fromJson(m);
  static WebAppOperator fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.WebAppOperator_CLASS:
        return WebAppOperator.json(m);
      case Vocabulary.ShinyOperator_CLASS:
        return ShinyOperator.json(m);
      case Vocabulary.DockerWebAppOperator_CLASS:
        return DockerWebAppOperator.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.WebAppOperator_CLASS;
  bool get isViewOnly => _isViewOnly;

  set isViewOnly(bool $o) {
    if ($o == _isViewOnly) return;
    var $old = _isViewOnly;
    _isViewOnly = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.isViewOnly_DP, $old, _isViewOnly));
    }
  }

  String get entryType => _entryType;

  set entryType(String $o) {
    if ($o == _entryType) return;
    var $old = _entryType;
    _entryType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.entryType_DP, $old, _entryType));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.isViewOnly_DP:
        return isViewOnly;
      case Vocabulary.entryType_DP:
        return entryType;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.isViewOnly_DP:
        isViewOnly = $value as bool;
        return;
      case Vocabulary.entryType_DP:
        entryType = $value as String;
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
  WebAppOperator copy() => WebAppOperator.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.WebAppOperator_CLASS;
    if (subKind != null && subKind != Vocabulary.WebAppOperator_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.isViewOnly_DP] = isViewOnly;
    m[Vocabulary.entryType_DP] = entryType;
    return m;
  }
}
