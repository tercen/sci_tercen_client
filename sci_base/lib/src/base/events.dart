part of sci_base;

class ChangedEvent<T extends EventSource> {
  final T source;
  ChangedEvent(this.source);
}

class UpdateEvent<T extends EventSource> extends ChangedEvent<T> {
  final Future updating;
  UpdateEvent(super.source, this.updating);
}

abstract class ObjectChangedEvent<S extends EventSource>
    extends ChangedEvent<S> {
  ObjectChangedEvent(super.source);
}

class PropertyChangedEvent<S extends EventSource, T> extends ChangedEvent<S>
    implements ObjectChangedEvent<S> {
  final String propertyName;
  final T oldValue;
  final T value;

  PropertyChangedEvent(
      super.source, this.propertyName, this.oldValue, this.value);

  @override
  String toString() => '$runtimeType($source,$propertyName, $oldValue, $value)';
}
