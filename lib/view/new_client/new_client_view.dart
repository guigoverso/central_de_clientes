
import 'package:central_de_clientes/controller/new_client_controller.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/shared/request_status/request_status_builder.dart';
import 'package:central_de_clientes/shared/widgets/app_bar_background.dart';
import 'package:central_de_clientes/view/new_client/widgets/birth_at_input.dart';
import 'package:central_de_clientes/view/new_client/widgets/section_buttons_navigation.dart';
import 'package:central_de_clientes/view/new_client/widgets/section_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class NewClientView extends StatefulWidget {
  const NewClientView(this.service, {Key? key}) : super(key: key);

  final ClientService service;

  @override
  State<NewClientView> createState() => _NewClientViewState();
}

class _NewClientViewState extends State<NewClientView> {
  late final NewClientController _controller;
  late final PageController _pageController;
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _controller = NewClientController(widget.service);
    _pageController = PageController(initialPage: _controller.index.value);
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      SectionLayout(
        icon: Icons.person,
        title: 'Nome',
        textController: _controller.nameTextController,
        keyboardType: TextInputType.name,
      ),
      SectionLayout(
        icon: Icons.call,
        title: 'Telefone',
        textController: _controller.phoneNumberTextController,
        textInputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.phone,
        insidePrefixWidget: const Text('+55 ', style: TextStyle(color: Colors.white)),
      ),
      SectionLayout(
        icon: Icons.email,
        title: 'E-mail',
        textController: _controller.emailTextController,
        keyboardType: TextInputType.emailAddress,
      ),
      SectionLayout(
        icon: Icons.cake,
        title: 'Data de nascimento',
        customInput: BirthAtInput(_controller.birthAtListenable),
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title:
            const Text('Novo Cliente', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: AppBackgroundImage(
        imageOpacity: .3,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: RequestStatusBuilder(
            animateTransition: false,
            listener: _controller.createClienteStatus,
            onLoading: (context) {
              FocusScope.of(context).unfocus();
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            },
            onCompleted: (context, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (index) => _controller.index.value = index,
                    children: sections,
                  ),
                ),
                SectionButtonsNavigation(
                  controller: _controller,
                  pageController: _pageController,
                  sectionLength: sections.length,
                  scaffoldKey: _scaffoldKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
