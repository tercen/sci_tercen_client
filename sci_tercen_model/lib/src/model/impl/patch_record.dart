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

  void apply(base.Base rebuilt) {
    var path = this.path.split('/');
    dynamic target = rebuilt;

    for (var i = 1; i < path.length - 1; i++) {
      target = target.get(path[i]);
    }

    if (type == SET_TYPE) {
      var value = json.decode(data);
      target.set(path[path.length - 1], SciObject.decode(value));
    } else if (type == LIST_REMOVE_TYPE) {
      target = target.get(path.last);
      var indexes = json.decode(data) as List;
      for (var index in indexes) {
        (target as List).remove((target)[index]);
      }
    } else if (type == LIST_ADD_TYPE) {
      target = target.get(path.last);
      var list = json.decode(data) as List;
      for (var element in list) {
        (target as List).add(SciObject.decode(element));
      }
    } else if (type == LIST_CLEAR_TYPE) {
      target = target.get(path.last);
      (target as List).clear();
    } else if (type == LIST_INSERT_TYPE) {
      target = target.get(path.last);
      var list = json.decode(data) as List;
      (target as List).insert(list[0], SciObject.decode(list[1]));
    } else {
      throw 'unsupported type';
    }
  }
}
