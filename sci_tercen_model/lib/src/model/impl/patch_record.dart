part of sci_model;

class PatchRecord extends PatchRecordBase {
  PatchRecord() : super();
  PatchRecord.json(super.m) : super.json();

  String get path => p;
  String get type => t;
  String get data => d;

  set path(String v) {
    p = v;
  }

  set type(String v) {
    t = v;
  }

  set data(String v) {
    d = v;
  }

  static const String SET_TYPE = "s";
  static const String LIST_REMOVE_TYPE = "lr";
  static const String LIST_ADD_TYPE = "la";
  static const String LIST_CLEAR_TYPE = "lc";
  static const String LIST_INSERT_TYPE = "li";

  factory PatchRecord.fromEvent(base.ObjectChangedEvent e) {
    var record = PatchRecord();

    if (e.source is base.Base) {
      var source = e.source as base.Base;

      if (e is base.PropertyChangedEvent) {
        record.type = SET_TYPE;
        record.path = source.propertyPathFromRoot(
            e.propertyName); //'${source.pathFromRoot}/${e.propertyName}';
        record.data = json.encode(e.value);
      } else if (e is base.ListChangedEvent) {
      } else if (e is base.ListElementChangedEvent) {
        throw UnimplementedError();
      } else {
        throw 'Unsupported event type';
      }
    } else if (e.source is base.ListChanged) {
      var list = e.source as base.ListChanged;
      record.path = list.pathFromRoot;

      if (e is base.ListRemoveChangedEvent) {
        record.type = LIST_REMOVE_TYPE;
        record.data = json.encode([e.index]);
      } else if (e is base.ListAddChangedEvent) {
        record.type = LIST_ADD_TYPE;
        record.data = json.encode(e.elements);
      } else if (e is base.ListClearChangedEvent) {
        record.type = LIST_CLEAR_TYPE;
      } else if (e is base.ListInsertChangedEvent) {
        record.type = LIST_INSERT_TYPE;
        record.data = json.encode([e.index, e.element]);
      } else {
        throw 'unexpected event type';
      }
    } else {
      throw Exception("Unsupported event source type");
    }

    return record;
  }

  void _initFromRecordType() {
    if (this.type.isEmpty &&
        this.data.isEmpty &&
        recordType.kind != "PatchRecordType") {
      t = recordType.legacyType;
      d = recordType.toLegacyData();
    } else if (recordType.kind == "PatchRecordType") {
      // Empty recordType, already have t and d
    }
  }

  void apply(base.Base rebuilt) {
    _initFromRecordType();

    // Parse path into segments using JsonPathParser
    var segments = JsonPathParser.parse(this.path);

    // Navigate to target, keeping parent for final operation
    dynamic target = rebuilt;
    PathSegment? lastSegment;

    for (var i = 1; i < segments.length - 1; i++) {
      target = segments[i].navigate(target);
    }

    lastSegment = segments.last;

    // Apply operation based on type
    if (type == SET_TYPE) {
      var value = json.decode(data);
      if (lastSegment is PropertySegment) {
        if (target is base.Base) {
          target.set(lastSegment.property, SciObject.decode(value));
        } else {
          throw 'SET_TYPE target must be Base object, got ${target.runtimeType}';
        }
      } else {
        throw 'SET_TYPE requires property segment as last segment';
      }
    } else if (type == LIST_REMOVE_TYPE) {
      // For list operations, target should be the list itself
      if (lastSegment is PropertySegment) {
        if (target is base.Base) {
          target = target.get(lastSegment.property);
        } else {
          throw 'LIST_REMOVE_TYPE target must be Base object to get property';
        }
      }
      // Indices should be sorted descending by PatchRecords.apply() to avoid shifting issues
      var indexes = json.decode(data) as List<dynamic>;
      var sortedIndexes = indexes.cast<int>()..sort((a, b) => b.compareTo(a));

      var targetList = target as List;
      for (var index in sortedIndexes) {
        if (index >= 0 && index < targetList.length) {
          // Get the element at the index, then remove it by value
          // This works for both regular List and ListChanged
          var element = targetList[index];
          targetList.remove(element);
        } else {
          throw 'Cannot remove index $index from list of length ${targetList.length} at path ${this.path}';
        }
      }
    } else if (type == LIST_ADD_TYPE) {
      if (lastSegment is PropertySegment) {
        if (target is base.Base) {
          target = target.get(lastSegment.property);
        } else {
          throw 'LIST_ADD_TYPE target must be Base object to get property';
        }
      }
      var list = json.decode(data) as List;
      for (var element in list) {
        (target as List).add(SciObject.decode(element));
      }
    } else if (type == LIST_CLEAR_TYPE) {
      if (lastSegment is PropertySegment) {
        if (target is base.Base) {
          target = target.get(lastSegment.property);
        } else {
          throw 'LIST_CLEAR_TYPE target must be Base object to get property';
        }
      }
      (target as List).clear();
    } else if (type == LIST_INSERT_TYPE) {
      if (lastSegment is PropertySegment) {
        if (target is base.Base) {
          target = target.get(lastSegment.property);
        } else {
          throw 'LIST_INSERT_TYPE target must be Base object to get property';
        }
      }
      var list = json.decode(data) as List;
      (target as List).insert(list[0], SciObject.decode(list[1]));
    } else {
      throw 'unsupported type';
    }
  }

  @override
  Map toJson() {
    var m = super.toJson();
    // Ensure t and d are populated from recordType if empty
    if (m[Vocabulary.t_DP] == null || (m[Vocabulary.t_DP] as String).isEmpty) {
      if (recordType.kind != "PatchRecordType") {
        m[Vocabulary.t_DP] = recordType.legacyType;
        m[Vocabulary.d_DP] = recordType.toLegacyData();
      }
    }
    return m;
  }
}
