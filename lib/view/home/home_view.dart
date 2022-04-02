import 'package:central_de_clientes/core/service/http_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  String text = '';
  final HttpService service = HttpService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de Clientes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {  
              final result = await service.get('https://forassetapi.herokuapp.com/people');
              print(result);
            },
            child: Text('Pegar dados'),
          ),
          const SizedBox(
            height: 16
          ),
          Text(text)
        ],
      ),
    );
  }
}
