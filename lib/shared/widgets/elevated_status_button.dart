import 'package:central_de_clientes/shared/request_status/request_status_listener.dart';
import 'package:flutter/material.dart';

import '../request_status/request_status.dart';

class ElevatedStatusButton extends StatelessWidget {
  const ElevatedStatusButton({
    Key? key,
    required this.listener,
    required this.child,
    required this.onPressed,
    this.buttonSize,
  }) : super(key: key);

  final RequestStatusListener listener;
  final Widget child;
  final VoidCallback onPressed;
  final Size? buttonSize;

  @override
  Widget build(BuildContext context) {
    final _buttonSize =
        buttonSize ?? Size(MediaQuery.of(context).size.width, 40);
    return ValueListenableBuilder<RequestStatus>(
      valueListenable: listener.listenable,
      builder: (_, status, __) => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
        width: listener.isLoading ? _buttonSize.height : _buttonSize.width,
        height: _buttonSize.height,
        child: ElevatedButton(
          onPressed: listener.isLoading ? () {} : onPressed,
          child: listener.isLoading
              ? Container(
                  height: _buttonSize.height,
                  width: _buttonSize.height,
                  padding: const EdgeInsets.all(8),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : child,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            primary: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
    );
  }
}
