import 'package:flutter/material.dart';

class AppInjector extends InheritedWidget {
  const AppInjector({
    Key? key,
    required this.injectors,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Object> injectors;

  static AppInjector of(BuildContext context) {
    final AppInjector? result = context.dependOnInheritedWidgetOfExactType<AppInjector>();
    assert(result != null, 'No AppInjector found in context');
    return result!;
  }

  static T get<T>(BuildContext context) {
    final AppInjector result = of(context);
    return result.injectors.whereType<T>().toList().first;
  }

  @override
  bool updateShouldNotify(AppInjector old) {
    return false;
  }
}
