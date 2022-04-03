import 'package:central_de_clientes/controller/home_controller.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/request_status/request_status_builder.dart';
import 'package:central_de_clientes/view/home/widgets/client_card.dart';
import 'package:central_de_clientes/view/home/widgets/home_search_field.dart';
import 'package:central_de_clientes/view/home/widgets/list_separator.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'widgets/home_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required ClientService service})
      : _service = service,
        super(key: key);

  final ClientService _service;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(widget._service);
    _controller.fetchClients();
  }

  @override
  Widget build(BuildContext context) =>
      RequestStatusBuilder<List<ClientModel?>>(
        listener: _controller.clientsStatus,
        onLoading: (_) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Bem-vindo!',
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
            appBar: HomeAppBar(
              totalClients: _controller.totalClients,
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.person_add),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HomeSearchField(onSearch: _controller.onSearch),
                  const SizedBox(height: 16),
                  Expanded(
                    child:
                        ValueListenableBuilder<Map<String, List<ClientModel>>>(
                      valueListenable: _controller.filteredClients,
                      builder: (context, filteredClients, _) {
                        return ListView.builder(
                          itemCount: filteredClients.keys.length,
                          itemBuilder: (_, i) {
                            final key = filteredClients.keys.toList()[i];
                            final values = filteredClients[key];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: StickyHeader(
                                header: Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Container(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    child: ListSeparator(key),
                                  ),
                                ),
                                content: Column(
                                  children: values!
                                      .map((e) => ClientCard(e, position: values.indexOf(e)))
                                      .toList(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
