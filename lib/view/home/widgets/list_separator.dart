import 'package:flutter/material.dart';

class ListSeparator extends StatelessWidget {
  const ListSeparator(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    const lineHeight = 1.5;
    const color = Colors.grey;

    return Row(
      children: [
        Container(
          height: lineHeight,
          width: 16,
          color: color,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(title.toUpperCase(), style: const TextStyle(color: color, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Container(
            height: lineHeight,
            width: double.infinity,
            color: color,
          ),
        ),
      ],
    );
  }
}
