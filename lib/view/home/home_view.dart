import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/core/service/http_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required ClientService service}) : _service = service, super(key: key);

  final ClientService _service;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String text = '';
  final ClientService service = ClientService(HttpService());
  ClientModel? cliente;

  String get texto {
    if(cliente == null) return 'Sem Cliente';
    return '${cliente!.id} : ${cliente!.name}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de Clientes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(texto),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              onPressed: () async {
                final result = await service.fetchClients();
                print(result);
              },
              child: Text('Pegar clientes'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              onPressed: () async {
                final novoCliente = ClientModel.new(
                  name: 'Guilherme',
                  email: 'guilherme@email.com',
                  phone: '123456',
                  birthAt: '13/10/1997',
                );
                final result = await service.createClient(novoCliente);
                setState(() {
                  cliente = result;
                });
              },
              child: Text('Criar Cliente'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              onPressed: () async {
                final novoClienteEditado = cliente!.copyWith(name: 'Guilherme Corona');
                final result = await service.editClient(novoClienteEditado);
                setState(() {
                  cliente = result;
                });
              },
              child: Text('Editar Cliente'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              onPressed: () async {
                await service.deleteClient(cliente!.id);
                setState(() {
                  cliente = null;
                });
              },
              child: Text('Deletar Cliente'),
            ),
          ),
        ],
      ),
    );
  }
}
