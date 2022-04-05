import 'package:central_de_clientes/controller/new_client_controller.dart';
import 'package:central_de_clientes/shared/functions/show_snack_bar.dart';
import 'package:flutter/material.dart';

class SectionButtonsNavigation extends StatelessWidget {
  const SectionButtonsNavigation({
    Key? key,
    required this.controller,
    required this.pageController,
    required this.sectionLength,
    required this.scaffoldKey,
  }) : super(key: key);

  final NewClientController controller;
  final PageController pageController;
  final int sectionLength;
  final GlobalKey scaffoldKey;

  Future<void> createClient(BuildContext context) async {
    await controller.createClient(
      onSuccess: (client) => Navigator.of(scaffoldKey.currentContext!).pop(client),
      onError: (message) => showSnackBar(context: context, message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    const fadeDuration = Duration(milliseconds: 500);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ValueListenableBuilder<int>(
            valueListenable: controller.index,
            builder: (_, index, child) => AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: index == 0 ? 0 : 1,
              child: child!,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => pageController.previousPage(
                    duration: fadeDuration, curve: Curves.decelerate),
                child: const Text(
                  'Voltar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: controller.toNextSection,
            builder: (context, permission, __) {
              final showNextButton = controller.index.value != 0 || permission;
              final isLastSection = controller.index.value == sectionLength - 1;
              final child = Text(isLastSection ? 'Finalizar' : 'Próximo');
              VoidCallback? onPressed;
              if (isLastSection && permission) {
                onPressed = () async => await createClient(context);
              } else if (permission) {
                onPressed = () async {
                  await pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  FocusScope.of(context).nextFocus();
                };
              }
              return AnimatedOpacity(
                duration: fadeDuration,
                opacity: showNextButton ? 1 : 0,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: child,
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                    fixedSize: const Size.fromWidth(100),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
