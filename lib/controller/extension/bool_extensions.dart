import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension BoolExtensions on bool {
  String allowedDeniedTitle() {
    if (this) {
      return "allowed".tr();
    } else {
      return "denied".tr();
    }
  }

  Color getColor(BuildContext context) {
    if (this) {
      return context.colors.primaryContainer;
    } else {
      return context.colors.secondaryContainer;
    }
  }
}

typedef BoolCallback = void Function(bool value);
