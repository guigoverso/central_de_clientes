import 'package:central_de_clientes/controller/client_controller.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/functions/show_snack_bar.dart';
import 'package:central_de_clientes/shared/request_status/request_status.dart';
import 'package:central_de_clientes/shared/widgets/client_info_card.dart';
import 'package:central_de_clientes/view/client/widgets/client_app_bar.dart';
import 'package:flutter/material.dart';

class ClientView extends StatefulWidget {
  const ClientView(
      {Key? key, required this.client, required ClientService service})
      : _service = service,
        super(key: key);

  final ClientService _service;
  final ClientModel client;

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  late final ClientController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ClientController(widget._service, widget.client);
  }

  Future<void> onDeleteDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ValueListenableBuilder<RequestStatus>(
        valueListenable: _controller.deleteClientStatus.notifier,
        builder: (_, status, __) {
          List<Widget> children;
          if (_controller.deleteClientStatus.isLoading) {
            children = [
              Container(
                alignment: Alignment.center,
                width: 60,
                height: 60,
                child: const CircularProgressIndicator(),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text('Deletando cliente...'),
              )
            ];
          } else {
            children = [
              TextButton(
                  onPressed: () => _onDeleteClient(context),
                  child: const Text('Sim')),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Não')),
            ];
          }
          return SimpleDialog(
            title: const Text('Deseja deletar o cliente?'),
            children: children,
          );
        },
      ),
    );
  }

  Future<void> _onDeleteClient(BuildContext context) async {
    await _controller.deleteClient(
      onSuccess: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop(true);
      },
      onError: (message) {
        Navigator.of(context).pop();
        showSnackBar(context: context, message: message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.client != _controller.client) {
          Navigator.of(context).pop(_controller.client);
          return true;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.edit),
        ),
        body: ValueListenableBuilder<ClientModel>(
          valueListenable: _controller.listenable,
          builder: (context, client, _) => CustomScrollView(
            slivers: [
              ClientAppBar(client,
                  onDelete: () => onDeleteDialog(context)),
              SliverToBoxAdapter(
                child: Visibility(
                  visible: false,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.call),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.email),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.message),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClientInfoCard(
                          title: 'Informações de Contato',
                          info: {
                            Icons.call: client.phone,
                            Icons.email: client.email,
                          },
                        ),
                        const SizedBox(height: 16),
                        ClientInfoCard(
                          title: 'Informações Pessoais',
                          info: {
                            Icons.cake: client.birthAt,
                          },
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
