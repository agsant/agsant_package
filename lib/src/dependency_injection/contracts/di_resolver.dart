import 'package:kiwi/kiwi.dart';

mixin DIResolver {
  late KiwiContainer container;

  T resolve<T>([String? name]) {
    return container.resolve<T>(name);
  }
}
