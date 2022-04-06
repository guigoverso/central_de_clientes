import 'package:central_de_clientes/controller/client_controller.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/routes/route_name.dart';
import 'package:central_de_clientes/shared/enum/action_button_type.dart';
import 'package:central_de_clientes/shared/extensions/navigator_state_extensions.dart';
import 'package:central_de_clientes/shared/functions/show_snack_bar.dart';
import 'package:central_de_clientes/shared/request_status/request_status.dart';
import 'package:central_de_clientes/shared/widgets/client_info_card.dart';
import 'package:central_de_clientes/shared/widgets/client_app_bar.dart';
import 'package:central_de_clientes/shared/extensions/date_time_extensions.dart';
import 'package:central_de_clientes/shared/extensions/string_extensions.dart';
import 'package:central_de_clientes/view/client/widgets/client_action_button.dart';
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
        valueListenable: _controller.deleteClientStatus.listenable,
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
    final theme = Theme.of(context).colorScheme;
    return WillPopScope(
      onWillPop: () async {
        if (widget.client != _controller.client) {
          Navigator.of(context).pop(_controller.client);
          return true;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final updatedClient = await Navigator.of(context)
                .fadePushNamed(RouteName.editClient, arguments: _controller.client);
            _controller.onUpdateClient(
              updatedClient: updatedClient,
              callback: () => showSnackBar(
                context: context,
                message: 'Cliente editado com sucesso',
              ),
            );
          },
          child: const Icon(Icons.edit),
        ),
        body: ValueListenableBuilder<ClientModel>(
          valueListenable: _controller.listenable,
          builder: (context, client, _) => CustomScrollView(
            slivers: [
              ClientAppBar(client, onDelete: () => onDeleteDialog(context)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClientActionButton(
                        type: ActionButtonType.call,
                        icon: Icons.call,
                        onPressed: _controller.onActionButtonPressed,
                        title: 'Ligar',
                      ),
                      ClientActionButton(
                        icon: Icons.whatsapp,
                        onPressed: _controller.onActionButtonPressed,
                        title: 'WhatsApp',
                        type: ActionButtonType.whatsapp,
                      ),
                      ClientActionButton(
                        icon: Icons.email,
                        onPressed: _controller.onActionButtonPressed,
                        title: 'E-mail',
                        type: ActionButtonType.email,
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
                            Icons.call: _controller.clientPhone,
                            Icons.email: client.email,
                          },
                        ),
                        const SizedBox(height: 16),
                        ClientInfoCard(
                          title: 'Informações Pessoais',
                          info: {
                            Icons.cake:
                                client.birthAt.parseGlobalDate.formatLocalDate,
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
