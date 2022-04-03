import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/request_status/request_status.dart';
import 'package:central_de_clientes/shared/request_status/request_status_listener.dart';
import 'package:flutter/cupertino.dart';

class EditClientController {
  final ClientModel _client;
  final ClientService _service;
  final RequestStatusListener editClientStatus =
      RequestStatusListener(defaultStatus: RequestStatus.completed);

  ClientModel get client => _client;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController birthAtController;

  EditClientController(this._client, this._service) {
    nameController = TextEditingController(text: _client.name);
    phoneController = TextEditingController(text: _client.phone);
    emailController = TextEditingController(text: _client.email);
    birthAtController = TextEditingController(text: _client.birthAt);
  }

  ClientModel editedClient() {
    return _client.copyWith(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      birthAt: birthAtController.text,
    );
  }

  Future<void> editClient({
    required Function(ClientModel client) onSuccess,
    required Function(String message) onError,
  }) async {
    editClientStatus.loading();
    try {
      final client = await _service.editClient(editedClient());
      editClientStatus.completed();
      onSuccess(client);
    } catch(e) {
      editClientStatus.error(e.toString());
    }
  }
}
