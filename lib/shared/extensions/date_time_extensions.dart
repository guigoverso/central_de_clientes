import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get formatGlobalDate => DateFormat('yyyy-MM-dd').format(this);
  String get formatLocalDate => DateFormat('dd/MM/yyyy').format(this);
}