part of sci_model_base;

class StartProcessBase extends IdObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.executable_DP,
    Vocabulary.arguments_DP,
    Vocabulary.ulimits_OP,
    Vocabulary.timeout_DP,
    Vocabulary.pid_DP,
    Vocabulary.script_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _executable;
  final base.ListChangedBase<String> arguments;
  Ulimits _ulimits;
  int _timeout;
  int _pid;
  String _script;

  StartProcessBase()
      : _executable = "",
        arguments = base.ListChangedBase<String>(),
        _timeout = 0,
        _pid = 0,
        _script = "",
        _ulimits = Ulimits() {
    arguments.parent = this;
    _ulimits.parent = this;
  }

  StartProcessBase.json(Map m)
      : _executable = base.defaultValue(
            m[Vocabulary.executable_DP] as String?, base.String_DefaultFactory),
        arguments =
            base.ListChangedBase<String>(m[Vocabulary.arguments_DP] as List?),
        _timeout = base.defaultValue(
            m[Vocabulary.timeout_DP] as int?, base.int_DefaultFactory),
        _pid = base.defaultValue(
            m[Vocabulary.pid_DP] as int?, base.int_DefaultFactory),
        _script = base.defaultValue(
            m[Vocabulary.script_DP] as String?, base.String_DefaultFactory),
        _ulimits =
            UlimitsBase._createFromJson(m[Vocabulary.ulimits_OP] as Map?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.StartProcess_CLASS, m);
    arguments.parent = this;
    _ulimits.parent = this;
  }

  static StartProcess createFromJson(Map m) => StartProcessBase.fromJson(m);
  static StartProcess _createFromJson(Map? m) =>
      m == null ? StartProcess() : StartProcessBase.fromJson(m);
  static StartProcess fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.StartProcess_CLASS:
        return StartProcess.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.StartProcess_CLASS;
  String get executable => _executable;

  set executable(String $o) {
    if ($o == _executable) return;
    var $old = _executable;
    _executable = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.executable_DP, $old, _executable));
    }
  }

  int get timeout => _timeout;

  set timeout(int $o) {
    if ($o == _timeout) return;
    var $old = _timeout;
    _timeout = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.timeout_DP, $old, _timeout));
    }
  }

  int get pid => _pid;

  set pid(int $o) {
    if ($o == _pid) return;
    var $old = _pid;
    _pid = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.pid_DP, $old, _pid));
    }
  }

  String get script => _script;

  set script(String $o) {
    if ($o == _script) return;
    var $old = _script;
    _script = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.script_DP, $old, _script));
    }
  }

  Ulimits get ulimits => _ulimits;

  set ulimits(Ulimits $o) {
    if ($o == _ulimits) return;
    _ulimits.parent = null;
    $o.parent = this;
    var $old = _ulimits;
    _ulimits = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.ulimits_OP, $old, _ulimits));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.executable_DP:
        return executable;
      case Vocabulary.arguments_DP:
        return arguments;
      case Vocabulary.ulimits_OP:
        return ulimits;
      case Vocabulary.timeout_DP:
        return timeout;
      case Vocabulary.pid_DP:
        return pid;
      case Vocabulary.script_DP:
        return script;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.executable_DP:
        executable = $value as String;
        return;
      case Vocabulary.arguments_DP:
        arguments.setValues($value as Iterable<String>);
        return;
      case Vocabulary.timeout_DP:
        timeout = $value as int;
        return;
      case Vocabulary.pid_DP:
        pid = $value as int;
        return;
      case Vocabulary.script_DP:
        script = $value as String;
        return;
      case Vocabulary.ulimits_OP:
        ulimits = $value as Ulimits;
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
  StartProcess copy() => StartProcess.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.StartProcess_CLASS;
    if (subKind != null && subKind != Vocabulary.StartProcess_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.executable_DP] = executable;
    m[Vocabulary.arguments_DP] = arguments;
    m[Vocabulary.ulimits_OP] = ulimits.toJson();
    m[Vocabulary.timeout_DP] = timeout;
    m[Vocabulary.pid_DP] = pid;
    m[Vocabulary.script_DP] = script;
    return m;
  }
}
