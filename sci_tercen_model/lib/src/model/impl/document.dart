part of '../../../sci_model.dart';

class Document extends DocumentBase {
  static const String META_IS_HIDDEN = 'hidden';

  Document() : super() {
    noEventDo(() {
      isPublic = false;
    });
  }
  Document.json(super.m) : super.json();

  bool get isHidden {
    // side effect !!
    if (getKind() == 'Project' && (name == 'apps' || name == 'templates')) {
      return false;
    }
    return getMeta(META_IS_HIDDEN, '') == 'true';
  }

  set isHidden(bool hidden) {
    addMeta(META_IS_HIDDEN, hidden.toString());
  }

  String? getMeta(String key, [String? defaultValue]) {
    var p = meta.firstWhereOrNull((pair) => pair.key == key);
    return p == null ? defaultValue : p.value;
  }

  bool hasMeta(String key) => meta.any((p) => p.key == key);
  bool hasMetaFlag(String key) => getMeta(key) == 'true';

  Pair? getMetaPair(String key) {
    return meta.firstWhereOrNull((pair) => pair.key == key);
  }

  Pair getOrCreateMetaPair(String key, [String? defaultValue]) {
    var m = getMetaPair(key);
    if (m == null) {
      addMeta(key, defaultValue ?? '');
    }
    return getMetaPair(key)!;
  }

  void removeMeta(String key) {
    var p = getMetaPair(key);
    if (p != null) meta.remove(p);
  }

  void addMeta(String key, String value) {
    removeMeta(key);
    meta.add(Pair.from(key, value));
  }

  addMetaFlag(String key, bool flag) {
    if (flag) {
      addMeta(key, 'true');
    } else {
      removeMeta(key);
    }
  }
}
