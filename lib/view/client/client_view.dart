import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/view/client/widgets/client_app_bar.dart';
import 'package:flutter/material.dart';

class ClientView extends StatelessWidget {
  const ClientView({Key? key, required this.client}) : super(key: key);

  final ClientModel client;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ClientAppBar(client),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ],
      ),
    );
  }
}
