import 'dart:io';
import 'dart:convert';

import 'package:sci_http_client/http_auth_client.dart' as auth_http;
import 'package:sci_http_client/http_io_client.dart' as io_http;
import 'package:sci_tercen_client/sci_client.dart';
import 'package:sci_tercen_client/sci_client_service_factory.dart' as tercen;

main() async {
  var factory = ServiceFactory();
  await factory.initializeWith(
      Uri.parse('http://127.0.0.1:5400'), io_http.HttpIOClient());
  tercen.ServiceFactory.CURRENT = factory;

  var userSession =
      await tercen.ServiceFactory().userService.connect('test', 'test');

  print(JsonEncoder.withIndent('  ').convert(userSession.toJson()));

  var token = userSession.token.token;

  var authClient = auth_http.HttpAuthClient(token, io_http.HttpIOClient());
  await factory.initializeWith(
      Uri.parse('http://127.0.0.1:5400'), authClient);


  var user = await tercen.ServiceFactory().userService.get(userSession.user.id);

  print(JsonEncoder.withIndent('  ').convert(user.toJson()));

  exit(0);
}
