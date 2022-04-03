import 'package:central_de_clientes/core/injector/app_injector.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/routes/route_name.dart';
import 'package:central_de_clientes/view/client/client_view.dart';
import 'package:central_de_clientes/view/edit_client/edit_client_view.dart';
import 'package:central_de_clientes/view/home/home_view.dart';
import 'package:flutter/cupertino.dart';

import '../model/client_model.dart';

class AppRoutes {
  final Map<String, WidgetBuilder> routes = {
    RouteName.home: (context) =>
        HomeView(service: AppInjector.get<ClientService>(context)),
    RouteName.client: (context) => ClientView(
          service: AppInjector.get<ClientService>(context),
          client: ModalRoute.of(context)!.settings.arguments as ClientModel,
        ),
    RouteName.editClient: (context) => EditClientView(
      service: AppInjector.get<ClientService>(context),
      client: ModalRoute.of(context)!.settings.arguments as ClientModel,
    ),
  };
}
