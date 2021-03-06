import 'package:central_de_clientes/core/app_theme/app_theme.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  const ClientCard(
      {Key? key, required this.client, required this.onTap, this.position})
      : super(key: key);

  final ClientModel client;
  final int? position;
  final VoidCallback onTap;

  Color get circleColor {
    if (position! < colorPallete.length) {
      return colorPallete[position!];
    }
    final colorPosition = position! -
        ((position! / colorPallete.length).truncate() * colorPallete.length);
    return colorPallete[colorPosition];
  }

  @override
  Widget build(BuildContext context) {
    final _circleColor =
        position != null ? circleColor : Theme.of(context).primaryColor;
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.all(4),
      title: Text(client.name, style: const TextStyle(fontSize: 18)),
      leading: Hero(
        tag: '${client.name}${client.id}',
        child: CircleAvatar(
          backgroundColor: _circleColor,
          child: DefaultTextStyle(
            style: const TextStyle(),
            child: Text(
              client.name[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
