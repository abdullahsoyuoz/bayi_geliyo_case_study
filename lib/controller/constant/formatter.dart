import 'dart:convert';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppFormatter {
  static final phone = MaskTextInputFormatter(filter: {"#": RegExp(r'[0-9]')}, mask: '+90 ### ### ## ##', type: MaskAutoCompletionType.lazy);

  static final iban = MaskTextInputFormatter(filter: {"#": RegExp(r'[0-9]')}, mask: 'TR## #### #### #### #### #### ##', type: MaskAutoCompletionType.lazy);

  static final refCode = MaskTextInputFormatter(filter: {"#": RegExp(r'[A-Za-z0-9]+')}, mask: '##-######', type: MaskAutoCompletionType.lazy);

  static final creditCardNumber = MaskTextInputFormatter(
    filter: {"#": RegExp(r'[0-9]')},
    mask: '#### #### #### ####',
    type: MaskAutoCompletionType.lazy,
  );

  static final creditCardCvv = MaskTextInputFormatter(
    filter: {"#": RegExp(r'[0-9]')},
    mask: '###',
    type: MaskAutoCompletionType.lazy,
  );

  static final creditCardExpiredDate = MaskTextInputFormatter(
    filter: {"#": RegExp(r'[0-9]')},
    mask: '## / ##',
    type: MaskAutoCompletionType.lazy,
  );

  static final birthyear = MaskTextInputFormatter(
    filter: {"#": RegExp(r'[0-9]')},
    mask: '####',
    type: MaskAutoCompletionType.lazy,
  );

  static final identityNumber = MaskTextInputFormatter(
    filter: {"#": RegExp(r'[0-9]')},
    mask: '###########',
    type: MaskAutoCompletionType.lazy,
  );
}

void jsonPrint(Map<String, dynamic> json, {String seperetor = ","}) {
  for (var part in jsonEncode(json).split(seperetor)) {
    debugPrint("FFC $part");
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class EmailInputFormatter extends TextInputFormatter {
  final RegExp _emailRegex = RegExp(r"^[a-zA-Z0-9@._\-]+$");

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_emailRegex.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

CurrencyTextInputFormatter currencyFormatter({String symbol = ''}) => CurrencyTextInputFormatter.currency(locale: 'it', decimalDigits: 2, symbol: symbol);
