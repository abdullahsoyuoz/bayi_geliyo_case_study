import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:flutter/material.dart';

enum BorderType { enable, focused }

class AppInputDecoration {
  static InputBorder underlineBorder(BuildContext context, BorderType type) {
    switch (type) {
      case BorderType.enable:
        return UnderlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: BorderSide(color: context.theme.scaffoldBackgroundColor.getContrastColor().withValues(alpha: .25), width: 1));
      case BorderType.focused:
        return UnderlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: BorderSide(color: context.theme.scaffoldBackgroundColor.getContrastColor().withValues(alpha: .5), width: 2));
    }
  }

  static InputBorder outlineBorder(BuildContext context, BorderType type) {
    switch (type) {
      case BorderType.enable:
        return OutlineInputBorder(borderRadius: BorderRadius.circular(AppDecoration.radius), borderSide: BorderSide(color: context.theme.scaffoldBackgroundColor.getContrastColor().withValues(alpha: .25), width: 1));
      case BorderType.focused:
        return OutlineInputBorder(borderRadius: BorderRadius.circular(AppDecoration.radius), borderSide: BorderSide(color: context.theme.scaffoldBackgroundColor.getContrastColor().withValues(alpha: .5), width: 2));
    }
  }

  static InputBorder noneBorder() {
    return InputBorder.none;
  }
}
