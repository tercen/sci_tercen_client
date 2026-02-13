import 'package:test/test.dart';
import 'package:sci_tercen_context/sci_tercen_context.dart';
import '../mocks/mock_service_factory.dart';

void main() {
  group('getOperatorPropertyValue', () {
    final pvs = [
      makePropertyValue('threshold', '0.5'),
      makePropertyValue('count', '10'),
      makePropertyValue('enabled', 'true'),
      makePropertyValue('label', 'hello'),
    ];

    test('returns converted value when found', () {
      final result = getOperatorPropertyValue<double>(pvs,
          name: 'threshold', converter: double.parse, defaultValue: 0.0);
      expect(result, 0.5);
    });

    test('returns default when property not found', () {
      final result = getOperatorPropertyValue<String>(pvs,
          name: 'missing', converter: (s) => s, defaultValue: 'default');
      expect(result, 'default');
    });

    test('converts int correctly', () {
      final result = getOperatorPropertyValue<int>(pvs,
          name: 'count', converter: int.parse, defaultValue: 0);
      expect(result, 10);
    });

    test('converts string identity', () {
      final result = getOperatorPropertyValue<String>(pvs,
          name: 'label', converter: (s) => s, defaultValue: '');
      expect(result, 'hello');
    });

    test('converts bool correctly', () {
      final result = getOperatorPropertyValue<bool>(pvs,
          name: 'enabled',
          converter: (s) => s.toLowerCase() == 'true',
          defaultValue: false);
      expect(result, true);
    });

    test('returns default for empty value', () {
      final pvsWithEmpty = [makePropertyValue('empty', '')];
      final result = getOperatorPropertyValue<String>(pvsWithEmpty,
          name: 'empty', converter: (s) => s, defaultValue: 'fallback');
      expect(result, 'fallback');
    });
  });
}
