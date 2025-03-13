part of sci_model;

class SciObject extends SciObjectBase {
  static dynamic decode(dynamic m) {
    if (m is Map && m.containsKey("kind")) {
      return SciObjectBase.fromJson(m);
    } else if (m is List) {
      return m.map((e) => SciObject.decode(e)).toList();
    }
    return m;
  }

  SciObject() : super();
  SciObject.json(Map m) : super.json(m);
}
