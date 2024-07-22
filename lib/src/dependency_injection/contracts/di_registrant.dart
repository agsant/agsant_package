import 'package:agsant_package/src/dependency_injection/contracts/di_resolver.dart';
import 'package:agsant_package/src/dependency_injection/implementations/di_resolver_impl.dart';
import 'package:kiwi/kiwi.dart';

mixin DIRegistrant {
  late KiwiContainer container;

  register<T>(T Function(DIResolver r) resolver, {String? name}) {
    container.registerFactory(
      (c) => resolver(DIResolverImpl(container: c)),
      name: name,
    );
  }

  registerSingleton<T>(T Function(DIResolver r) resolver, {String? name}) {
    container.registerSingleton(
      (c) => resolver(DIResolverImpl(container: c)),
      name: name,
    );
  }
}
