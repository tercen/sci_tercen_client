import 'dart:io';
import 'package:sci_tercen_client/sci_client_base.dart';
import 'package:sci_http_client/http_auth_client.dart';

void main() async {
  var uri = Uri.parse(
      Platform.environment['TERCEN_URI'] ?? 'http://127.0.0.1:5400');

  // --- Connect with username/password ---
  var factory = ServiceFactoryBase();
  await factory.initializeWith(uri);

  var session = await factory.userService.connect('admin', 'admin');
  print('user: ${session.user.name}');
  print('token: ${session.token.token}');
  print('server: ${session.serverVersion.major}.${session.serverVersion.minor}.${session.serverVersion.patch}');

  // --- Create a short-lived token ---
  var newToken =
      await factory.userService.createToken(session.user.id, 3600);
  print('new token: $newToken');

  var valid = await factory.userService.isTokenValid(newToken);
  print('token valid: $valid');

  // --- Use token with HttpAuthClient ---
  var authClient = HttpAuthClient('Bearer $newToken');
  var factory2 = ServiceFactoryBase();
  await factory2.initializeWith(uri, authClient);

  var user = await factory2.userService.get(session.user.id);
  print('authenticated as: ${user.name}');

  // --- Use helper pattern (env var) ---
  // TERCEN_TOKEN=<token> dart run examples/01_auth.dart
}
