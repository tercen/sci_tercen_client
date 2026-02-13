part of sci_model;

class I32Values extends I32ValuesBase {
  I32Values() : super();
  I32Values.json(super.m) : super.json();

  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.values_DP] = Int32List.fromList(values.toList());
    return m;
  }
}
