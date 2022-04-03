import 'package:central_de_clientes/core/app_theme/app_theme.dart';
import 'package:central_de_clientes/core/injector/app_injector.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/core/service/http_service.dart';
import 'package:central_de_clientes/routes/route_name.dart';
import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final httpService = HttpService();
    final appRoutes = AppRoutes();

    return AppInjector(
      injectors: [
        ClientService(httpService),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: appTheme,
        ),
        initialRoute: RouteName.home,
        routes: appRoutes.routes,
      ),
    );
  }
}

