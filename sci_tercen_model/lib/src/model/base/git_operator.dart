part of sci_model_base;

class GitOperatorBase extends Operator {
  static const List<String> PROPERTY_NAMES = [Vocabulary.path_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _path;

  GitOperatorBase() : _path = "";
  GitOperatorBase.json(Map m)
      : _path = base.defaultValue(
            m[Vocabulary.path_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GitOperator_CLASS, m);
  }

  static GitOperator createFromJson(Map m) => GitOperatorBase.fromJson(m);
  static GitOperator _createFromJson(Map? m) =>
      m == null ? GitOperator() : GitOperatorBase.fromJson(m);
  static GitOperator fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GitOperator_CLASS:
        return GitOperator.json(m);
      case Vocabulary.ShinyOperator_CLASS:
        return ShinyOperator.json(m);
      case Vocabulary.DockerWebAppOperator_CLASS:
        return DockerWebAppOperator.json(m);
      case Vocabulary.DockerOperator_CLASS:
        return DockerOperator.json(m);
      case Vocabulary.ROperator_CLASS:
        return ROperator.json(m);
      case Vocabulary.WebAppOperator_CLASS:
        return WebAppOperator.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GitOperator_CLASS;
  String get path => _path;

  set path(String $o) {
    if ($o == _path) return;
    var $old = _path;
    _path = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.path_DP, $old, _path));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.path_DP:
        return path;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.path_DP:
        path = $value as String;
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
  GitOperator copy() => GitOperator.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GitOperator_CLASS;
    if (subKind != null && subKind != Vocabulary.GitOperator_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.path_DP] = path;
    return m;
  }
}
