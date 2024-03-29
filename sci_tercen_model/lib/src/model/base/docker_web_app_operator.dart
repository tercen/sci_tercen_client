part of sci_model_base;

class DockerWebAppOperatorBase extends WebAppOperator {
  static const List<String> PROPERTY_NAMES = [Vocabulary.container_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _container;

  DockerWebAppOperatorBase() : _container = "";
  DockerWebAppOperatorBase.json(Map m)
      : _container = base.defaultValue(
            m[Vocabulary.container_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.DockerWebAppOperator_CLASS, m);
  }

  static DockerWebAppOperator createFromJson(Map m) =>
      DockerWebAppOperatorBase.fromJson(m);
  static DockerWebAppOperator _createFromJson(Map? m) =>
      m == null ? DockerWebAppOperator() : DockerWebAppOperatorBase.fromJson(m);
  static DockerWebAppOperator fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.DockerWebAppOperator_CLASS:
        return DockerWebAppOperator.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.DockerWebAppOperator_CLASS;
  String get container => _container;

  set container(String $o) {
    if ($o == _container) return;
    var $old = _container;
    _container = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.container_DP, $old, _container));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.container_DP:
        return container;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.container_DP:
        container = $value as String;
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
  DockerWebAppOperator copy() => DockerWebAppOperator.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.DockerWebAppOperator_CLASS;
    if (subKind != null && subKind != Vocabulary.DockerWebAppOperator_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.container_DP] = container;
    return m;
  }
}
