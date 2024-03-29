part of sci_model_base;

class WebAppOperatorBase extends GitOperator {
  static const List<String> PROPERTY_NAMES = [Vocabulary.isViewOnly_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  bool _isViewOnly;

  WebAppOperatorBase() : _isViewOnly = true;
  WebAppOperatorBase.json(Map m)
      : _isViewOnly = base.defaultValue(
            m[Vocabulary.isViewOnly_DP] as bool?, base.bool_DefaultFactory),
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

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.isViewOnly_DP:
        return isViewOnly;
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
    return m;
  }
}
