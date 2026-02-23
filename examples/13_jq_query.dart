import 'helper.dart';

void main() async {
  var factory = await initFactory();

  // --- JQ query (returns stream of JSON strings) ---
  // The jq() method runs a JQ expression server-side and streams results.
  var results = await factory.queryService
      .jq('.[] | select(.kind == "Project")', 10)
      .toList();
  print('jq results: ${results.length}');
  for (var r in results) {
    print('  $r');
  }

  // --- Stream consumption (process as they arrive) ---
  await for (var line
      in factory.queryService.jq('.[] | .name', 5)) {
    print('name: $line');
  }
}
