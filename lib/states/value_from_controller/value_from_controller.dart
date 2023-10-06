import 'package:flutter/material.dart';

class ValueFromEditingController extends TextEditingController {
  ValueFromEditingController({String? initialValue}) {
    if (initialValue != null) {
      text = initialValue;
    }
  }
  
  @override
  set value(TextEditingValue newValue) {
    var newTextValue = newValue.text;
    if (newTextValue == '' || double.tryParse(newTextValue) != null) {
      super.value = TextEditingValue(
        text: newValue.text,
        selection: newValue.selection,
        composing: TextRange.empty,
      );
    }
  }
}
