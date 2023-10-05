import 'package:rxdart/rxdart.dart';

extension BehaviorSubjectExtension<T> on BehaviorSubject<T> {
  BehaviorSubject<T> disposeBy(List<dynamic> disposeBag) {
    disposeBag.add(this);
    return this;
  }

  emit(T data) {
    if (!isClosed) {
      add(data);
    }
  }
}

extension PublishSubjectExtension<T> on PublishSubject<T> {
  PublishSubject<T> disposeBy(List<dynamic> disposeBag) {
    disposeBag.add(this);
    return this;
  }

  emit(T data) {
    if (!isClosed) {
      add(data);
    }
  }
}

extension SubjectExtension<T> on Subject<T> {
  Subject<T> disposeBy(List<dynamic> disposeBag) {
    disposeBag.add(this);
    return this;
  }

  emit(T data) {
    if (!isClosed) {
      add(data);
    }
  }
}
