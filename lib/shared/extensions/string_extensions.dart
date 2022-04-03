import 'package:intl/intl.dart';

extension StringExtensions on String {
  Uri get toUri => Uri.parse(this);
  DateTime get parseGlobalDate => DateFormat('yyyy-MM-dd').parse(this);
  DateTime get parseLocalDate => DateFormat('yyyy-MM-dd').parse(this);
}