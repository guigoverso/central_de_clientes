import 'package:central_de_clientes/model/client_model.dart';
import 'package:flutter/material.dart';

class ClientAppBar extends StatelessWidget {
  const ClientAppBar(this.client, {Key? key}) : super(key: key);

  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    const appBarExpandedHeight = 220.0;
    const circleSize = 100.0;
    final circlePaddingTop = appBarExpandedHeight / 2 - circleSize / 2 + MediaQuery.of(context).viewPadding.top;
    return SliverAppBar(
      expandedHeight: appBarExpandedHeight,
      pinned: true,
      forceElevated: false,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final appBarCollapsedHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
          final textColor = constraints.maxHeight == appBarCollapsedHeight ? Colors.white : theme.primary;
          return FlexibleSpaceBar(
            title: Text(client.name, style: TextStyle(color: textColor),),
            centerTitle: true,
            stretchModes: const [StretchMode.blurBackground],
            background: Align(
              alignment: Alignment.center,
              child: Container(
                color: theme.background,
                child: Stack(
                  children: [
                    Container(
                      height: appBarExpandedHeight / 2 + MediaQuery.of(context).padding.top,
                      color: theme.primary,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Theme.of(context).colorScheme.background,
                        height: appBarExpandedHeight / 2,
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
                          child: Text(client.name[0], style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight:FontWeight.w600)),
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
        }
      ),
    );
  }
}
