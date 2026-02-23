import 'dart:convert';
import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'helper.dart';

void main() async {
  var factory = await initFactory();
  var project = await getOrCreateProject(factory, 'example-project');

  // --- Import CSV via CSVTask ---
  var csvContent = 'name,value\nalpha,1\nbeta,2\ngamma,3\n';
  var bytes = utf8.encode(csvContent);

  var fileDoc = sci.FileDocument()
    ..name = 'data.csv'
    ..projectId = project.id;
  var uploaded =
      await factory.fileService.upload(fileDoc, Stream.value(bytes));

  var csvTask = sci.CSVTask()
    ..fileDocumentId = uploaded.id
    ..projectId = project.id
    ..owner = project.acl.owner;
  csvTask = await factory.taskService.create(csvTask) as sci.CSVTask;
  await factory.taskService.runTask(csvTask.id);
  var doneTask = await factory.taskService.waitDone(csvTask.id);
  print('CSVTask state: ${doneTask.state.runtimeType}');

  // --- Get schema from completed task ---
  var csvDone = doneTask as sci.CSVTask;
  var schemaId = csvDone.schemaId;
  var schema = await factory.tableSchemaService.get(schemaId);
  print('schema: ${schema.name} nRows=${schema.nRows}');
  print('columns: ${schema.columns.map((c) => '${c.name}(${c.type})').toList()}');

  // --- Select (returns Table with column values) ---
  var cnames = schema.columns.map((c) => c.name).toList();
  var table = await factory.tableSchemaService
      .select(schema.id, cnames, 0, 100);
  print('table: ${table.nRows} rows, ${table.columns.length} cols');
  for (var col in table.columns) {
    print('  ${col.name}: ${col.values}');
  }

  // --- SelectStream (returns binary bytes) ---
  var streamBytes = await factory.tableSchemaService
      .selectStream(schema.id, cnames, 0, 100)
      .fold<List<int>>([], (prev, chunk) => prev..addAll(chunk));
  print('selectStream: ${streamBytes.length} bytes');

  // --- SelectCSV ---
  var csvBytes = await factory.tableSchemaService
      .selectCSV(schema.id, cnames, 0, 100, ',', true, 'utf-8')
      .transform(utf8.decoder)
      .join();
  print('selectCSV:\n$csvBytes');
}
