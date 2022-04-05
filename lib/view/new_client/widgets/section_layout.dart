import 'package:flutter/material.dart';

class SectionLayout extends StatelessWidget {
  const SectionLayout({
    Key? key,
    required this.icon,
    required this.title,
    this.textController,
    this.customInput,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final TextEditingController? textController;
  final Widget? customInput;

  @override
  Widget build(BuildContext context) {
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
            customInput ?? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0),
              child: TextField(
                autofocus: true,
                focusNode: FocusNode(),
                controller: textController,
                style: const TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: title,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(.7)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(.7), width: 3.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
