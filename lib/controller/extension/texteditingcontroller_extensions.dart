import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController {
  bool compare(TextEditingController value) {
    if (text.isEmpty || value.text.isEmpty) {
      return false;
    }
    return text.compareTo(value.text) == 0;
  }
}
