import 'package:central_de_clientes/model/client_model.dart';
import 'package:central_de_clientes/shared/widgets/app_bar_background.dart';
import 'package:flutter/material.dart';

class ClientAppBar extends StatelessWidget {
  const ClientAppBar(
    this.client, {
    Key? key,
    this.onDelete,
    this.collapse = true,
    this.customTitleBuilder,
    this.customCircleContent,
  }) : super(key: key);

  final ClientModel client;
  final VoidCallback? onDelete;
  final bool collapse;
  final Widget Function(BuildContext context, bool isCollapsed)? customTitleBuilder;
  final Widget? customCircleContent;

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
        final isCollapsed = constraints.maxHeight == appBarCollapsedHeight;
        final textColor = isCollapsed ? Colors.white : theme.primary;
        return FlexibleSpaceBar(
          title: customTitleBuilder?.call(context, isCollapsed) ??
              Text(
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
                  AppBackgroundImage(
                    height:
                        expandedHeight / 2 + MediaQuery.of(context).padding.top,
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
                      child: Hero(
                        tag: '${client.name}${client.id}',
                        child: Container(
                          width: circleSize,
                          height: circleSize,
                          alignment: Alignment.center,
                          child: DefaultTextStyle(
                            style: const TextStyle(),
                            child: customCircleContent ??
                                Text(client.name[0].toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600)),
                          ),
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
