part of sci_model_base;

class ExportTableTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.exportName_DP,
    Vocabulary.schemaIds_DP,
    Vocabulary.exportType_DP,
    Vocabulary.exportToId_DP,
    Vocabulary.exportId_DP,
    Vocabulary.namespaces_DP,
    Vocabulary.exportedSchemaIds_DP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  String _exportName;
  final base.ListChangedBase<String> schemaIds;
  String _exportType;
  String _exportToId;
  String _exportId;
  final base.ListChangedBase<String> namespaces;
  final base.ListChangedBase<String> exportedSchemaIds;

  ExportTableTaskBase()
      : _exportName = "",
        schemaIds = base.ListChangedBase<String>(),
        _exportType = "",
        _exportToId = "",
        _exportId = "",
        namespaces = base.ListChangedBase<String>(),
        exportedSchemaIds = base.ListChangedBase<String>() {
    schemaIds.parent = this;
    namespaces.parent = this;
    exportedSchemaIds.parent = this;
  }

  ExportTableTaskBase.json(Map m)
      : _exportName = base.defaultValue(
            m[Vocabulary.exportName_DP] as String?, base.String_DefaultFactory),
        schemaIds =
            base.ListChangedBase<String>(m[Vocabulary.schemaIds_DP] as List?),
        _exportType = base.defaultValue(
            m[Vocabulary.exportType_DP] as String?, base.String_DefaultFactory),
        _exportToId = base.defaultValue(
            m[Vocabulary.exportToId_DP] as String?, base.String_DefaultFactory),
        _exportId = base.defaultValue(
            m[Vocabulary.exportId_DP] as String?, base.String_DefaultFactory),
        namespaces =
            base.ListChangedBase<String>(m[Vocabulary.namespaces_DP] as List?),
        exportedSchemaIds = base.ListChangedBase<String>(
            m[Vocabulary.exportedSchemaIds_DP] as List?),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.ExportTableTask_CLASS, m);
    schemaIds.parent = this;
    namespaces.parent = this;
    exportedSchemaIds.parent = this;
  }

  static ExportTableTask createFromJson(Map m) =>
      ExportTableTaskBase.fromJson(m);
  static ExportTableTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.ExportTableTask_CLASS:
        return ExportTableTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.ExportTableTask_CLASS;
  String get exportName => _exportName;

  set exportName(String $o) {
    if ($o == _exportName) return;
    var $old = _exportName;
    _exportName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.exportName_DP, $old, _exportName));
    }
  }

  String get exportType => _exportType;

  set exportType(String $o) {
    if ($o == _exportType) return;
    var $old = _exportType;
    _exportType = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.exportType_DP, $old, _exportType));
    }
  }

  String get exportToId => _exportToId;

  set exportToId(String $o) {
    if ($o == _exportToId) return;
    var $old = _exportToId;
    _exportToId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.exportToId_DP, $old, _exportToId));
    }
  }

  String get exportId => _exportId;

  set exportId(String $o) {
    if ($o == _exportId) return;
    var $old = _exportId;
    _exportId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.exportId_DP, $old, _exportId));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.exportName_DP:
        return exportName;
      case Vocabulary.schemaIds_DP:
        return schemaIds;
      case Vocabulary.exportType_DP:
        return exportType;
      case Vocabulary.exportToId_DP:
        return exportToId;
      case Vocabulary.exportId_DP:
        return exportId;
      case Vocabulary.namespaces_DP:
        return namespaces;
      case Vocabulary.exportedSchemaIds_DP:
        return exportedSchemaIds;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.exportName_DP:
        exportName = $value as String;
        return;
      case Vocabulary.schemaIds_DP:
        schemaIds.setValues($value as Iterable<String>);
        return;
      case Vocabulary.exportType_DP:
        exportType = $value as String;
        return;
      case Vocabulary.exportToId_DP:
        exportToId = $value as String;
        return;
      case Vocabulary.exportId_DP:
        exportId = $value as String;
        return;
      case Vocabulary.namespaces_DP:
        namespaces.setValues($value as Iterable<String>);
        return;
      case Vocabulary.exportedSchemaIds_DP:
        exportedSchemaIds.setValues($value as Iterable<String>);
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
  ExportTableTask copy() => ExportTableTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.ExportTableTask_CLASS;
    if (subKind != null && subKind != Vocabulary.ExportTableTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.exportName_DP] = exportName;
    m[Vocabulary.schemaIds_DP] = schemaIds;
    m[Vocabulary.exportType_DP] = exportType;
    m[Vocabulary.exportToId_DP] = exportToId;
    m[Vocabulary.exportId_DP] = exportId;
    m[Vocabulary.namespaces_DP] = namespaces;
    m[Vocabulary.exportedSchemaIds_DP] = exportedSchemaIds;
    return m;
  }
}
