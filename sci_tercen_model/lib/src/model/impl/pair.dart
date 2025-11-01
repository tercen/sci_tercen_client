part of sci_model;

class Pair extends PairBase {
  Pair() : super();
  Pair.json(super.m) : super.json();
  Pair.from(String key, String value) {
    this.key = key;
    this.value = value;
  }
}
