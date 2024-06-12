part of sci_model;

class Pair extends PairBase {
  Pair() : super();
  Pair.json(Map m) : super.json(m);
  Pair.from(String key, String value){
    this.key = key;
    this.value = value;
  }
}
