part of sci_model;

class F64Values extends F64ValuesBase {
  F64Values() : super();
  F64Values.json(super.m) : super.json();

  @override
  Map toJson() {
    var m = super.toJson();
    m[Vocabulary.values_DP] = Float64List.fromList(values.toList());
    return m;
  }
}
