import 'package:flutter/material.dart';

class ButtonHeightAnimation extends StatefulWidget {
  const ButtonHeightAnimation({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.animationDuration,
  }) : super(key: key);

  final Widget child;
  final Future<void> Function() onPressed;
  final Color? backgroundColor;
  final Duration? animationDuration;

  @override
  State<ButtonHeightAnimation> createState() => _ButtonHeightAnimationState();
}

class _ButtonHeightAnimationState extends State<ButtonHeightAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _buttonSizeAnimation;
  late final Animation<double> _opacityAnimation;

  bool _completedAnimationCallbackExecuted = false;

  final _maxHeight = 1000.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration:
            widget.animationDuration ?? const Duration(milliseconds: 500));
    _buttonSizeAnimation =
        Tween(begin: 56.0, end: _maxHeight).animate(CurvedAnimation(parent: _animationController, curve: Curves.decelerate));
    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.25),
      ),
    );
    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed &&
          !_completedAnimationCallbackExecuted) {
        _completedAnimationCallbackExecuted = true;
        await widget.onPressed();
        _completedAnimationCallbackExecuted = false;
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => Padding(
        padding:
            _animationController.isAnimating || _animationController.isCompleted
                ? EdgeInsets.zero
                : const EdgeInsets.all(8.0),
        child: Material(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Container(
            width: _buttonSizeAnimation.value,
            height: _buttonSizeAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: TextButton(
                child: widget.child,
                onPressed: () {
                  if (_animationController.isDismissed) {
                    _animationController.forward();
                  }
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(
                  _buttonSizeAnimation.value >= _maxHeight * .3 ? 0 : 100),
            ),
          ),
        ),
      ),
    );
  }
}
