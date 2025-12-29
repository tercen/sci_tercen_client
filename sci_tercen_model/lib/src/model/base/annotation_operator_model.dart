part of sci_model_base;

class AnnotationOperatorModelBase extends OperatorModel {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.filters_OP,
    Vocabulary.annotationModels_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  Filters _filters;
  final base.ListChanged<AnnotationModel> annotationModels;

  AnnotationOperatorModelBase()
      : _filters = Filters(),
        annotationModels = base.ListChanged<AnnotationModel>() {
    _filters.parent = this;
    annotationModels.parent = this;
  }

  AnnotationOperatorModelBase.json(Map m)
      : _filters = (m[Vocabulary.filters_OP] as Map?) == null
            ? Filters()
            : FiltersBase.fromJson(m[Vocabulary.filters_OP] as Map),
        annotationModels = base.ListChanged<AnnotationModel>.from(
            m[Vocabulary.annotationModels_OP] as List?,
            AnnotationModelBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.AnnotationOperatorModel_CLASS, m);
    _filters.parent = this;
    annotationModels.parent = this;
  }

  static AnnotationOperatorModel createFromJson(Map m) =>
      AnnotationOperatorModelBase.fromJson(m);
  static AnnotationOperatorModel fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.AnnotationOperatorModel_CLASS:
        return AnnotationOperatorModel.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.AnnotationOperatorModel_CLASS;
  Filters get filters => _filters;

  set filters(Filters $o) {
    if ($o == _filters) return;
    _filters.parent = null;
    $o.parent = this;
    var $old = _filters;
    _filters = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.filters_OP, $old, _filters));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.filters_OP:
        return filters;
      case Vocabulary.annotationModels_OP:
        return annotationModels;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.filters_OP:
        filters = $value as Filters;
        return;
      case Vocabulary.annotationModels_OP:
        annotationModels.setValues($value as Iterable<AnnotationModel>);
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
  AnnotationOperatorModel copy() => AnnotationOperatorModel.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.AnnotationOperatorModel_CLASS;
    if (subKind != null &&
        subKind != Vocabulary.AnnotationOperatorModel_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.filters_OP] = filters.toJson();
    m[Vocabulary.annotationModels_OP] = annotationModels.toJson();
    return m;
  }
}
