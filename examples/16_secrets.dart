import 'package:sci_tercen_client/sci_client.dart';
import 'helper.dart';

void main() async {
  var factory = await initFactory();

  // --- Find secrets by user (stream) ---
  var secrets = await factory.userSecretService
      .findSecretByUserIdStream()
      .take(10)
      .toList();
  print('secrets: ${secrets.length}');
  for (var s in secrets) {
    print('  id=${s.id} userId=${s.userId}');
  }

  // --- Get secret value by id and name ---
  // getSecret(secretId, secretName) retrieves the decrypted value
  if (secrets.isNotEmpty) {
    var secret = secrets.first;
    try {
      var value =
          await factory.userSecretService.getSecret(secret.id, 'my-key');
      print('secret value: $value');
    } catch (e) {
      print('getSecret error (expected if name not found): $e');
    }
  }
}
