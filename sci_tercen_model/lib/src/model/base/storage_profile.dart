part of sci_model_base;

class StorageProfileBase extends Profile {
  static const List<String> PROPERTY_NAMES = [Vocabulary.size_DP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _size;

  StorageProfileBase() : _size = 0;
  StorageProfileBase.json(Map m)
      : _size = base.defaultValue(
            m[Vocabulary.size_DP] as int?, base.int_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.StorageProfile_CLASS, m);
  }

  static StorageProfile createFromJson(Map m) => StorageProfileBase.fromJson(m);
  static StorageProfile fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.StorageProfile_CLASS:
        return StorageProfile.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.StorageProfile_CLASS;
  int get size => _size;

  set size(int $o) {
    if ($o == _size) return;
    var $old = _size;
    _size = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.size_DP, $old, _size));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.size_DP:
        return size;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.size_DP:
        size = $value as int;
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
  StorageProfile copy() => StorageProfile.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.StorageProfile_CLASS;
    if (subKind != null && subKind != Vocabulary.StorageProfile_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.size_DP] = size;
    return m;
  }
}
