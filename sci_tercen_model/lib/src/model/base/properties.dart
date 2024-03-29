part of sci_model_base;

class PropertiesBase extends SciObject {
  static const List<String> PROPERTY_NAMES = [
    Vocabulary.properties_OP,
    Vocabulary.propertyValues_OP
  ];
  static const List<String> REF_PROPERTY_NAMES = [];
  static const List<base.RefId> REF_IDS = [];
  final base.ListChanged<Property> properties;
  final base.ListChanged<PropertyValue> propertyValues;

  PropertiesBase()
      : properties = base.ListChanged<Property>(),
        propertyValues = base.ListChanged<PropertyValue>() {
    properties.parent = this;
    propertyValues.parent = this;
  }

  PropertiesBase.json(Map m)
      : properties = base.ListChanged<Property>.from(
            m[Vocabulary.properties_OP] as List?, PropertyBase.createFromJson),
        propertyValues = base.ListChanged<PropertyValue>.from(
            m[Vocabulary.propertyValues_OP] as List?,
            PropertyValueBase.createFromJson),
        super.json(m) {
    subKind = base.subKindForClass(Vocabulary.Properties_CLASS, m);
    properties.parent = this;
    propertyValues.parent = this;
  }

  static Properties createFromJson(Map m) => PropertiesBase.fromJson(m);
  static Properties _createFromJson(Map? m) =>
      m == null ? Properties() : PropertiesBase.fromJson(m);
  static Properties fromJson(Map m) {
    final kind = m[Vocabulary.KIND] as String;
    switch (kind) {
      case Vocabulary.Properties_CLASS:
        return Properties.json(m);
      default:
        throw base.createBadKindError(kind);
    }
  }

  @override
  String get kind => Vocabulary.Properties_CLASS;

  @override
  dynamic get(String $name) {
    switch ($name) {
      case Vocabulary.properties_OP:
        return properties;
      case Vocabulary.propertyValues_OP:
        return propertyValues;
      default:
        return super.get($name);
    }
  }

  @override
  set(String $name, dynamic $value) {
    switch ($name) {
      case Vocabulary.properties_OP:
        properties.setValues($value as Iterable<Property>);
        return;
      case Vocabulary.propertyValues_OP:
        propertyValues.setValues($value as Iterable<PropertyValue>);
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
  Properties copy() => Properties.json(toJson());
  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.KIND] = Vocabulary.Properties_CLASS;
    if (subKind != null && subKind != Vocabulary.Properties_CLASS) {
      m[Vocabulary.SUBKIND] = subKind;
    } else {
      m.remove(Vocabulary.SUBKIND);
    }
    m[Vocabulary.properties_OP] = properties.toJson();
    m[Vocabulary.propertyValues_OP] = propertyValues.toJson();
    return m;
  }
}
