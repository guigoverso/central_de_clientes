import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/widgets/app_bar_background.dart';
import 'package:flutter/material.dart';

class ClientAppBar extends StatelessWidget {
  const ClientAppBar(this.client, {Key? key, required this.onDelete, this.collapse = true}) : super(key: key);

  final ClientModel client;
  final VoidCallback? onDelete;
  final bool collapse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    const expandedHeight = 220.0;
    final collapsedHeight = collapse ? kToolbarHeight : expandedHeight;
    const circleSize = 100.0;
    final circlePaddingTop = expandedHeight / 2 -
        circleSize / 2 +
        MediaQuery.of(context).viewPadding.top;
    return SliverAppBar(
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      pinned: true,
      forceElevated: false,
      actions: [
        Visibility(
          visible: onDelete != null,
          child: IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
          ),
        ),
      ],
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        final appBarCollapsedHeight =
            MediaQuery.of(context).padding.top + kToolbarHeight;
        final textColor = constraints.maxHeight == appBarCollapsedHeight
            ? Colors.white
            : theme.primary;
        return FlexibleSpaceBar(
          title: Text(
            client.name,
            style: TextStyle(color: textColor),
          ),
          centerTitle: true,
          stretchModes: const [StretchMode.blurBackground],
          background: Align(
            alignment: Alignment.center,
            child: Container(
              color: theme.background,
              child: Stack(
                children: [
                  AppBarBackground(
                    height:expandedHeight / 2 + MediaQuery.of(context).padding.top,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      height: expandedHeight / 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: circlePaddingTop),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: circleSize,
                        height: circleSize,
                        alignment: Alignment.center,
                        child: Text(client.name[0].toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w600)),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.background,
                            width: 6,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
