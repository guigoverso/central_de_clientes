import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditClientTextField extends StatelessWidget {
  const EditClientTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.inputType,
    this.prefixIcon,
    this.insidePrefixWidget,
    this.removeContainer = false,
    this.readOnly = false,
    this.textColor,
    this.inputFormatters,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType? inputType;
  final IconData? prefixIcon;
  final Widget? insidePrefixWidget;
  final bool removeContainer;
  final bool readOnly;
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final _textColor = textColor ?? theme.secondary;
    const backgroundColor = Colors.white;
    final prefix = prefixIcon != null ? Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Icon(prefixIcon, color: _textColor),
    ) : const SizedBox();

    Widget child = Row(
      children: [
        prefix,
        Expanded(
          child: TextFormField(
            maxLines: 1,
            readOnly: readOnly,
            controller: controller,
            validator: (value) {
              if(value == null || value.isEmpty) {
                return 'Preencha o campo';
              }
              return null;
            },
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            style: TextStyle(color: _textColor),
            decoration: InputDecoration(
              prefix: insidePrefixWidget,
              isDense: true,
              hintText: hintText,
              contentPadding: const EdgeInsets.only(bottom: 4),
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        )
      ],
    );
    
    if(!removeContainer) {
      child = Container(
        color: backgroundColor,
        constraints: const BoxConstraints(maxHeight: 100),
        padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
        child: child,
      );
    }

    return child;
  }
}
