import 'dart:async';

typedef GetValueHolderCallback<T> = T Function();
typedef SetValueHolderCallback<T> = void Function(T value);

abstract class ObjectProperties<T> {
  T get(String name);
  set(String name, T value);

  Value<T> getPropertyAsValue(String name);
}

abstract class Value<T> {
  late StreamController<T> _controller;
  Value() {
    _controller = StreamController<T>.broadcast(
        onListen: onListen, onCancel: onCancel, sync: true);
  }

  T get value;
  set value(T v);
  Stream<T> get onChange => _controller.stream;
  void onListen() {}
  void onCancel() {}
  void sendChangeEvent() => _controller.add(value);

  void releaseSync() {}
  Future release() async {
    releaseSync();
  }

  Value<S> convert<S>(
          {ValueConverterGet<S, T>? get, ValueConverterSet<S, T>? set}) =>
      ValueConverter(this, get: get, set: set);

  Value<T> asReadOnly() => ValueConverter(this,
      get: (value) => value, set: (value) => throw 'Value is read only.');

  Value<T> periodic(Duration every) => ValueTimeUpdater(this, every);

  Value<S> cast<S>() => CastValueConverter<S, T>(this);

  Value<List<S>> asListModel<S>() => ListValue(this.cast<List<S>>());
}

class ListValue<T> extends Value<List<T>> {
  StreamSubscription? _sub;
  final Value<List<T>> _value;

  ListValue(this._value) {
    _sub = _value.onChange.listen((_) => sendChangeEvent());
  }

  @override
  List<T> get value => _value.value;
  @override
  set value(List<T> v) {
    _value.value.clear();
    _value.value.addAll(v);
  }

  @override
  Future release() async {
    _sub?.cancel();
    await super.release();
  }
}

abstract class NamedValue<T> extends Value<T> {
  String get name;
}

typedef ValueConverterGet<T, S> = T Function(S v);
typedef ValueConverterSet<T, S> = S Function(T v);

class CastValueConverter<T, S> extends Value<T> {
  StreamSubscription? _sub;
  final Value<S> _value;

  CastValueConverter(this._value) {
    _sub = _value.onChange.listen((_) => sendChangeEvent());
  }

  @override
  T get value => _value.value as T;
  @override
  set value(T v) {
    _value.value = v as S;
  }

  @override
  Future release() async {
    _sub?.cancel();
    await super.release();
  }
}

class ValueConverter<T, S> extends Value<T> {
  StreamSubscription? _sub;
  final Value<S> _value;
  ValueConverterGet<T, S>? get;
  ValueConverterSet<T, S>? set;

  ValueConverter(this._value, {this.get, this.set}) {
    _sub = _value.onChange.listen((_) => sendChangeEvent());
  }

  @override
  T get value => get!(_value.value);
  @override
  set value(T v) {
    _value.value = set!(v);
  }

  @override
  Future release() async {
    _sub?.cancel();
    await super.release();
  }
}

class ValueTimeUpdater<T> extends Value<T> {
  StreamSubscription? _sub;
  final Value<T> _value;

  ValueTimeUpdater(this._value, Duration every) {
    _sub = _value.onChange.listen((_) {
      sendChangeEvent();
    });
    Timer.periodic(every, (t) {
      if (_sub == null) {
        t.cancel();
      } else {
        sendChangeEvent();
      }
    });
  }

  @override
  T get value => _value.value;
  @override
  set value(T v) {
    _value.value = v;
  }

  @override
  Future release() async {
    _sub?.cancel();
    _sub = null;
    await super.release();
  }
}

class ValueHolder<T> extends Value<T> {
  T _value;
  @override
  ValueHolder(this._value);
  @override
  T get value => _value;
  @override
  set value(T v) {
    if (v == _value) return;
    _value = v;
    sendChangeEvent();
  }
}

class ValueCallback<T> extends Value<T> {
  final GetValueHolderCallback<T> getCallback;
  final SetValueHolderCallback<T> setCallback;

  ValueCallback(this.getCallback, this.setCallback);

  @override
  T get value => getCallback();
  @override
  set value(T v) {
    setCallback(v);
  }
}
