import 'package:central_de_clientes/controller/edit_client_controller.dart';
import 'package:central_de_clientes/core/service/client_service.dart';
import 'package:central_de_clientes/shared/extensions/date_time_extensions.dart';
import 'package:central_de_clientes/shared/functions/show_snack_bar.dart';
import 'package:central_de_clientes/shared/masks/phone_mask.dart';
import 'package:central_de_clientes/shared/request_status/request_status.dart';
import 'package:central_de_clientes/shared/widgets/client_app_bar.dart';
import 'package:central_de_clientes/shared/widgets/elevated_status_button.dart';
import 'package:central_de_clientes/view/edit_client/widgets/edit_client_text_field.dart';
import 'package:flutter/material.dart';

import '../../model/client_model.dart';
import '../../shared/widgets/client_info_card.dart';

class EditClientView extends StatefulWidget {
  const EditClientView({
    Key? key,
    required this.client,
    required this.service,
  }) : super(key: key);

  final ClientModel client;
  final ClientService service;

  @override
  State<EditClientView> createState() => _EditClientViewState();
}

class _EditClientViewState extends State<EditClientView> {
  late final EditClientController _controller;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = EditClientController(widget.client, widget.service);
    _formKey = GlobalKey<FormState>();
  }

  Future<void> onSave(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await _controller.editClient(
        onError: (message) => showSnackBar(context: context, message: message),
        onSuccess: (client) => Navigator.of(context).pop(client),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final textColor = Theme.of(context).colorScheme;
    const buttonPadding = EdgeInsets.fromLTRB(16, 0, 16, 16);
    final buttonSize = Size(_screenSize.width, 40);
    final buttonSpace = buttonPadding.bottom + buttonSize.height;
    final buttonVisibility =
        MediaQuery.of(context).viewInsets.bottom != 0 ? false : true;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  ClientAppBar(
                    _controller.client,
                    customCircleContent:
                        const Icon(Icons.person, size: 48, color: Colors.white),
                    customTitleBuilder: (context, isCollapsed) => Padding(
                      padding: EdgeInsets.only(
                          right: 16, left: isCollapsed ? 48 : 24),
                      child: EditClientTextField(
                        controller: _controller.nameController,
                        hintText: 'Nome',
                        removeContainer: true,
                        textColor: isCollapsed ? Colors.white : null,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: ValueListenableBuilder<RequestStatus>(
                          valueListenable:
                              _controller.editClientStatus.listenable,
                          builder: (_, status, __) {
                            final readOnly = status == RequestStatus.loading;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClientInfoCard.customInfo(
                                  title: 'Informações de Contato',
                                  customInfo: [
                                    EditClientTextField(
                                      prefixIcon: Icons.call,
                                      hintText: 'Telefone',
                                      controller: _controller.phoneController,
                                      readOnly: readOnly,
                                      insidePrefixWidget: Text('+55 ', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                                      inputType: TextInputType.phone,
                                    ),
                                    EditClientTextField(
                                      prefixIcon: Icons.mail,
                                      hintText: 'e-Mail',
                                      controller: _controller.emailController,
                                      readOnly: readOnly,
                                      inputType: TextInputType.emailAddress,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ClientInfoCard.customInfo(
                                  title: 'Informações Pessoais',
                                  customInfo: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
                                        maximumSize: const Size.fromHeight(100)
                                      ),
                                      onPressed: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          currentDate: _controller.birthAt.value,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                          initialDatePickerMode:
                                          DatePickerMode.year,
                                        );
                                        _controller.updateBirthAt(date);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(Icons.cake, color: textColor.secondary),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: ValueListenableBuilder<DateTime>(
                                              valueListenable: _controller.birthAt,
                                              builder: (_, birthAt, __) => Text(birthAt.formatLocalDate, style: TextStyle(color: textColor.secondary)),
                                            ),
                                          ),
                                          const Icon(Icons.arrow_drop_down_sharp),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: buttonSpace),
                              ],
                            );
                          },
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Visibility(
                  visible: buttonVisibility,
                  child: Padding(
                    padding: buttonPadding,
                    child: ElevatedStatusButton(
                      listener: _controller.editClientStatus,
                      child: const Text('Salvar'),
                      onPressed: () => onSave(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
