import 'package:flutter/material.dart';

class AppDecoration {
  static double padding = 20;
  static double radius = 8;
  static double elevation = 10;

  static InputDecoration withoutBorder = const InputDecoration(
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
  );
}
