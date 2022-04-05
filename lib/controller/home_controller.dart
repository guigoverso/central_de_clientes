import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/request_status/request_status_listener.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
  final ClientService _service;
  final RequestStatusListener clientsStatus = RequestStatusListener<List<ClientModel>>();

  final ValueNotifier<List<ClientModel>> _clientsListenable = ValueNotifier([]);

  List<ClientModel> get _clients => _clientsListenable.value;

  final ValueNotifier<Map<String, List<ClientModel>>> filteredClients =
      ValueNotifier({});

  ValueNotifier<int> totalClients = ValueNotifier(0);

  HomeController(this._service) {
    _clientsListenable.addListener(() {
      _sortClientsAlphabeticallyAndUpdateQtd();
      totalClients.value = _clientsListenable.value.length;
    });
  }


  void _sortClientsAlphabeticallyAndUpdateQtd([List<ClientModel>? clientsList]) {
    _clientsListenable.value.sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
    final _clientsList = clientsList ?? _clients;
    final keys = _clientsList.map((e) => e.name[0].toLowerCase()).toSet();
    final sortedClients = {
      for (var k in keys)
        k: _clientsList.where((e) => e.name[0].toLowerCase() == k).toList()
    };
    filteredClients.value = sortedClients;
    totalClients.value = _clients.length;
  }

  void onSearch(String? value) {
    if(value == null) {
      _sortClientsAlphabeticallyAndUpdateQtd();
      return;
    }
    final filteredClient = _clients.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
    _sortClientsAlphabeticallyAndUpdateQtd(filteredClient);
  }

  Future<void> fetchClients() async {
    clientsStatus.loading();
    try {
      final result = await _service.fetchClients();
      _clientsListenable.value = result;
      clientsStatus.completed(_clients);
    } catch (e) {
      clientsStatus.error(e.toString());
    }
  }

  void whenBackClientScreen({required ClientModel client, dynamic result}) {
    if(result == null) return;
    final position = _clients.indexOf(client);
    if(result is ClientModel) {
      _clients[position] = result;
    }
    if(result is bool && result) {
      _clients.remove(client);
    }
    _sortClientsAlphabeticallyAndUpdateQtd();
  }

  void onCreateNewClient(ClientModel? client) {
    if(client != null) {
      _clients.add(client);
      _sortClientsAlphabeticallyAndUpdateQtd();
    }
  }

}
