library sci_base;

import 'dart:async';
import "dart:collection";
import 'dart:typed_data';
import '../../value.dart';

part 'event_source.dart';
part 'events.dart';
part 'list.dart';
part 'object_list.dart';
part 'events_list.dart';
part 'value.dart';

T defaultValue<T>(T? value, T Function() factory) => value ?? factory();
double defaultDouble(num? value) => value != null ? value.toDouble() : 0.0;
String String_DefaultFactory() => '';
bool bool_DefaultFactory() => true;
int int_DefaultFactory() => 0;
dynamic dynamic_DefaultFactory() => null;
Uint8List Uint8List_DefaultFactory() => Uint8List(0);
// int defaultInt(int? value) => value ?? 0;
// bool defaultBool(bool? value) => value ?? true;

String? subKindForClass(String clazz, Map m) {
  var subKind = m["subKind"] as String?;
  if (subKind != null) {
    return subKind;
  }

  var kind = m["kind"];

  if (kind != clazz) {
    return kind;
  }

  return null;
}

ArgumentError createBadKindError(String kind) =>
    ArgumentError.value(kind, "bad kind error");

class RefId {
  final String kind;
  final bool isComposite;
  final String name;
  const RefId(this.kind, this.name, {this.isComposite = false});
}

abstract class Base<T> extends EventSource implements ObjectProperties<T> {
  String? subKind;

  Base();

  Base.json(Map m);

  String get kind;

  String? get propertyName {
    if (_parent == null) return null;
    dynamic baseParent = _parent;
    if (baseParent is Base) {
      return baseParent
          .getPropertyNames()
          .firstWhere((element) => baseParent.get(element) == this);
    } else if (baseParent is List) {
      return '[${baseParent.indexOf(this)}]';
    }
    return null;
  }

  String propertyPathFromRoot(String propertyName) =>
      buildJsonPath(collectPathToRoot([propertyName]));

  List<String> collectPathToRoot(List<String> path) {
    dynamic base = this;
    while (base != null && base.parent != null) {
      String? propertyName;
      if (base is Base) {
        propertyName = base.propertyName;
      } else if (base is ListChanged) {
        propertyName = base.propertyName;
      } else {
        throw "failed to compute pathFromRoot";
      }
      if (propertyName != null) {
        path.add(propertyName);
      } else {
        throw "failed to compute pathFromRoot -- propertyName is null";
      }
      base = base.parent;
    }
    path.add('');
    return path;
  }

  String buildJsonPath(List<String> segments) {
    if (segments.isEmpty) return r'$';

    var buffer = StringBuffer(r'$');
    for (var segment in segments.reversed) {
      if (segment.isEmpty) continue;

      if (segment.startsWith('[')) {
        // Array index: [0], [1], etc.
        buffer.write(segment);
      } else {
        // Property name
        buffer.write('.');
        buffer.write(segment);
      }
    }
    return buffer.toString();
  }

  String get pathFromRoot {
    return buildJsonPath(collectPathToRoot([]));
  }

  Iterable<String> getPropertyNames() => [];

  Iterable<String> getRefPropertyNames(
      {bool compositeOnly = false, bool sharedOnly = false}) {
    if (sharedOnly) {
      return refIds()
          .where((element) => !element.isComposite)
          .map((e) => e.name);
    }
    return compositeOnly
        ? refIds().where((element) => element.isComposite).map((e) => e.name)
        : refIds().map((e) => e.name);
  }

  Iterable<RefId> refIds() => [];

  void changeRefIds(Map<String, String> newIds) {
    for (var name in getRefPropertyNames()) {
      dynamic object = get(name);
      if (object == null) continue;

      if (object is String) {
        if (newIds.containsKey(object)) {
          set(name, newIds[object] as T);
        }
      } else if (object is List<String>) {
        if (object.any((element) => newIds.containsKey(element))) {
          var newList = object.map((e) {
            if (newIds.containsKey(e)) {
              return newIds[e]!;
            } else {
              return e;
            }
          }).toList();

          object
            ..clear()
            ..addAll(newList);
        }
      } else if (object is Base) {
        object.changeRefIds(newIds);
      } else if (object is List) {
        for (var element in object) {
          if (element is Base) {
            element.changeRefIds(newIds);
          }
        }
      } else {
        throw 'bad ref property type';
      }
    }

    var names = List.from(getPropertyNames());
    getRefPropertyNames().forEach(names.remove);

    for (var name in names) {
      dynamic object = get(name);
      if (object is Base) {
        object.changeRefIds(newIds);
      } else if (object is List) {
        for (var element in object) {
          if (element is Base) {
            element.changeRefIds(newIds);
          }
        }
      }
    }
  }

