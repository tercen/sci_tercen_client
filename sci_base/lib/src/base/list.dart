part of sci_base;

class ListChangedBase<T> extends ListBase<T> with EventSource {
  // implements ListModel<T> {
  final List<T> _list;

  ListChangedBase([List? list])
      : _list = List.from(list ?? [], growable: true).cast<T>();

  // @override
  // Stream<ListModelEvent<T>> get onListChanged => _changedController!.stream
  //     .where((event) => event is ListModelEvent<T>)
  //     .cast<ListModelEvent<T>>();

  @override
  int get length => _list.length;

  @override
  set length(int i) => throw 'ListChanged : length not implemented';

  @override
  T operator [](int i) => _list[i];

  @override
  operator []=(int i, T? o) {
    throw 'ListChanged : []= not implemented';
  }

  @override
  Iterable<T> where(bool Function(T element) test) => this._list.where(test);

  @override
  Iterable<E> map<E>(E Function(T e) f) => this._list.map(f);

  @override
  bool any(bool Function(T element) test) => this._list.any(test);

  @override
  void forEach(void Function(T element) action) => _list.forEach(action);

  @override
  List<T> toList({bool growable = true}) => _list.toList(growable: growable);

  void _basicAdd(T element) {
    _list.add(element);
  }

  String? get propertyName {
    if (_parent == null) return null;
    if (_parent is Base) {
      var baseParent = _parent as Base;
      return baseParent
          .getPropertyNames()
          .firstWhere((element) => baseParent.get(element) == this);
    }
    return null;
  }

  @override
  void add(T element) {
    _basicAdd(element);
    if (hasListener) {
      sendChangeEvent(ListAddChangedEvent(this, [element]));
    }
  }

  void setValues(Iterable<T> iterable) {
    if (this == iterable) return;
    clear();
    addAll(iterable);
  }

  @override
  void addAll(Iterable<T> iterable) {
    for (var element in iterable) {
      _basicAdd(element);
    }

    if (iterable.isNotEmpty) {
      if (hasListener) {
        sendChangeEvent(ListAddChangedEvent(this, [...iterable]));
      }
    }
  }

  @override
  void clear() {
    if (isEmpty) return;
    _list.clear();
    if (hasListener) {
      sendChangeEvent(ListClearChangedEvent(this));
    }
  }

  @override
  bool remove(Object? element) {
    for (var i = 0; i < this.length; i++) {
      if (_list[i] == element) {
        _list.remove(element as T);
        if (hasListener) {
          sendChangeEvent(ListRemoveChangedEvent(this, element, i));
        }
        return true;
      }
    }
    return false;
  }

  void _basicInsert(int index, T element) {
    _list.insert(index, element);
  }

  @override
  void insert(int index, T element) {
    _basicInsert(index, element);
    if (hasListener) {
      sendChangeEvent(ListInsertChangedEvent(this, index, element));
    }
  }

  void insertAt(int index, T element, bool before) {
    var i = before ? index : index + 1;
    if (i >= this.length) {
      add(element);
    } else {
      insert(i, element);
    }
  }

  @override
  Object toJson() {
    return List.from(_list);
  }
}
