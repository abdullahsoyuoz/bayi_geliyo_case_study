import 'package:bayi_geliyo_mobile_application/controller/Constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialogUtilities {
  static Color getDialogColor(BuildContext context, AppDialogType dialogType) {
    switch (dialogType) {
      case AppDialogType.success:
        return context.colors.primaryContainer;
      case AppDialogType.info:
        return Colors.blueAccent.shade400;
      case AppDialogType.warning:
        return context.colors.secondaryContainer;
      case AppDialogType.failed:
        return context.colors.secondaryContainer;
      default:
        return context.theme.scaffoldBackgroundColor.increaseLuminance(factor: .2);
    }
  }

  static String getDialogMessage(AppDialogType dialogType) {
    switch (dialogType) {
      case AppDialogType.success:
        return 'success';
      case AppDialogType.info:
        return 'do_you_approve';
      case AppDialogType.warning:
        return 'do_you_continue';
      case AppDialogType.failed:
        return 'failed';
      default:
        return 'okay';
    }
  }

  static IconData getDialogIcon(AppDialogType dialogType) {
    switch (dialogType) {
      case AppDialogType.success:
        return CupertinoIcons.check_mark;
      case AppDialogType.info:
        return CupertinoIcons.question;
      case AppDialogType.warning:
        return CupertinoIcons.exclamationmark;
      case AppDialogType.failed:
        return CupertinoIcons.xmark;
      default:
        return CupertinoIcons.check_mark;
    }
  }

  static String getDialogAnimatedIcon(AppDialogType dialogType) {
    switch (dialogType) {
      case AppDialogType.success:
        return AppAnimation.success.path;
      case AppDialogType.info:
        return AppAnimation.success.path;
      case AppDialogType.warning:
        return AppAnimation.failed.path;
      case AppDialogType.failed:
        return AppAnimation.failed.path;
      default:
        return AppAnimation.success.path;
    }
  }

  static String getDialogSubmitTitle(AppDialogType dialogType) {
    switch (dialogType) {
      case AppDialogType.success:
        return 'okay';
      case AppDialogType.info:
        return 'understand';
      case AppDialogType.warning:
        return 'approve';
      case AppDialogType.failed:
        return 'okay';
      default:
        return 'okay';
    }
  }

  static String getRouteName(AppDialogType dialogType) {
    switch (dialogType) {
      case AppDialogType.success:
        return 'success_dialog';
      case AppDialogType.info:
        return 'info_dialog';
      case AppDialogType.warning:
        return 'warning_dialog';
      case AppDialogType.failed:
        return 'failed_dialog';
      default:
        return 'app_dialog';
    }
  }
}