  void checkRefIds() {
    var allIds = <String>{};
    addRefIds(allIds, compositeOnly: false, sharedOnly: false);
    allIds = allIds.where((element) => element.isNotEmpty).toSet();

    var compositeOnlyIds = <String>{};
    addRefIds(compositeOnlyIds, compositeOnly: true, sharedOnly: false);
    compositeOnlyIds =
        compositeOnlyIds.where((element) => element.isNotEmpty).toSet();

    var sharedOnlyIds = <String>{};
    addRefIds(sharedOnlyIds, compositeOnly: false, sharedOnly: true);
    sharedOnlyIds =
        sharedOnlyIds.where((element) => element.isNotEmpty).toSet();

    if (compositeOnlyIds.intersection(sharedOnlyIds).isNotEmpty) {
      // print(compositeOnly_ids.intersection(sharedOnly_ids).toList().toString());
      assert(compositeOnlyIds.intersection(sharedOnlyIds).isEmpty);
    }

    allIds
      ..removeAll(compositeOnlyIds)
      ..removeAll(sharedOnlyIds);

    if (allIds.isNotEmpty) {
      // print(all_ids.toList().toString());
      assert(allIds.isEmpty);
    }
  }

  Set<String> getRefIds2(
      {bool compositeOnly = false, bool sharedOnly = false}) {
    if (compositeOnly && sharedOnly) {
      throw 'getRefIds2 bad params -- compositeOnly && sharedOnly';
    }

    var ids = <String>{};
    addRefIds(ids, compositeOnly: compositeOnly, sharedOnly: sharedOnly);

    var resultLegacy = ids.where((element) => element.isNotEmpty).toSet();

    // var refIdsList = <String>[];
    //
    // collectRefIds(refIdsList,
    //     compositeOnly: compositeOnly, sharedOnly: sharedOnly);
    //
    // var refIds = HashSet<String>.from(refIdsList);
    // for (var id in refIds) {
    //   if (!resultLegacy.contains(id)) {
    //     throw '$this -- $id no in legacy';
    //   }
    // }

    return resultLegacy;
  }

  // void collectRefIds(List<String> refIds,
  //     {bool compositeOnly = false, bool sharedOnly = false}) {}

  void addRefIds(Set<String> refIds,
      {bool compositeOnly = false, bool sharedOnly = false}) {
    for (var name in getRefPropertyNames(
        compositeOnly: compositeOnly, sharedOnly: sharedOnly)) {
      dynamic object = get(name);

      if (object == null) continue;

      if (object is String) {
        if (object.isNotEmpty) refIds.add(object);
      } else if (object is List<String>) {
        for (var element in object) {
          if (element.isNotEmpty) {
            refIds.add(element);
          } else {
            throw 'bad ref id';
          }
        }
      } else if (object is Base) {
        object.addRefIds(refIds,
            compositeOnly: compositeOnly, sharedOnly: sharedOnly);
      } else if (object is List) {
        for (var element in object) {
          if (element is Base) {
            element.addRefIds(refIds,
                compositeOnly: compositeOnly, sharedOnly: sharedOnly);
          }
        }
      } else {
        throw 'bad ref property type';
      }
    }

    var refNames = getRefPropertyNames(compositeOnly: false, sharedOnly: false);

    var names =
        getPropertyNames().where((element) => !refNames.contains(element));

    for (var name in names) {
      dynamic object = get(name);
      if (object is Base) {
        object.addRefIds(refIds,
            compositeOnly: compositeOnly, sharedOnly: sharedOnly);
      } else if (object is List) {
        for (var element in object) {
          if (element is Base) {
            element.addRefIds(refIds,
                compositeOnly: compositeOnly, sharedOnly: sharedOnly);
          }
        }
      }
    }
  }

  @override
  T get(String name) => throw ArgumentError.value(name);

  @override
  void set(String name, T value) => throw ArgumentError.value(name);

  @override
  NamedValue<T> getPropertyAsValue(String name) => ValueBase(this, name);

  String getKind() {
    if (subKind != null) return subKind!;
    return kind;
  }

  void copyTo(Base object) {
    if (object == this) {
      return;
    }

    for (var name in getPropertyNames()) {
      var prop = get(name);
      object.set(name, prop);
    }
  }

  void copyFrom(Base object) {
    if (object == this) {
      return;
    }

    for (var name in getPropertyNames()) {
      set(name, object.get(name));
    }
  }
}

abstract class PersistentBase {
  late String id;
  late String rev;
  late bool isDeleted;

  dynamic toJson();

  Set<String> getRefIds2();
}
