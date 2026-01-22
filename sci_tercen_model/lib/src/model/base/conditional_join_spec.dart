part of sci_model_base;

class ConditionalJoinSpecBase extends OperatorOutputSpec {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.description_DP,
    Vocabulary.alternatives_OP,
    Vocabulary.refactorSuggestion_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _description;
  final base.ListChanged<OutputAlternative> alternatives;
  String _refactorSuggestion;

  ConditionalJoinSpecBase()
      : _description = "",
        _refactorSuggestion = "",
        alternatives = base.ListChanged<OutputAlternative>() {
    alternatives.parent = this;
  }

  ConditionalJoinSpecBase.json(Map m)
      : _description = base.defaultValue(
            m[Vocabulary.description_DP] as String?,
            base.String_DefaultFactory),
        _refactorSuggestion = base.defaultValue(
            m[Vocabulary.refactorSuggestion_DP] as String?,
            base.String_DefaultFactory),
        alternatives = base.ListChanged<OutputAlternative>.from(
            m[Vocabulary.alternatives_OP] as List?,
            OutputAlternativeBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ConditionalJoinSpec_CLASS, m);
    alternatives.parent = this;
  }

  static ConditionalJoinSpec createFromJson(Map m) =>
      ConditionalJoinSpecBase.fromJson(m);
  static ConditionalJoinSpec fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ConditionalJoinSpec_CLASS:
        return ConditionalJoinSpec.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ConditionalJoinSpec_CLASS;
  String get description => _description;

  set description(String $o) {
    if ($o == _description) return;
    var $old = _description;
    _description = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.description_DP, $old, _description));
    }
  }

  String get refactorSuggestion => _refactorSuggestion;

  set refactorSuggestion(String $o) {
    if ($o == _refactorSuggestion) return;
    var $old = _refactorSuggestion;
    _refactorSuggestion = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.refactorSuggestion_DP, $old, _refactorSuggestion));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.description_DP:
        return description;
      case Vocabulary.alternatives_OP:
        return alternatives;
      case Vocabulary.refactorSuggestion_DP:
        return refactorSuggestion;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.description_DP:
        description = $value as String;
        return;
      case Vocabulary.refactorSuggestion_DP:
        refactorSuggestion = $value as String;
        return;
      case Vocabulary.alternatives_OP:
        alternatives.setValues($value as Iterable<OutputAlternative>);
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
  ConditionalJoinSpec copy() => ConditionalJoinSpec.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ConditionalJoinSpec_CLASS;
    if (subKind != null && subKind != Vocabulary.ConditionalJoinSpec_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.description_DP] = description;
    m[Vocabulary.alternatives_OP] = alternatives.toJson();
    m[Vocabulary.refactorSuggestion_DP] = refactorSuggestion;
    return m;
  }
}
