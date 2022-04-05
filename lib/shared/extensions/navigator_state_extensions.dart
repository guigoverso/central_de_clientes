import 'package:central_de_clientes/shared/page_route_builder/fade_route_builder.dart';
import 'package:flutter/cupertino.dart';

extension NavigatorStateExtension on NavigatorState {
  Future<T?> fadePushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    final pageRouteBuilder = FadeRouteBuilder(routeName, arguments);
    return push<T>(pageRouteBuilder as Route<T>);
  }
}
