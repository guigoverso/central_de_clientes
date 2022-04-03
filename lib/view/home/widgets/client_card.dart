import 'package:central_de_clientes/core/app_theme/app_theme.dart';
import 'package:central_de_clientes/model/client_model.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  const ClientCard(this.client, {Key? key, this.position}) : super(key: key);

  final ClientModel client;
  final int? position;

  Color get circleColor {
    if(position! < colorPallete.length) {
      return colorPallete[position!];
    }
    final colorPosition = position! - ((position! / colorPallete.length).truncate() * colorPallete.length);
    return colorPallete[colorPosition];
  }

  @override
  Widget build(BuildContext context) {
    final _circleColor = position != null ? circleColor : Theme.of(context).primaryColor;
    return ListTile(
      onTap: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.all(4),
      title: Text(client.name, style: const TextStyle(fontSize: 18)),
      leading: CircleAvatar(
        backgroundColor: _circleColor,
        child: Text(client.name[0].toUpperCase(), style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
