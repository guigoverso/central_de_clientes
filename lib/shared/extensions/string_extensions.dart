extension StringExtensions on String {
  Uri get toUri => Uri.parse(this);
}