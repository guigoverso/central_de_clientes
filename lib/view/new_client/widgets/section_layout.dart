import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SectionLayout extends StatelessWidget {
  const SectionLayout({
    Key? key,
    required this.icon,
    required this.title,
    this.textController,
    this.customInput,
    this.textInputFormatters,
    this.keyboardType,
    this.insidePrefixWidget,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final TextEditingController? textController;
  final List<TextInputFormatter>? textInputFormatters;
  final TextInputType? keyboardType;
  final Widget? customInput;
  final Widget? insidePrefixWidget;

  @override
  Widget build(BuildContext context) {
    final textFieldBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: Colors.white.withOpacity(.7), width: 3.0),
    );
    final textCapitalization = keyboardType == TextInputType.name ? TextCapitalization.words : TextCapitalization.none;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 100),
            const SizedBox(height: 24),
            customInput ??
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0),
                  child: TextField(
                    autofocus: true,
                    focusNode: FocusNode(),
                    onChanged: (value) => print(value),
                    controller: textController,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.start,
                    inputFormatters: textInputFormatters,
                    keyboardType: keyboardType,
                    textCapitalization: textCapitalization,
                    decoration: InputDecoration(
                      hintText: title,
                      hintStyle: TextStyle(color: Colors.white.withOpacity(.7)),
                      border: textFieldBorder,
                      enabledBorder: textFieldBorder,
                      focusedBorder: textFieldBorder,
                      prefix: insidePrefixWidget,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
