import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class FadeRouteBuilder extends PageRouteBuilder {
  FadeRouteBuilder(String routeName, Object? arguments)
      : super(
          settings: RouteSettings(name: routeName, arguments: arguments),
          pageBuilder: (context, animation, secondaryAnimation) =>
              AppRoutes().routes[routeName]!(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.ease;

            var tween = Tween<double>(begin: begin, end: end)
                .chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
}
