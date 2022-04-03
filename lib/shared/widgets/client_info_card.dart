import 'package:flutter/material.dart';

class ClientInfoCard extends StatelessWidget {
  const ClientInfoCard({Key? key, required this.title, required this.info})
      : customInfo = null,
        super(key: key);

  const ClientInfoCard.customInfo(
      {Key? key, required this.title, required this.customInfo})
      : info = null,
        super(key: key);

  final String title;
  final Map<IconData, String>? info;
  final List<Widget>? customInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final cardColor = theme.primary;
    const backgroundColor = Colors.white;
    final textColor = theme.secondary;

    final divider = Container(
        child: const Divider(),
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24));

    final childrens = customInfo ??
        info!.entries
            .map((e) => Container(
                  color: backgroundColor,
                  constraints: const BoxConstraints(maxHeight: 100),
                  padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
                  child: Row(
                    children: [
                      Icon(e.key, color: textColor),
                      const SizedBox(width: 16),
                      Text(
                        e.value,
                        style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ))
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: cardColor,
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Text(
            title,
            style: const TextStyle(
                color: backgroundColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        ...childrens.map(
          (e) {
            if (e != childrens.last) {
              return Column(
                children: [
                  e,
                  divider,
                ],
              );
            }
            return e;
          },
        ),
      ],
    );
  }
}
