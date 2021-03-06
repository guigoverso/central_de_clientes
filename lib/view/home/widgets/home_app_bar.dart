import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key, required this.totalClients}) : super(key: key);

  final ValueNotifier<int> totalClients;

  @override
  Widget build(BuildContext context) {
    const bottomBorderRadius = 6.0;
    const borderRadius = BorderRadius.only(
    bottomLeft: Radius.circular(bottomBorderRadius),
    bottomRight: Radius.circular(bottomBorderRadius),
    );
    return Material(
      elevation: 2,
      shape: const RoundedRectangleBorder(borderRadius: borderRadius),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: borderRadius,
          image: const DecorationImage(
            image: AssetImage('assets/images/home_appbar_wallpaper.jpg'),
            fit: BoxFit.cover,
            opacity: .5
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: preferredSize.height,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Central de Clientes',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder(
                valueListenable: totalClients,
                builder: (context, totalClients, _) {
                  return Text('Total de Clientes: $totalClients');
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}
