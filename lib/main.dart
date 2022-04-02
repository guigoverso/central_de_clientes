import 'package:central_de_clientes/core/app_theme/app_theme.dart';
import 'package:central_de_clientes/core/injector/app_injector.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/core/service/http_service.dart';
import 'package:central_de_clientes/view/home/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final httpService = HttpService();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: appTheme,
      ),
      home: AppInjector(
        injectors: [
          ClientService(httpService),
        ],
        child: Middleware(),
      ),
    );
  }
}

class Middleware extends StatelessWidget {
  const Middleware({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeView(
      service: AppInjector.get<ClientService>(context)!,
    );
  }
}

