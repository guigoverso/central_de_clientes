import 'package:central_de_clientes/shared/request_status/request_status_listener.dart';
import 'package:flutter/material.dart';

import 'request_status.dart';

class RequestStatusBuilder<T> extends StatefulWidget {
  const RequestStatusBuilder({
    Key? key,
    required this.listener,
    required this.onCompleted,
    this.defaultWidget,
    this.onLoading,
    this.onError,
    this.animateTransition = true,
  }) : super(key: key);

  final RequestStatusListener listener;
  final Widget Function(BuildContext context, T? data) onCompleted;
  final WidgetBuilder? defaultWidget;
  final WidgetBuilder? onLoading;
  final Widget Function(BuildContext context, String message)? onError;
  final bool animateTransition;

  @override
  State<RequestStatusBuilder<T>> createState() =>
      _RequestStatusBuilderState<T>();
}

class _RequestStatusBuilderState<T> extends State<RequestStatusBuilder<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _opacityReverse;

  Widget? oldChild;
  RequestStatus? oldStatus;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _opacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _opacityReverse = Tween(begin: 1.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.listener.notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RequestStatus>(
      valueListenable: widget.listener.notifier,
      builder: (_, status, __) {
        Widget child;
        switch (status) {
          case RequestStatus.loading:
            child = widget.onLoading?.call(context) ??
                const Center(
                  child: CircularProgressIndicator(),
                );
            break;
          case RequestStatus.completed:
            child = widget.onCompleted(context, widget.listener.data as T?);
            break;
          case RequestStatus.error:
            child =
                widget.onError?.call(context, widget.listener.errorMessage) ??
                    Text(
                      widget.listener.errorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    );
            break;
          case RequestStatus.none:
          default:
            child = widget.defaultWidget?.call(context) ?? const SizedBox();
        }

        if (oldChild == null) {
          oldChild = child;
          oldStatus = status;
          return child;
        }

        if(oldStatus == status) {
          return child;
        }

        final stackChildrens = [
          FadeTransition(
            opacity: _opacityReverse,
            child: oldChild,
          ),
          FadeTransition(
            opacity: _opacityAnimation,
            child: child,
          ),
        ];

        oldChild = child;
        oldStatus = status;

        if(_animationController.isCompleted) {
          _animationController.reset();
        }
        _animationController.forward();

        return Stack(children: stackChildrens);

      },
    );
  }
}
