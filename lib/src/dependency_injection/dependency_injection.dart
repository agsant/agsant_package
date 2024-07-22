library agriaku_dependency_injection;

import 'package:agsant_package/src/dependency_injection/contracts/di_assembly.dart';
import 'package:agsant_package/src/dependency_injection/contracts/di_registrant.dart';
import 'package:agsant_package/src/dependency_injection/contracts/di_resolver.dart';
import 'package:agsant_package/src/dependency_injection/implementations/di_registrant_impl.dart';
import 'package:kiwi/kiwi.dart';

export 'package:agsant_package/src/dependency_injection/contracts/di_assembly.dart';
export 'package:agsant_package/src/dependency_injection/contracts/di_registrant.dart';
export 'package:agsant_package/src/dependency_injection/contracts/di_resolver.dart';

class DependencyInjection with DIRegistrant, DIResolver {
  static DependencyInjection shared = DependencyInjection();

  DependencyInjection() {
    container = KiwiContainer();
  }

  assemble(List<DIAssembly> assemblies) {
    for (var element in assemblies) {
      element.assemble(DIRegistrantImpl(container: container));
    }
  }

  clear() {
    container.clear();
  }
}
