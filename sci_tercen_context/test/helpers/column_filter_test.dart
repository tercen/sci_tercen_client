import 'package:test/test.dart';
import 'package:sci_tercen_context/sci_tercen_context.dart';
import '../mocks/mock_service_factory.dart';

void main() {
  group('filterSelectableColumnNames', () {
    test('filters out int64 columns', () {
      final columns = [
        makeColumnSchema('.y', 'double'),
        makeColumnSchema('.ri', 'int64'),
        makeColumnSchema('name', 'string'),
      ];
      expect(filterSelectableColumnNames(columns), ['.y', 'name']);
    });

    test('filters out uint64 columns', () {
      final columns = [
        makeColumnSchema('.y', 'double'),
        makeColumnSchema('.ci', 'uint64'),
        makeColumnSchema('value', 'double'),
      ];
      expect(filterSelectableColumnNames(columns), ['.y', 'value']);
    });

    test('keeps double, string, int32 columns', () {
      final columns = [
        makeColumnSchema('a', 'double'),
        makeColumnSchema('b', 'string'),
        makeColumnSchema('c', 'int32'),
      ];
      expect(filterSelectableColumnNames(columns), ['a', 'b', 'c']);
    });

    test('returns empty for empty input', () {
      expect(filterSelectableColumnNames([]), isEmpty);
    });

    test('returns empty when all columns are system types', () {
      final columns = [
        makeColumnSchema('.ri', 'int64'),
        makeColumnSchema('.ci', 'uint64'),
      ];
      expect(filterSelectableColumnNames(columns), isEmpty);
    });
  });
}
