import 'package:flutter/material.dart';

class NewClientView extends StatelessWidget {
  const NewClientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Text('Sou um texto')
      ),
    );
  }
}
