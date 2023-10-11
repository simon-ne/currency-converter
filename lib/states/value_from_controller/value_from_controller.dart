import 'package:flutter/material.dart';

class ValueFromEditingController extends TextEditingController {
  ValueFromEditingController({String? initialValue}) {
    if (initialValue != null) {
      text = initialValue;
    }
  }

  bool _checkMaxTwoDecimals(String input) {
    var splitInput = input.split('.');
    if (splitInput.length == 1) return true;
    if ( splitInput[1].length < 3) return true;
    return false;
  }

  @override
  set value(TextEditingValue newValue) {
    var newTextValue = newValue.text;
    if (newTextValue == '' ||
        (double.tryParse(newTextValue) != null && double.tryParse(newTextValue)! >= 0) && _checkMaxTwoDecimals(newTextValue)) {
      super.value = TextEditingValue(
        text: newValue.text,
        selection: newValue.selection,
        composing: TextRange.empty,
      );
    }
  }
}
