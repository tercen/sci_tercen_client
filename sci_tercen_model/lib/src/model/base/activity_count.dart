part of sci_model_base;

class ActivityCountBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.objectId_DP,
    Vocabulary.count_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.objectId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("PersistentObject", Vocabulary.objectId_DP, isComposite: false)
  ];
  String _objectId;
  int _count;

  ActivityCountBase()
      : _objectId = "",
        _count = 0;
  ActivityCountBase.json(Map m)
      : _objectId = base.defaultValue(
            m[Vocabulary.objectId_DP] as String?, base.String_DefaultFactory),
        _count = base.defaultValue(
            m[Vocabulary.count_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ActivityCount_CLASS, m);
  }

  static ActivityCount createFromJson(Map m) => ActivityCountBase.fromJson(m);
  static ActivityCount _createFromJson(Map? m) =>
      m == null ? ActivityCount() : ActivityCountBase.fromJson(m);
  static ActivityCount fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ActivityCount_CLASS:
        return ActivityCount.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ActivityCount_CLASS;
  String get objectId => _objectId;

  set objectId(String $o) {
    if ($o == _objectId) return;
    var $old = _objectId;
    _objectId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.objectId_DP, $old, _objectId));
    }
  }

  int get count => _count;

  set count(int $o) {
    if ($o == _count) return;
    var $old = _count;
    _count = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.count_DP, $old, _count));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.objectId_DP:
        return objectId;
      case Vocabulary.count_DP:
        return count;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.objectId_DP:
        objectId = $value as String;
        return;
      case Vocabulary.count_DP:
        count = $value as int;
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

  ActivityCount copy() => ActivityCount.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ActivityCount_CLASS;
    if (subKind != null && subKind != Vocabulary.ActivityCount_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.objectId_DP] = objectId;
    m[Vocabulary.count_DP] = count;
    return m;
  }
}
