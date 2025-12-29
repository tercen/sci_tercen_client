part of sci_model_base;

class CSVTaskBase extends ProjectTask {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.fileDocumentId_DP,
    Vocabulary.schemaId_DP,
    Vocabulary.valueName_DP,
    Vocabulary.variableName_DP,
    Vocabulary.gatherNames_DP,
    Vocabulary.schema_OP,
    Vocabulary.params_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [Vocabulary.fileDocumentId_DP];
  static const List<base.RefId> REF_IDS = [
    base.RefId("FileDocument", Vocabulary.fileDocumentId_DP, isComposite: true)
  ];
  String _fileDocumentId;
  String _schemaId;
  String _valueName;
  String _variableName;
  final base.ListChangedBase<String> gatherNames;
  Schema _schema;
  CSVParserParam _params;

  CSVTaskBase()
      : _fileDocumentId = "",
        _schemaId = "",
        _valueName = "",
        _variableName = "",
        gatherNames = base.ListChangedBase<String>(),
        _schema = Schema(),
        _params = CSVParserParam() {
    gatherNames.parent = this;
    _schema.parent = this;
    _params.parent = this;
  }

  CSVTaskBase.json(Map m)
      : _fileDocumentId = base.defaultValue(
            m[Vocabulary.fileDocumentId_DP] as String?,
            base.String_DefaultFactory),
        _schemaId = base.defaultValue(
            m[Vocabulary.schemaId_DP] as String?, base.String_DefaultFactory),
        _valueName = base.defaultValue(
            m[Vocabulary.valueName_DP] as String?, base.String_DefaultFactory),
        _variableName = base.defaultValue(
            m[Vocabulary.variableName_DP] as String?,
            base.String_DefaultFactory),
        gatherNames =
            base.ListChangedBase<String>(m[Vocabulary.gatherNames_DP] as List?),
        _schema = (m[Vocabulary.schema_OP] as Map?) == null
            ? Schema()
            : SchemaBase.fromJson(m[Vocabulary.schema_OP] as Map),
        _params = (m[Vocabulary.params_OP] as Map?) == null
            ? CSVParserParam()
            : CSVParserParamBase.fromJson(m[Vocabulary.params_OP] as Map),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.CSVTask_CLASS, m);
    gatherNames.parent = this;
    _schema.parent = this;
    _params.parent = this;
  }

  static CSVTask createFromJson(Map m) => CSVTaskBase.fromJson(m);
  static CSVTask fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.CSVTask_CLASS:
        return CSVTask.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.CSVTask_CLASS;
  String get fileDocumentId => _fileDocumentId;

  set fileDocumentId(String $o) {
    if ($o == _fileDocumentId) return;
    var $old = _fileDocumentId;
    _fileDocumentId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.fileDocumentId_DP, $old, _fileDocumentId));
    }
  }

  String get schemaId => _schemaId;

  set schemaId(String $o) {
    if ($o == _schemaId) return;
    var $old = _schemaId;
    _schemaId = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.schemaId_DP, $old, _schemaId));
    }
  }

  String get valueName => _valueName;

  set valueName(String $o) {
    if ($o == _valueName) return;
    var $old = _valueName;
    _valueName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.valueName_DP, $old, _valueName));
    }
  }

  String get variableName => _variableName;

  set variableName(String $o) {
    if ($o == _variableName) return;
    var $old = _variableName;
    _variableName = $o;
    if (hasListener) {
      sendChangeEvent(base.PropertyChangedEvent(
          this, Vocabulary.variableName_DP, $old, _variableName));
    }
  }

  Schema get schema => _schema;

  set schema(Schema $o) {
    if ($o == _schema) return;
    _schema.parent = null;
    $o.parent = this;
    var $old = _schema;
    _schema = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.schema_OP, $old, _schema));
    }
  }

  CSVParserParam get params => _params;

  set params(CSVParserParam $o) {
    if ($o == _params) return;
    _params.parent = null;
    $o.parent = this;
    var $old = _params;
    _params = $o;
    if (hasListener) {
      sendChangeEvent(
          base.PropertyChangedEvent(this, Vocabulary.params_OP, $old, _params));
    }
  }

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.fileDocumentId_DP:
        return fileDocumentId;
      case Vocabulary.schemaId_DP:
        return schemaId;
      case Vocabulary.valueName_DP:
        return valueName;
      case Vocabulary.variableName_DP:
        return variableName;
      case Vocabulary.gatherNames_DP:
        return gatherNames;
      case Vocabulary.schema_OP:
        return schema;
      case Vocabulary.params_OP:
        return params;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.fileDocumentId_DP:
        fileDocumentId = $value as String;
        return;
      case Vocabulary.schemaId_DP:
        schemaId = $value as String;
        return;
      case Vocabulary.valueName_DP:
        valueName = $value as String;
        return;
      case Vocabulary.variableName_DP:
        variableName = $value as String;
        return;
      case Vocabulary.gatherNames_DP:
        gatherNames.setValues($value as Iterable<String>);
        return;
      case Vocabulary.schema_OP:
        schema = $value as Schema;
        return;
      case Vocabulary.params_OP:
        params = $value as CSVParserParam;
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
  CSVTask copy() => CSVTask.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.CSVTask_CLASS;
    if (subKind != null && subKind != Vocabulary.CSVTask_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.fileDocumentId_DP] = fileDocumentId;
    m[Vocabulary.schemaId_DP] = schemaId;
    m[Vocabulary.valueName_DP] = valueName;
    m[Vocabulary.variableName_DP] = variableName;
    m[Vocabulary.gatherNames_DP] = gatherNames;
    m[Vocabulary.schema_OP] = schema.toJson();
    m[Vocabulary.params_OP] = params.toJson();
    return m;
  }
}
