part of sci_model_base;

class GarbageTasks2Base extends GarbageObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.date_DP,
    Vocabulary.workflowId_DP,
    Vocabulary.deletedTaskIds_DP,
    Vocabulary.addedTaskIds_DP,
    Vocabulary.deletedStepIds_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _date;
  String _workflowId;
  final base.ListChangedBase<String> deletedTaskIds;
  final base.ListChangedBase<String> addedTaskIds;
  final base.ListChangedBase<String> deletedStepIds;

  GarbageTasks2Base()
      : _date = "",
        _workflowId = "",
        deletedTaskIds = base.ListChangedBase<String>(),
        addedTaskIds = base.ListChangedBase<String>(),
        deletedStepIds = base.ListChangedBase<String>() {
    deletedTaskIds.parent = this;
    addedTaskIds.parent = this;
    deletedStepIds.parent = this;
  }

  GarbageTasks2Base.json(Map m)
      : _date = base.defaultValue(
            m[Vocabulary.date_DP] as String?, base.String_DefaultFactory),
        _workflowId = base.defaultValue(
            m[Vocabulary.workflowId_DP] as String?, base.String_DefaultFactory),
        deletedTaskIds = base.ListChangedBase<String>(
            m[Vocabulary.deletedTaskIds_DP] as List?),
        addedTaskIds = base.ListChangedBase<String>(
            m[Vocabulary.addedTaskIds_DP] as List?),
        deletedStepIds = base.ListChangedBase<String>(
            m[Vocabulary.deletedStepIds_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.GarbageTasks2_CLASS, m);
    deletedTaskIds.parent = this;
    addedTaskIds.parent = this;
    deletedStepIds.parent = this;
  }

  static GarbageTasks2 createFromJson(Map m) => GarbageTasks2Base.fromJson(m);
  static GarbageTasks2 fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.GarbageTasks2_CLASS:
        return GarbageTasks2.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.GarbageTasks2_CLASS;
  String get date => _date;

  set date(String $o) {
    if ($o == _date) return;
    var $old = _date;
    _date = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.date_DP, $old, _date));
    }
  }

  String get workflowId => _workflowId;

  set workflowId(String $o) {
    if ($o == _workflowId) return;
    var $old = _workflowId;
    _workflowId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.workflowId_DP, $old, _workflowId));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.date_DP:
        return date;
      case Vocabulary.workflowId_DP:
        return workflowId;
      case Vocabulary.deletedTaskIds_DP:
        return deletedTaskIds;
      case Vocabulary.addedTaskIds_DP:
        return addedTaskIds;
      case Vocabulary.deletedStepIds_DP:
        return deletedStepIds;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.date_DP:
        date = $value as String;
        return;
      case Vocabulary.workflowId_DP:
        workflowId = $value as String;
        return;
      case Vocabulary.deletedTaskIds_DP:
        deletedTaskIds.setValues($value as Iterable<String>);
        return;
      case Vocabulary.addedTaskIds_DP:
        addedTaskIds.setValues($value as Iterable<String>);
        return;
      case Vocabulary.deletedStepIds_DP:
        deletedStepIds.setValues($value as Iterable<String>);
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
  GarbageTasks2 copy() => GarbageTasks2.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.GarbageTasks2_CLASS;
    if (subKind != null && subKind != Vocabulary.GarbageTasks2_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.date_DP] = date;
    m[Vocabulary.workflowId_DP] = workflowId;
    m[Vocabulary.deletedTaskIds_DP] = deletedTaskIds;
    m[Vocabulary.addedTaskIds_DP] = addedTaskIds;
    m[Vocabulary.deletedStepIds_DP] = deletedStepIds;
    return m;
  }
}
