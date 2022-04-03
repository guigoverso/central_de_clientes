import 'package:flutter/material.dart';

class AppBarBackground extends StatelessWidget {
  const AppBarBackground({
    Key? key,
    this.child,
    this.height,
    this.imageOpacity = .3,
  }) : super(key: key);

  final Widget? child;
  final double? height;
  final double imageOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        image: DecorationImage(
            image: const AssetImage('assets/images/home_appbar_wallpaper.jpg'),
            fit: BoxFit.cover,
            opacity: imageOpacity),
      ),
    );
  }
}
