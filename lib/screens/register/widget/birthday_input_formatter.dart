import 'package:flutter/services.dart';

class BirthdayInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedText = _getFormattedBirthdayString(newValue.text);
    
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _getFormattedBirthdayString(String value) {
    value = _cleanBirthdayString(value);

    if(value.length > 4 && value.length < 7) {
      value = "${value.substring(0, 4)}-${value.substring(4)}";
    } else if(value.length >= 7 && value.length < 11) {
      value = "${value.substring(0, 4)}-${value.substring(4, 6)}-${value.substring(6)}";
    }

    return value;
  }

  String _cleanBirthdayString(String value) {
    return value.replaceAll(RegExp(r'[-\s]'), '');
  }
}