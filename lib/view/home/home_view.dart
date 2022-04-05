import 'package:central_de_clientes/controller/home_controller.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/routes/app_routes.dart';
import 'package:central_de_clientes/routes/route_name.dart';
import 'package:central_de_clientes/shared/extensions/navigator_state_extensions.dart';
import 'package:central_de_clientes/shared/request_status/request_status_builder.dart';
import 'package:central_de_clientes/shared/widgets/app_bar_background.dart';
import 'package:central_de_clientes/shared/widgets/button_height_animation.dart';
import 'package:central_de_clientes/view/home/widgets/home_client_list.dart';
import 'package:central_de_clientes/view/home/widgets/home_search_field.dart';
import 'package:flutter/material.dart';

import 'widgets/home_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required ClientService service})
      : _service = service,
        super(key: key);

  final ClientService _service;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(widget._service);
    _controller.fetchClients();
  }

  Future<void> toNewClientView(BuildContext context) async {
    final result =
        await Navigator.of(context).fadePushNamed(RouteName.newClient);
    _controller.onCreateNewClient(result as ClientModel?);
  }

  @override
  Widget build(BuildContext context) {
    return RequestStatusBuilder<List<ClientModel?>>(
      listener: _controller.clientsStatus,
      onLoading: (_) => Scaffold(
        body: AppBackgroundImage(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          imageOpacity: .7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Carregado Clientes...',
                  style: TextStyle(color: Colors.white, fontSize: 36)),
              SizedBox(height: 24),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
      onCompleted: (context, data) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  HomeAppBar(totalClients: _controller.totalClients),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HomeSearchField(onSearch: _controller.onSearch),
                          const SizedBox(height: 16),
                          Expanded(
                            child: HomeClientList(_controller),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ButtonHeightAnimation(
                  child: const Icon(Icons.person_add, color: Colors.white),
                  onPressed: () => toNewClientView(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
