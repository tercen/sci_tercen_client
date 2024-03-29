part of sci_model_base;

class GlTaskBase extends Task {
  static const List<String> PROPERTY_NAMES = [Vocabulary.glQuery_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _glQuery;

  GlTaskBase() : _glQuery = "";
  GlTaskBase.json(Map m)
      : _glQuery = base.defaultValue(
            m[Vocabulary.glQuery_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GlTask_CLASS, m);
  }

  static GlTask createFromJson(Map m) => GlTaskBase.fromJson(m);
  static GlTask _createFromJson(Map? m) =>
      m == null ? GlTask() : GlTaskBase.fromJson(m);
  static GlTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GlTask_CLASS:
        return GlTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GlTask_CLASS;
  String get glQuery => _glQuery;

  set glQuery(String $o) {
    if ($o == _glQuery) return;
    var $old = _glQuery;
    _glQuery = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.glQuery_DP, $old, _glQuery));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.glQuery_DP:
        return glQuery;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.glQuery_DP:
        glQuery = $value as String;
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
  GlTask copy() => GlTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GlTask_CLASS;
    if (subKind != null && subKind != Vocabulary.GlTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.glQuery_DP] = glQuery;
    return m;
  }
}
