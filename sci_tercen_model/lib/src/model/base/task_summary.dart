part of sci_model_base;

class TaskSummaryBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.n_DP,
    Vocabulary.duration_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  int _n;
  double _duration;

  TaskSummaryBase()
      : _n = 0,
        _duration = 0.0;
  TaskSummaryBase.json(Map m)
      : _n = base.defaultValue(
            m[Vocabulary.n_DP] as int?, base.int_DefaultFactory),
        _duration = base.defaultDouble(m[Vocabulary.duration_DP] as num?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.TaskSummary_CLASS, m);
  }

  static TaskSummary createFromJson(Map m) => TaskSummaryBase.fromJson(m);
  static TaskSummary _createFromJson(Map? m) =>
      m == null ? TaskSummary() : TaskSummaryBase.fromJson(m);
  static TaskSummary fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.TaskSummary_CLASS:
        return TaskSummary.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.TaskSummary_CLASS;
  int get n => _n;

  set n(int $o) {
    if ($o == _n) return;
    var $old = _n;
    _n = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.n_DP, $old, _n));
    }
  }

  double get duration => _duration;

  set duration(double $o) {
    if ($o == _duration) return;
    var $old = _duration;
    _duration = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.duration_DP, $old, _duration));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.n_DP:
        return n;
      case Vocabulary.duration_DP:
        return duration;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.n_DP:
        n = $value as int;
        return;
      case Vocabulary.duration_DP:
        duration = $value as double;
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
  TaskSummary copy() => TaskSummary.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.TaskSummary_CLASS;
    if (subKind != null && subKind != Vocabulary.TaskSummary_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.n_DP] = n;
    m[Vocabulary.duration_DP] = duration;
    return m;
  }
}
