part of sci_model;

class PersistentObject extends PersistentObjectBase {
  PersistentObject() : super() {
    noEventDo(() {
      isDeleted = false;
    });
  }
  PersistentObject.json(Map m) : super.json(m);
}
