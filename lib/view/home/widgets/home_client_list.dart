import 'package:central_de_clientes/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../model/client_model.dart';
import '../../../routes/route_name.dart';
import 'client_card.dart';
import 'list_separator.dart';

class HomeClientList extends StatelessWidget {
  const HomeClientList(this._controller, {Key? key}) : super(key: key);

  final HomeController _controller;

  Future<void> _toClientDetailsScreen(
    BuildContext context,
    ClientModel client,
  ) async {
    final result = await Navigator.of(context)
        .pushNamed(RouteName.client, arguments: client);
    _controller.whenBackClientScreen(client: client, result: result);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, List<ClientModel>>>(
      valueListenable: _controller.filteredClients,
      builder: (context, filteredClients, _) {
        return RefreshIndicator(
          onRefresh: _controller.fetchClients,
          child: ListView.builder(
            padding: EdgeInsets.zero,
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
                      color: Theme.of(context).colorScheme.background,
                      child: ListSeparator(key),
                    ),
                  ),
                  content: Column(
                    children: values!
                        .map((e) => ClientCard(
                              client: e,
                              onTap: () {
                                _toClientDetailsScreen(context, e);
                                FocusScope.of(context).unfocus();
                              },
                              position: values.indexOf(e),
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
