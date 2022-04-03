import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
}) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
