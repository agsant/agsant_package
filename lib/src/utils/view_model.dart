import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ViewModel {
  List<dynamic> disposeBag = <dynamic>[];

  void dispose() {
    for (var element in disposeBag) {
      if (element is Subject ||
          element is BehaviorSubject ||
          element is PublishSubject) {
        element.close();
      } else if (element is StreamSubscription) {
        element.cancel();
      }
    }
  }
}
