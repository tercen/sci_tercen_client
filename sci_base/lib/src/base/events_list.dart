part of sci_base;

// class ListPropertyChangedEvent<T extends EventSource>
//     extends PropertyChangedEvent<T> {
//   PropertyChangedEvent sourceEvent;
//
//   ListPropertyChangedEvent.index(T source, this.sourceEvent, int index)
//       : super(source, '@$index/${sourceEvent.propertyName}',
//             sourceEvent.oldValue, sourceEvent.value);
// }

sealed class ListChangedEvent<T> extends ChangedEvent<EventSource>
    implements ObjectChangedEvent<EventSource> {
  ListChangedEvent(EventSource source) : super(source);

  @override
  String toString() => '$runtimeType($source)';

// ListModelEvent<T> toListModelEvent() {
//   return switch (this) {
//     ListClearChangedEvent<T>() => ListModelClearEvent(),
//     ListInsertChangedEvent<T>(element: var e, index: var i) =>
//       ListModelInsertEvent(i, e),
//     ListAddChangedEvent<T>(elements: var e) => ListModelAddEvent(e),
//     ListRemoveChangedEvent<T>(index: var i) => ListModelRemoveEvent(i),
//   };
// }
}

class ListClearChangedEvent<T> extends ListChangedEvent<T> {
  ListClearChangedEvent(EventSource source) : super(source);
}

class ListInsertChangedEvent<T> extends ListChangedEvent<T> {
  final T element;
  final int index;

  ListInsertChangedEvent(EventSource source, this.index, this.element)
      : super(source);

  @override
  String toString() => '$runtimeType($source, $index, $element )';
}

class ListAddChangedEvent<T> extends ListChangedEvent<T> {
  final List<T> elements;

  ListAddChangedEvent(EventSource source, this.elements) : super(source);

  @override
  String toString() => '$runtimeType($source, $elements )';
}

class ListRemoveChangedEvent<T> extends ListChangedEvent<T> {
  final int index;
  final Object? element;

  ListRemoveChangedEvent(EventSource source, this.element, this.index)
      : super(source);

  @override
  String toString() => '$runtimeType($source, $element)';
}

class ListElementChangedEvent<T extends EventSource> extends ChangedEvent<T> {
  final ChangedEvent event;

  ListElementChangedEvent(T source, this.event) : super(source);

  ChangedEvent get sourceEvent {
    var evt = event;
    while (evt is ListElementChangedEvent) {
      evt = evt.event;
    }
    return evt;
  }
}
