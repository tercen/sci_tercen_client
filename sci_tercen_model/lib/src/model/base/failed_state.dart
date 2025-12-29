part of sci_model_base;

class FailedStateBase extends State {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.error_DP,
    Vocabulary.reason_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _error;
  String _reason;

  FailedStateBase()
      : _error = "",
        _reason = "";
  FailedStateBase.json(Map m)
      : _error = base.defaultValue(
            m[Vocabulary.error_DP] as String?, base.String_DefaultFactory),
        _reason = base.defaultValue(
            m[Vocabulary.reason_DP] as String?, base.String_DefaultFactory),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.FailedState_CLASS, m);
  }

  static FailedState createFromJson(Map m) => FailedStateBase.fromJson(m);
  static FailedState fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.FailedState_CLASS:
        return FailedState.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.FailedState_CLASS;
  String get error => _error;

  set error(String $o) {
    if ($o == _error) return;
    var $old = _error;
    _error = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.error_DP, $old, _error));
    }
  }

  String get reason => _reason;

  set reason(String $o) {
    if ($o == _reason) return;
    var $old = _reason;
    _reason = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.reason_DP, $old, _reason));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.error_DP:
        return error;
      case Vocabulary.reason_DP:
        return reason;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.error_DP:
        error = $value as String;
        return;
      case Vocabulary.reason_DP:
        reason = $value as String;
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
  FailedState copy() => FailedState.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.FailedState_CLASS;
    if (subKind != null && subKind != Vocabulary.FailedState_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.error_DP] = error;
    m[Vocabulary.reason_DP] = reason;
    return m;
  }
}
