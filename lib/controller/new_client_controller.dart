import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/extensions/date_time_extensions.dart';
import 'package:central_de_clientes/shared/request_status/request_status.dart';
import 'package:central_de_clientes/shared/request_status/request_status_listener.dart';
import 'package:flutter/cupertino.dart';

class NewClientController {
  final ClientService _service;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneNumberTextController =
      TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final ValueNotifier<DateTime?> birthAtListenable = ValueNotifier(null);

  final RequestStatusListener createClienteStatus =
      RequestStatusListener(defaultStatus: RequestStatus.completed);

  final ValueNotifier<int> index = ValueNotifier(0);
  final ValueNotifier<bool> toNextSection = ValueNotifier(false);

  NewClientController(this._service) {
    nameTextController.addListener(_checkToNextSection);
    phoneNumberTextController.addListener(_checkToNextSection);
    emailTextController.addListener(_checkToNextSection);
    birthAtListenable.addListener(_checkToNextSection);
    index.addListener(_checkToNextSection);
  }

  void _checkToNextSection() {
    bool permission = false;
    switch (index.value) {
      case 0:
        permission = nameTextController.text.isNotEmpty;
        break;
      case 1:
        permission = phoneNumberTextController.text.isNotEmpty;
        break;
      case 2:
        permission = emailTextController.text.isNotEmpty;
        break;
      case 3:
        permission = birthAtListenable.value != null;
        break;
      default:
        break;
    }
    toNextSection.value = permission;
    toNextSection.notifyListeners();
  }

  ClientModel get _newClient {
    return ClientModel.new(
      name: nameTextController.text,
      email: emailTextController.text,
      phone: phoneNumberTextController.text,
      birthAt: birthAtListenable.value!.formatLocalDate,
    );
  }

  Future<void> createClient({
    required Function(ClientModel newClient) onSuccess,
    required Function(String message) onError,
  }) async {
    createClienteStatus.loading();
    try {
      final clientWithId = await _service.createClient(_newClient);
      onSuccess(clientWithId);
    } catch(e) {
      createClienteStatus.completed();
      onError(e.toString());
    }
  }
}
