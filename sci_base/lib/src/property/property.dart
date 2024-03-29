import 'dart:async';

import 'package:sci_base/value.dart';
import 'package:sci_base/sci_base.dart' as base;

class Property extends Value<dynamic> {
  static const String TEXT_AREA_DISPLAY_TYPE = 'textarea';
  static const String TEXT_DISPLAY_TYPE = 'text';
  static const String PASSWORD_DISPLAY_TYPE = 'password';
  static const String CHECK_BOX_DISPLAY_TYPE = 'checkbox';

  static const String STRING_VALUE_TYPE = 'string';
  static const String DOUBLE_VALUE_TYPE = 'double';
  static const String BOOL_VALUE_TYPE = 'bool';

  String name;
  dynamic _value;
  String? displayName;
  String displayType;
  late bool enable;
  String valueType;
  String info;
  bool required;
  String description;

  bool _show;

  Property(this.name, this._value,
      {this.displayName,
      this.displayType = TEXT_DISPLAY_TYPE,
      this.info = '',
      this.required = false,
      this.enable = true,
      this.valueType = STRING_VALUE_TYPE,
      this.description = '',
      bool show = true})
      : _show = show {
    displayName ??= name;
  }

  bool get show => _show;
  set show(bool flag) {
    if (_show == flag) return;
    _show = flag;
    sendChangeEvent();
  }

  @override
  Stream<dynamic> get onChange {
    if (_value is Value) {
      return _value.onChange;
    }
    return super.onChange;
  }

  Stream<dynamic> get onPropertyChange {
    return super.onChange;
  }

  @override
  dynamic get value {
    if (_value is Value) {
      return (_value as Value).value;
    }

    return _value;
  }

  @override
  set value(dynamic v) {
    if (_value is Value) {
      (_value as Value).value = v;
    } else {
      if (_value != v) {
        _value = v;
        sendChangeEvent();
      }
    }
  }

  @override
  void releaseSync() {
    if (_value is Value) {
      return (_value as Value).releaseSync();
    }
    return super.releaseSync();
  }
}

class EnumerationProperty extends Property {
  List<dynamic> enumeration;
  late List<String> displayEnumeration;

  EnumerationProperty(String name, value, this.enumeration,
      {String? displayName,
      String displayType = Property.TEXT_DISPLAY_TYPE,
      List<String>? displayEnumeration,
      String info = '',
      bool required = false,
      bool enable = true,
      String description = ''})
      : super(name, value,
            displayName: displayName,
            displayType: displayType,
            info: info,
            required: required,
            enable: enable,
            description: description) {
    if (displayEnumeration == null) {
      this.displayEnumeration = enumeration as List<String>;
    } else {
      this.displayEnumeration = displayEnumeration;
    }
    assert(this.displayEnumeration.length == enumeration.length);
  }
}

class PropertyList {
  late List<Property> _properties;

  PropertyList() {
    _properties = [];
  }

  PropertyList.from(this._properties);

  void addValue(Value value, String propertyName,
      {String? label,
      String displayType = Property.TEXT_DISPLAY_TYPE,
      bool enable = true,
      List<dynamic>? enumeration,
      List<String>? displayEnumeration,
      String info = '',
      String description = '',
      bool required = false}) {
    if (enumeration != null) {
      _properties.add(EnumerationProperty(propertyName, value, enumeration,
          displayName: label,
          displayType: displayType,
          displayEnumeration: displayEnumeration,
          info: info,
          description: description,
          required: required,
          enable: enable));
    } else {
      _properties.add(Property(propertyName, value,
          displayName: label,
          displayType: displayType,
          enable: enable,
          info: info,
          description: description,
          required: required,
          valueType: getValueType(value.value)));
    }
  }

  void addObject(base.Base object, String propertyName,
      {String? label,
      String displayType = Property.TEXT_DISPLAY_TYPE,
      bool enable = true,
      List<dynamic>? enumeration,
      List<String>? displayEnumeration,
      String info = '',
      String description = '',
      bool required = false}) {
    addValue(object.getPropertyAsValue(propertyName), propertyName,
        label: label,
        displayType: displayType,
        enable: enable,
        enumeration: enumeration,
        displayEnumeration: displayEnumeration,
        info: info,
        description: description,
        required: required);
  }

  String getValueType(dynamic v) {
    if (v is Value) {
      v = v.value;
    }
    String valueType;

    if (v is String) {
      valueType = Property.STRING_VALUE_TYPE;
    } else if (v is double) {
      valueType = Property.DOUBLE_VALUE_TYPE;
    } else if (v is bool) {
      valueType = Property.BOOL_VALUE_TYPE;
    } else {
      throw 'bad value type';
    }
    return valueType;
  }

  void addProperty(
      {required String name,
      dynamic value = '',
      String label = '',
      String description = '',
      String displayType = Property.TEXT_DISPLAY_TYPE,
      bool enable = true,
      List<dynamic>? enumeration,
      List<String>? displayEnumeration}) {
    if (enumeration != null) {
      _properties.add(EnumerationProperty(name, value, enumeration,
          displayName: label,
          displayType: displayType,
          enable: enable,
          displayEnumeration: displayEnumeration!,
          description: description));
    } else {
      _properties.add(Property(name, value,
          displayName: label,
          displayType: displayType,
          enable: enable,
          valueType: getValueType(value),
          description: description));
    }
  }

  void add(String name, value,
      [String? displayName, String? displayType, bool? enable]) {
    _properties.add(Property(name, value,
        displayName: displayName,
        displayType: displayType ?? Property.TEXT_DISPLAY_TYPE,
        enable: enable ?? true));
  }

  void addEnumeration(String name, value, List enumeration,
      [String? displayName,
      String? displayType,
      List<String>? displayEnumeration,
      bool? enable]) {
    _properties.add(EnumerationProperty(name, value, enumeration,
        displayName: displayName,
        displayType: displayType ?? Property.TEXT_DISPLAY_TYPE,
        displayEnumeration: displayEnumeration));
  }

  List<Property> get properties => _properties;

  bool hasProperty(String name) => _properties.any((p) => p.name == name);

  Property getProperty(String name) =>
      _properties.firstWhere((p) => p.name == name);

  void removeProperty(String name) {
    _properties.remove(getProperty(name));
  }

  void addBasicProperty(Property p) {
    _properties.add(p);
  }
}
