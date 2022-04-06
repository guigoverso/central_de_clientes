import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/enum/action_button_type.dart';
import 'package:central_de_clientes/shared/request_status/request_status_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/masks/phone_mask.dart';

class ClientController {
  final ClientService _service;
  final RequestStatusListener deleteClientStatus = RequestStatusListener();

  late final ValueNotifier<ClientModel> _clientListenable;

  ValueNotifier<ClientModel> get listenable => _clientListenable;

  ClientModel get client => _clientListenable.value;
  String get clientPhone => PhoneMask.mask(client.phone);

  ClientController(this._service, ClientModel client) : _clientListenable = ValueNotifier(client);

  void onUpdateClient({
    required dynamic updatedClient,
    required VoidCallback callback,
  }) async {
    if (updatedClient != null && updatedClient is ClientModel) {
      _clientListenable.value = updatedClient;
      callback();
    }
  }

  Future<void> onActionButtonPressed(ActionButtonType type) async {
    String url = '';
    switch(type) {
      case ActionButtonType.call:
        url = 'tel:${client.phone}';
        break;
      case ActionButtonType.email:
        url = 'mailto:${client.email}';
        break;
      case ActionButtonType.whatsapp:
        url = 'https://wa.me/${client.phone}';
        break;
    }
    if(await canLaunch(url)) {
      launch(url);
    }
  }

  Future<void> deleteClient({
    required VoidCallback onSuccess,
    required Function(String message) onError,
  }) async {
    deleteClientStatus.loading();
    try {
      await _service.deleteClient(client.id);
      deleteClientStatus.completed();
      onSuccess();
    } catch(e) {
      deleteClientStatus.error(e.toString());
      onError(e.toString());
    }
  }
}
