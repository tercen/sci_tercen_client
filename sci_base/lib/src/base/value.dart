part of sci_base;

class ValueBase<T> extends NamedValue<T> {
  StreamSubscription? _sub;
  final Base<T> base;
  final String propertyName;

  ValueBase(this.base, this.propertyName);

  @override
  void onListen() {
    if (_sub != null) return;
    _sub = base.onChange.listen((evt) {
      if (evt is PropertyChangedEvent && evt.propertyName == propertyName) {
        sendChangeEvent();
      }
    });
  }

  @override
  void onCancel() {
    _sub!.cancel();
    _sub = null;
  }

  @override
  T get value => base.get(propertyName);

  @override
  set value(T v) {
    base.set(propertyName, v);
  }

  @override
  Future release() async {
    await _sub?.cancel();
    return super.release();
  }

  @override
  String get name => propertyName;
}
