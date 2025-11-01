import 'dart:async';
import 'dart:collection';

sealed class ListModelEvent<T> {}

class ListModelAddEvent<T> extends ListModelEvent<T> {
  final List<T> elements;
  ListModelAddEvent(this.elements);
}

class ListModelRemoveEvent<T> extends ListModelEvent<T> {
  final List<T> elements;
  ListModelRemoveEvent(this.elements);
}

class ListModelInsertEvent<T> extends ListModelEvent<T> {
  final int index;
  final T element;
  ListModelInsertEvent(this.index, this.element);
}

class ListModelClearEvent<T> extends ListModelEvent<T> {}

abstract class ListModel<T> implements List<T> {
  Stream<ListModelEvent<T>> get onListChanged;
  factory ListModel() => _ListModelImpl.from([]);
  factory ListModel.single(T? value) => _SingletonListModelImpl.single(value);
  factory ListModel.singleFrom(List<T> list) => _SingletonListModelImpl.from(list);
  factory ListModel.from(List<T> list) => _ListModelImpl.from(list);

  void removeAll(Iterable<T> iterable);
}

class _SingletonListModelImpl<T> extends _ListModelImpl<T> {
  _SingletonListModelImpl.single(T? value)
      : super.from(value != null ? [value] : []);

  _SingletonListModelImpl.from(super.list)
      : super.from();

  @override
  void add(T element) {
    super.clear();
    super.add(element);
  }

  @override
  void addAll(Iterable<T> iterable) {
    super.clear();
    if (iterable.isNotEmpty){
      super.add(iterable.first);
    }
  }

  @override
  void insert(int index, T element) {
    if (_list.contains(element)) return;
    super.clear();
    super.add(element);
  }
}

class _ListModelImpl<T> extends ListBase<T> implements ListModel<T> {
  final List<T> _list;
  final StreamController<ListModelEvent<T>> _controller;

  _ListModelImpl.from(this._list)
      : _controller = StreamController<ListModelEvent<T>>.broadcast(sync: true);

  void _sendEvent(ListModelEvent<T> event) {
    _controller.add(event);
  }

  @override
  Stream<ListModelEvent<T>> get onListChanged => _controller.stream;

  @override
  int get length => _list.length;

  @override
  set length(int i) => throw 'ListModelImpl : length not implemented';

  @override
  T operator [](int i) => _list[i];

  @override
  operator []=(int i, T? o) {
    throw 'ListModelImpl : []= not implemented';
  }

  void _basicAdd(T element) {
    _list.add(element);
  }

  @override
  void add(T element) {
    _basicAdd(element);
    _sendEvent(ListModelAddEvent([element]));
  }

  @override
  void addAll(Iterable<T> iterable) {
    var elements = <T>[...iterable];
    for (var element in iterable) {
      _basicAdd(element);
    }

    if (elements.isNotEmpty) {
      _sendEvent(ListModelAddEvent(elements));
    }
  }

  @override
  void clear() {
    if (isEmpty) return;
    _list.clear();
    _sendEvent(ListModelClearEvent());
  }

  // @override
  // bool remove(Object? element) {
  //   for (int i = 0; i < this.length; i++) {
  //     if (this[i] == element) {
  //       _list.remove(element as T);
  //       _sendEvent(ListModelRemoveEvent([element]));
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  @override
  bool remove(Object? element) {
    if (_list.remove(element)) {
      _sendEvent(ListModelRemoveEvent([element as T]));
      return true;
    }
    return false;
  }

  @override
  void removeAll(Iterable<T> iterable) {
    _sendEvent(ListModelRemoveEvent(
        iterable.where((element) => _list.remove(element)).toList()));
  }

  void _basicInsert(int index, T element) {
    _list.insert(index, element);
  }

  @override
  void insert(int index, T element) {
    if (_list.contains(element)) return;
    _basicInsert(index, element);
    _sendEvent(ListModelInsertEvent(index, element));
  }

  // void insertAt(int index, T element, bool before) {
  //   var i = before ? index : index + 1;
  //   if (i >= this.length) {
  //     this.add(element);
  //   } else {
  //     this.insert(i, element);
  //   }
  // }
}
