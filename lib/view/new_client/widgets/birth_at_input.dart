import 'package:flutter/material.dart';
import 'package:central_de_clientes/shared/extensions/date_time_extensions.dart';

class BirthAtInput extends StatelessWidget {
  const BirthAtInput(this.birthAtListenable, {Key? key}) : super(key: key);

  final ValueNotifier<DateTime?> birthAtListenable;

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          currentDate: birthAtListenable.value,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          initialDatePickerMode: DatePickerMode.year,
        );
        birthAtListenable.value = date;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Container(
          child: ValueListenableBuilder<DateTime?>(
            valueListenable: birthAtListenable,
            builder: (context, birthAt, _) {
              return Text(
                birthAt?.formatLocalDate ?? 'Data de nascimento',
                style: const TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              );
            },
          ),
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 3,
                color: Colors.white.withOpacity(.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
