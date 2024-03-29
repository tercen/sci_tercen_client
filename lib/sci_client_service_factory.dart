import 'dart:async';
import './sci_client_service_factory_base.dart';
export './sci_client_service_factory_base.dart';

abstract class ServiceFactory extends ServiceFactoryBase {
  static ServiceFactory? CURRENT;
  factory ServiceFactory() {
    var current = Zone.current[#ServiceFactory];
    if (current != null && current is ServiceFactory) {
      return current;
    } else {
      return CURRENT!;
    }
  }
}
