import 'package:flutter/services.dart';

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();

    if (newValue.text.length > oldValue.text.length) {
      if (newTextLength == 5) {
        newText.write(newValue.text.substring(0, usedSubstringIndex = 4) + '-');
        if (newValue.selection.end >= 4) selectionIndex += 1;
      }
      if (newTextLength == 9) {
        newText.write(newValue.text.substring(0, usedSubstringIndex = 8) + '-');
        if (newValue.selection.end >= 8) selectionIndex += 1;
      }
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class ArabicToEnglishTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int selectionIndex = newValue.selection.end;
    var input = newValue.text;
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return new TextEditingValue(
      text: input.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
