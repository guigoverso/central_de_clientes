
abstract class PhoneMask {

  static String mask(String value) {
    final unmasked = unmask(value);
    return _maskPhone(unmasked);
  }

  static String unmask(String value) => value.replaceAll(RegExp(r'[^0-9]'), '');

  static String _maskPhone(String value, {String? mask}) {
    final _mask = (mask ?? '+55 (##) #####-####').split('');
    final valueLength = value.split('').length;
    int valueIndex = 0;
    String newValue = '';

    for (var char in _mask) {
      var newChar = '';
      if(char == '#') {
        newChar = valueIndex < valueLength ? value[valueIndex] : '';
        valueIndex++;
      } else {
        newChar = char;
      }
      newValue += newChar;
    }
    return newValue;
  }
}