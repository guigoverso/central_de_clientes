import 'package:central_de_clientes/core/service/http_service.dart';
import 'package:central_de_clientes/core/service/service_endpoints.dart';
import 'package:central_de_clientes/model/client_model.dart';

class ClientService {

  final HttpService _service;

  ClientService(this._service);

  Future<List<ClientModel>> fetchClients() async {
    final json = await _service.get(ServiceEndpoints.clients);
    return (json as List).map((e) => ClientModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<ClientModel> createClient(ClientModel newClient) async {
    final result = await _service.post(ServiceEndpoints.clients, body: newClient.toJson());
    return ClientModel.fromJson(result as Map<String, dynamic>);
  }

  Future<ClientModel> editClient(ClientModel client) async {
    final result = await _service.patch(ServiceEndpoints.editClient(client.id), body: client.toJson());
    return ClientModel.fromJson(result as Map<String, dynamic>);
  }

  Future<int> deleteClient(int clientId) async {
   final result = await _service.delete(ServiceEndpoints.editClient(clientId));
   return result;
  }
}