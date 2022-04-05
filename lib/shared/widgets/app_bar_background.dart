import 'package:flutter/material.dart';

class AppBackgroundImage extends StatelessWidget {
  const AppBackgroundImage({
    Key? key,
    this.child,
    this.height,
    this.width,
    this.imageOpacity = .3,
  }) : super(key: key);

  final Widget? child;
  final double? height;
  final double? width;
  final double imageOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      height: height,
      width: width,
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
