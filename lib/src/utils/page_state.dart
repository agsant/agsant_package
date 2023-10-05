import 'package:agsant_package/agsant_package.dart';

class PageState<T> {
  StateType _type = StateType.loading;
  String _error = '';
  late T _data;

  PageState.loading() {
    _type = StateType.loading;
  }

  PageState.empty() {
    _type = StateType.empty;
  }

  PageState.error(String error) {
    _type = StateType.error;
    _error = error;
  }

  PageState.success(T data) {
    _type = StateType.success;
    _data = data;
  }

  String getError() {
    return _error;
  }

  T getData() {
    return _data;
  }

  StateType getState() {
    return _type;
  }
}
