import 'package:central_de_clientes/shared/request_status/request_status.dart';
import 'package:flutter/cupertino.dart';

class RequestStatusListener<T> {
  late final ValueNotifier<RequestStatus> notifier;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  T? _data;

  T? get data => _data;

  RequestStatus get value => notifier.value;

  bool get isNone => notifier.value == RequestStatus.none;

  bool get isLoading => notifier.value == RequestStatus.loading;

  bool get isCompleted => notifier.value == RequestStatus.completed;

  bool get isError => notifier.value == RequestStatus.error;

  RequestStatusListener(
      {RequestStatus? defaultStatus,
    T? data,
    String? errorMessage,
  })  : notifier = ValueNotifier(defaultStatus ?? RequestStatus.none),
        _data = data,
        _errorMessage = errorMessage ?? '';

  void none() => notifier.value = RequestStatus.none;

  void loading() => notifier.value = RequestStatus.loading;

  void completed([T? data]) {
    notifier.value = RequestStatus.completed;
    _data = data;
  }

  void error(String errorMessage) {
    notifier.value = RequestStatus.error;
    _errorMessage = errorMessage;
  }
}
