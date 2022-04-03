import 'package:central_de_clientes/shared/request_status/request_status.dart';
import 'package:flutter/cupertino.dart';

class RequestStatusListener<T> {
  late final ValueNotifier<RequestStatus> listenable;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  T? _data;

  T? get data => _data;

  RequestStatus get value => listenable.value;

  bool get isNone => listenable.value == RequestStatus.none;

  bool get isLoading => listenable.value == RequestStatus.loading;

  bool get isCompleted => listenable.value == RequestStatus.completed;

  bool get isError => listenable.value == RequestStatus.error;

  RequestStatusListener(
      {RequestStatus? defaultStatus,
    T? data,
    String? errorMessage,
  })  : listenable = ValueNotifier(defaultStatus ?? RequestStatus.none),
        _data = data,
        _errorMessage = errorMessage ?? '';

  void none() => listenable.value = RequestStatus.none;

  void loading() => listenable.value = RequestStatus.loading;

  void completed([T? data]) {
    listenable.value = RequestStatus.completed;
    _data = data;
  }

  void error(String errorMessage) {
    listenable.value = RequestStatus.error;
    _errorMessage = errorMessage;
  }
}
