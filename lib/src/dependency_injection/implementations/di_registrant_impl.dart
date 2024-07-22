import 'package:agsant_package/src/dependency_injection/contracts/di_registrant.dart';
import 'package:kiwi/kiwi.dart';

class DIRegistrantImpl with DIRegistrant {
  DIRegistrantImpl({required KiwiContainer container}) {
    this.container = container;
  }
}
