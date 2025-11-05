import 'package:sci_tercen_client/sci_client_service_factory.dart';
import 'package:sci_tercen_client/sci_client.dart' as sci;
import 'package:sci_tercen_client/sci_client_service_factory.dart' as tercen;
import 'package:sci_http_client/http_client.dart' as http_client;
import 'package:sci_http_client/http_auth_client.dart' as auth_http;

import 'package:sci_http_client/http_browser_client.dart'
    if (dart.library.io) 'package:sci_http_client/http_io_client.dart';

Future<ServiceFactory> createServiceFactoryForWebApp(
    {String? tercenToken}) async {
  // Set the HTTP client - conditional code based on platform
  _setHttpClient();

  var httpClient = http_client.HttpClient();
  if (tercenToken != null) {
    httpClient = auth_http.HttpAuthClient(tercenToken);
  }

  var factory = sci.ServiceFactory();
  var uriBase = Uri.base;
  await factory.initializeWith(
      Uri(scheme: uriBase.scheme, host: uriBase.host, port: uriBase.port),
      httpClient);

  tercen.ServiceFactory.CURRENT = factory;

  return factory;
}

void _setHttpClient() {
  // This will use HttpIOClient or HttpBrowserClient depending on the platform
  try {
    HttpBrowserClient.setAsCurrent();
  } catch (e) {
    throw "HttpBrowserClient is only available for web platform. This error indicates the code is running in a non-web environment.";
  }
}
