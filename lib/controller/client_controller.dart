import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/request_status/request_status_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientController {
  final ClientService _service;
  final RequestStatusListener deleteClientStatus = RequestStatusListener();

  late ClientModel _client;

  ClientModel get client => _client;

  ClientController(this._service, this._client);

  Future<void> onUpdateClient({
    required Future<ClientModel?> Function() toUpdateClient,
    required VoidCallback callback,
  }) async {
    final updatedClient = await toUpdateClient();
    if (updatedClient != null) {
      _client = updatedClient;
      callback();
    }
  }

  Future<void> deleteClient({
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    deleteClientStatus.loading();
    try {
      await Future.delayed(Duration(seconds: 5));
      // await _service.deleteClient(_client.id);
      deleteClientStatus.completed();
      onSuccess();
    } catch(e) {
      deleteClientStatus.error(e.toString());
      onError(e.toString());
    }
  }
}
