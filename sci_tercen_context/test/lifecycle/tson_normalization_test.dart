import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:tson/string_list.dart';
import 'package:sci_tercen_context/sci_tercen_context.dart';
import '../mocks/mock_service_factory.dart';

void main() {
  late MockServiceFactory mockFactory;
  late CubeQuery testQuery;

  setUp(() {
    mockFactory = MockServiceFactory();

    testQuery = makeCubeQuery();
    mockFactory.tableSchemaService
        .addSchema('qt-hash', makeSchema('qt-hash', []));
    mockFactory.tableSchemaService
        .addSchema('col-hash', makeSchema('col-hash', []));
    mockFactory.tableSchemaService
        .addSchema('row-hash', makeSchema('row-hash', []));
  });

  group('TSON normalization (uploadResultFile)', () {
    test('normalizes I32Values columns to Int32List', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      // Build a table using only cValues (the broken path before normalization)
      final table = Table();
      table.nRows = 3;
      final col = Column();
      col.name = '.ci';
      final vals = I32Values();
      vals.values.addAll([0, 1, 2]);
      col.cValues = vals;
      table.columns.add(col);

      await ctx.saveTable(table);

      // After save, the column should have values set as Int32List
      expect(col.values, isA<Int32List>());
      expect((col.values as Int32List).toList(), equals([0, 1, 2]));
    });

    test('normalizes F64Values columns to Float64List', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      table.nRows = 3;
      final col = Column();
      col.name = 'value';
      final vals = F64Values();
      vals.values.addAll([1.1, 2.2, 3.3]);
      col.cValues = vals;
      table.columns.add(col);

      await ctx.saveTable(table);

      expect(col.values, isA<Float64List>());
      expect((col.values as Float64List).toList(), equals([1.1, 2.2, 3.3]));
    });

    test('normalizes StrValues columns to CStringList', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      table.nRows = 2;
      final col = Column();
      col.name = 'label';
      final vals = StrValues();
      vals.values.addAll(['hello', 'world']);
      col.cValues = vals;
      table.columns.add(col);

      await ctx.saveTable(table);

      expect(col.values, isA<CStringList>());
      expect((col.values as CStringList).toList(), equals(['hello', 'world']));
    });

    test('normalizes mixed column types in same table', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      table.nRows = 2;

      final intCol = Column();
      intCol.name = '.ci';
      final iv = I32Values();
      iv.values.addAll([0, 1]);
      intCol.cValues = iv;
      table.columns.add(intCol);

      final dblCol = Column();
      dblCol.name = 'mean';
      final fv = F64Values();
      fv.values.addAll([3.14, 2.71]);
      dblCol.cValues = fv;
      table.columns.add(dblCol);

      final strCol = Column();
      strCol.name = 'name';
      final sv = StrValues();
      sv.values.addAll(['a', 'b']);
      strCol.cValues = sv;
      table.columns.add(strCol);

      await ctx.saveTable(table);

      expect(intCol.values, isA<Int32List>());
      expect(dblCol.values, isA<Float64List>());
      expect(strCol.values, isA<CStringList>());
    });

    test('normalizes columns across multiple tables in result', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table1 = Table();
      table1.nRows = 1;
      final col1 = Column();
      col1.name = '.ci';
      final iv = I32Values();
      iv.values.addAll([42]);
      col1.cValues = iv;
      table1.columns.add(col1);

      final table2 = Table();
      table2.nRows = 1;
      final col2 = Column();
      col2.name = 'score';
      final fv = F64Values();
      fv.values.addAll([99.9]);
      col2.cValues = fv;
      table2.columns.add(col2);

      await ctx.saveTables([table1, table2]);

      expect(col1.values, isA<Int32List>());
      expect(col2.values, isA<Float64List>());
    });

    test('leaves columns with CValues base class untouched', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      // Column with default CValues (no typed subclass)
      final table = Table();
      final col = Column();
      col.name = 'empty';
      table.columns.add(col);

      await ctx.saveTable(table);

      // values should remain whatever the default is (null)
      expect(col.values, isNull);
    });
  });

  group('Column type and nRows auto-inference', () {
    test('infers type from I32Values', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      final col = Column();
      col.name = '.ci';
      final vals = I32Values();
      vals.values.addAll([0, 1, 2]);
      col.cValues = vals;
      table.columns.add(col);

      await ctx.saveTable(table);

      expect(col.type, 'int32');
      expect(col.nRows, 3);
      expect(table.nRows, 3);
    });

    test('infers type from F64Values', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      final col = Column();
      col.name = 'mean';
      final vals = F64Values();
      vals.values.addAll([1.5, 2.5]);
      col.cValues = vals;
      table.columns.add(col);

      await ctx.saveTable(table);

      expect(col.type, 'double');
      expect(col.nRows, 2);
      expect(table.nRows, 2);
    });

    test('infers type from StrValues', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      final col = Column();
      col.name = 'label';
      final vals = StrValues();
      vals.values.addAll(['a', 'b', 'c']);
      col.cValues = vals;
      table.columns.add(col);

      await ctx.saveTable(table);

      expect(col.type, 'string');
      expect(col.nRows, 3);
      expect(table.nRows, 3);
    });

    test('does not overwrite explicitly set type', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      final col = Column();
      col.name = '.ci';
      col.type = 'custom_int'; // explicitly set
      col.nRows = 999; // explicitly set
      final vals = I32Values();
      vals.values.addAll([0, 1]);
      col.cValues = vals;
      table.columns.add(col);

      await ctx.saveTable(table);

      // Should not overwrite user-provided values
      expect(col.type, 'custom_int');
      expect(col.nRows, 999);
    });

    test('sets table.nRows from first column when table.nRows is 0', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      // table.nRows deliberately not set (defaults to 0)
      final col = Column();
      col.name = '.ci';
      final vals = I32Values();
      vals.values.addAll([10, 20, 30, 40]);
      col.cValues = vals;
      table.columns.add(col);

      await ctx.saveTable(table);

      expect(table.nRows, 4);
    });

    test('does not overwrite explicitly set table.nRows', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      table.nRows = 50; // explicitly set
      final col = Column();
      col.name = '.ci';
      final vals = I32Values();
      vals.values.addAll([0, 1]);
      col.cValues = vals;
      table.columns.add(col);

      await ctx.saveTable(table);

      // Should not overwrite
      expect(table.nRows, 50);
    });
  });

  group('Table-building helpers', () {
    test('makeInt32Column creates correctly wired column', () {
      final col = AbstractOperatorContext.makeInt32Column('.ci', [0, 1, 2]);

      expect(col.name, '.ci');
      expect(col.type, 'int32');
      expect(col.nRows, 3);
      expect(col.values, isA<Int32List>());
      expect((col.values as Int32List).toList(), equals([0, 1, 2]));
      expect(col.cValues, isA<I32Values>());
      expect((col.cValues as I32Values).values.toList(), equals([0, 1, 2]));
    });

    test('makeFloat64Column creates correctly wired column', () {
      final col = AbstractOperatorContext.makeFloat64Column('mean', [1.5, 2.5]);

      expect(col.name, 'mean');
      expect(col.type, 'double');
      expect(col.nRows, 2);
      expect(col.values, isA<Float64List>());
      expect((col.values as Float64List).toList(), equals([1.5, 2.5]));
      expect(col.cValues, isA<F64Values>());
      expect((col.cValues as F64Values).values.toList(), equals([1.5, 2.5]));
    });

    test('makeStringColumn creates correctly wired column', () {
      final col = AbstractOperatorContext.makeStringColumn('label', ['a', 'b']);

      expect(col.name, 'label');
      expect(col.type, 'string');
      expect(col.nRows, 2);
      expect(col.values, isA<CStringList>());
      expect((col.values as CStringList).toList(), equals(['a', 'b']));
      expect(col.cValues, isA<StrValues>());
      expect((col.cValues as StrValues).values.toList(), equals(['a', 'b']));
    });

    test('helper-built columns survive save without issues', () async {
      final cqt = CubeQueryTask();
      cqt.id = 'task-1';
      cqt.rev = '1';
      cqt.query = testQuery;
      cqt.projectId = 'proj-1';
      cqt.owner = 'user-1';
      mockFactory.taskService.addTask('task-1', cqt);

      final ctx = await OperatorContext.create(
        serviceFactory: mockFactory,
        taskId: 'task-1',
      );

      final table = Table();
      table.nRows = 2;
      table.columns.add(AbstractOperatorContext.makeInt32Column('.ci', [0, 1]));
      table.columns
          .add(AbstractOperatorContext.makeFloat64Column('.y', [3.14, 2.71]));
      table.columns
          .add(AbstractOperatorContext.makeStringColumn('name', ['x', 'y']));

      await ctx.saveTable(table);

      expect(mockFactory.fileService.uploadCalls, hasLength(1));
    });
  });
}
