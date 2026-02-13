/// Lazy-cached async value.
///
/// Computes the value on first access via the provided factory function,
/// then caches the result for all subsequent accesses.
///
/// This replaces R's active binding cache pattern where properties like
/// `self$schema` lazily fetch and cache on first access.
class AsyncLazy<T> {
  final Future<T> Function() _factory;
  Future<T>? _future;

  AsyncLazy(this._factory);

  /// Returns the cached value, computing it on first access.
  Future<T> get value {
    _future ??= _factory();
    return _future!;
  }

  /// Resets the cache, causing the next access to re-compute.
  void reset() {
    _future = null;
  }

  /// Whether the value has been requested (may still be in-flight).
  bool get isInitialized => _future != null;
}
