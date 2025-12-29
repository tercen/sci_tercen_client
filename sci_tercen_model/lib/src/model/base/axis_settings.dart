part of sci_model_base;

class AxisSettingsBase extends base.Base {
  static const List<String> PROPERTY_NAMES = [Vocabulary.meta_OP];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Pair> meta;

  AxisSettingsBase() : meta = base.ListChanged<Pair>() {
    meta.parent = this;
  }

  AxisSettingsBase.json(Map m)
      : meta = base.ListChanged<Pair>.from(
            m[Vocabulary.meta_OP] as List?, PairBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.AxisSettings_CLASS, m);
    meta.parent = this;
  }

  static AxisSettings createFromJson(Map m) => AxisSettingsBase.fromJson(m);
  static AxisSettings fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.AxisSettings_CLASS:
        return AxisSettings.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.AxisSettings_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.meta_OP:
        return meta;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.meta_OP:
        meta.setValues($value as Iterable<Pair>);
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

  AxisSettings copy() => AxisSettings.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.AxisSettings_CLASS;
    if (subKind != null && subKind != Vocabulary.AxisSettings_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.meta_OP] = meta.toJson();
    return m;
  }
}
