import 'package:central_de_clientes/shared/enum/action_button_type.dart';
import 'package:flutter/material.dart';

class ClientActionButton extends StatelessWidget {
  const ClientActionButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.title,
    required this.type,
  })  :
        super(key: key);

  final String title;
  final ActionButtonType type;
  final void Function(ActionButtonType type) onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final color = theme.secondary;
    return Column(
      children: [
        IconButton(
          onPressed: () => onPressed(type),
          icon: Icon(icon, color: color, size: 32),
        ),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
