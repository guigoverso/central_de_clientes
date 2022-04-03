import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/request_status/request_status_listener.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
  final ClientService _service;
  final RequestStatusListener clientsStatus = RequestStatusListener<List<ClientModel>>();

  List<ClientModel> _clients = [];
  final ValueNotifier<Map<String, List<ClientModel>>> filteredClients =
      ValueNotifier({});

  int get totalClients => _clients.length;

  HomeController(this._service);


  void _sortClientsAlphabetically([List<ClientModel>? clientsList]) {
    final _clientsList = clientsList ?? _clients;
    final keys = _clientsList.map((e) => e.name[0].toLowerCase()).toSet();
    final sortedClients = {
      for (var k in keys)
        k: _clientsList.where((e) => e.name[0].toLowerCase() == k).toList()
    };
    filteredClients.value = sortedClients;
  }

  void onSearch(String? value) {
    if(value == null) {
      _sortClientsAlphabetically();
      return;
    }
    final filteredClient = _clients.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
    _sortClientsAlphabetically(filteredClient);
  }

  Future<void> fetchClients() async {
    clientsStatus.loading();
    try {
      final result = await _service.fetchClients();
      _clients = result..sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
      _sortClientsAlphabetically();
      clientsStatus.completed(_clients);
    } catch (e) {
      clientsStatus.error(e.toString());
    }
  }
}
