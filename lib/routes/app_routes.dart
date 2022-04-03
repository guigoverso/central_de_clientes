import 'package:central_de_clientes/core/injector/app_injector.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/routes/route_name.dart';
import 'package:central_de_clientes/view/home/home_view.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  final Map<String, WidgetBuilder> routes = {
    RouteName.home: (context) => HomeView(service: AppInjector.get<ClientService>(context)),
  };
}