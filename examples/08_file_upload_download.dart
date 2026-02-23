import 'dart:convert';
import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'helper.dart';

void main() async {
  var factory = await initFactory();
  var project = await getOrCreateProject(factory, 'example-project');

  // --- Upload a file (stream) ---
  var csvContent = 'name,value\nalpha,1\nbeta,2\ngamma,3\n';
  var bytes = utf8.encode(csvContent);
  var fileDoc = sci.FileDocument()
    ..name = 'sample.csv'
    ..projectId = project.id;
  var uploaded = await factory.fileService
      .upload(fileDoc, Stream.value(bytes));
  print('uploaded: ${uploaded.id} size=${uploaded.size}');

  // --- Download to bytes ---
  var downloadedBytes = await factory.fileService
      .download(uploaded.id)
      .fold<List<int>>([], (prev, chunk) => prev..addAll(chunk));
  var content = utf8.decode(downloadedBytes);
  print('downloaded ${downloadedBytes.length} bytes');
  print('content: ${content.substring(0, 30)}...');

  // --- Download line-by-line ---
  var lines = await factory.fileService
      .download(uploaded.id)
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .toList();
  print('lines: ${lines.length}');

  // --- Append ---
  var appendContent = 'delta,4\n';
  var appendBytes = utf8.encode(appendContent);
  var appended = await factory.fileService
      .append(uploaded, Stream.value(appendBytes));
  print('appended: size=${appended.size}');

  // --- Zip operations (requires a zip file) ---
  // var entries = await factory.fileService.listZipContents(zipFileId);
  // print('zip entries: ${entries.length}');
  // var entryStream = factory.fileService.downloadZipEntry(zipFileId, 'file.txt');

  // cleanup
  await factory.fileService.delete(uploaded.id, appended.rev);
}
