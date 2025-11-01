part of sci_base;

class ListChanged<T extends EventSource> extends ListBase<T> with EventSource {
  // implements ListModel<T>
  late List<T> _list;

  ListChanged.from(List? list, T Function(Map<dynamic, dynamic>) factory) {
    if (list != null) {
      _list = list.map((e) => factory(e)..parent = this).toList();
    } else {
      _list = [];
    }
  }

  ListChanged([List<T>? list]) {
    _list = List.from(list ?? [], growable: true);
    for (var each in _list) {
      each.parent = this;
    }
  }

  // @override
  // Stream<ListModelEvent<T>> get onListChanged => _changedController!.stream
  //     .where((event) => event is ListChangedEvent<T>)
  //     .cast<ListChangedEvent<T>>()
  //     .map((event) => event.toListModelEvent())
  //     .cast<ListModelEvent<T>>();

  dynamic get(String index) {
    if (index.startsWith('@')) {
      var i = int.parse(index.substring(1));
      return _list[i];
    } else {
      throw 'ListChanged : bad index string format';
    }
  }

  String get pathFromRoot {
    var propertyName = this.propertyName;
    if (propertyName == null) {
      throw 'pathFromRoot -- failed -- propertyName is null';
    }
    if (_parent is Base) {
      return (_parent as Base).propertyPathFromRoot(propertyName);
    } else {
      throw 'pathFromRoot -- failed -- _parent is! Base';
    }
  }

  @override
  T get first => _list.first;

  @override
  int get length => _list.length;

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  set length(int i) => throw 'ListChanged : length not implemented';

  @override
  T operator [](int i) => _list[i];

  @override
  operator []=(int i, T? o) {
    throw 'ListChanged : []= not implemented';
  }

  @override
  Iterable<T> where(bool Function(T element) test) => _list.where(test);

//  Iterable/*<E>*/ map/*<E>*/(/*=E*/ f(T element)) => this._list.map(f);
  @override
  Iterable<E> map<E>(E Function(T e) f) => _list.map(f);

  @override
  bool any(bool Function(T element) test) => _list.any(test);

  @override
  void forEach(void Function(T element) action) => _list.forEach(action);

  @override
  List<T> toList({bool growable = true}) => _list.toList(growable: growable);

  void _basicAdd(T element) {
    _list.add(element);
    element.parent = this;
  }

  @override
  void add(T element) {
    if (_list.contains(element)) return;
    _basicAdd(element);
    if (hasListener) {
      sendChangeEvent(ListAddChangedEvent(this, [element]));
    }
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
    for (var each in _list) {
      each.parent = null;
    }
    _list.clear();
    if (hasListener) sendChangeEvent(ListClearChangedEvent(this));
  }

  @override
  bool remove(Object? element) {
    for (var i = 0; i < length; i++) {
      if (_list[i] == element) {
        (element as T).parent = null;
        _list.remove(element);
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
    element.parent = this;
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
    if (i >= length) {
      add(element);
    } else {
      insert(i, element);
    }
  }

  @override
  Object toJson() => _list.map((e) => e.toJson()).toList();
}
