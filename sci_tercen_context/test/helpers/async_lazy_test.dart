import 'package:test/test.dart';
import 'package:sci_tercen_context/sci_tercen_context.dart';

void main() {
  group('AsyncLazy', () {
    test('computes value on first access', () async {
      var callCount = 0;
      final lazy = AsyncLazy(() async {
        callCount++;
        return 42;
      });

      expect(callCount, 0);
      final result = await lazy.value;
      expect(result, 42);
      expect(callCount, 1);
    });

    test('caches value on subsequent accesses', () async {
      var callCount = 0;
      final lazy = AsyncLazy(() async {
        callCount++;
        return 'hello';
      });

      await lazy.value;
      await lazy.value;
      await lazy.value;
      expect(callCount, 1);
    });

    test('isInitialized reflects state', () async {
      final lazy = AsyncLazy(() async => 1);
      expect(lazy.isInitialized, false);
      await lazy.value;
      expect(lazy.isInitialized, true);
    });

    test('reset causes re-computation', () async {
      var callCount = 0;
      final lazy = AsyncLazy(() async {
        callCount++;
        return callCount;
      });

      expect(await lazy.value, 1);
      lazy.reset();
      expect(lazy.isInitialized, false);
      expect(await lazy.value, 2);
    });
  });
}
