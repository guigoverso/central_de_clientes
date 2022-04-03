import 'package:central_de_clientes/controller/edit_client_controller.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:flutter/material.dart';

import '../../model/client_model.dart';

class EditClientView extends StatefulWidget {
  const EditClientView({
    Key? key,
    required this.client,
    required this.service,
  }) : super(key: key);

  final ClientModel client;
  final ClientService service;

  @override
  State<EditClientView> createState() => _EditClientViewState();
}

class _EditClientViewState extends State<EditClientView> {

  late final EditClientController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EditClientController(widget.client, widget.service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

        ],
      ),
    );
  }
}
