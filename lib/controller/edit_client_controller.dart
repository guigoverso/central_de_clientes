import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/extensions/date_time_extensions.dart';
import 'package:central_de_clientes/shared/extensions/string_extensions.dart';
import 'package:central_de_clientes/shared/masks/phone_mask.dart';
import 'package:central_de_clientes/shared/request_status/request_status.dart';
import 'package:central_de_clientes/shared/request_status/request_status_listener.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';

class EditClientController {
  final ClientModel _client;
  final ClientService _service;
  final RequestStatusListener editClientStatus =
      RequestStatusListener(defaultStatus: RequestStatus.completed);

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final ValueNotifier<DateTime> birthAt;

  ClientModel get client => _client;

  EditClientController(this._client, this._service) {
    nameController = TextEditingController(text: _client.name);
    phoneController = MaskedTextController(text: PhoneMask.unmask(_client.phone), mask: PhoneMask.pattern);
    emailController = TextEditingController(text: _client.email);
    birthAt = ValueNotifier<DateTime>(_client.birthAt.parseGlobalDate);
  }

  void updateBirthAt(DateTime? value) {
    if(value != null) {
      birthAt.value = value;
    }
  }

  ClientModel editedClient() {
    return _client.copyWith(
      name: nameController.text,
      phone: PhoneMask.unmask(phoneController.text),
      email: emailController.text,
      birthAt: birthAt.value.formatGlobalDate,
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
