// ignore_for_file: unnecessary_string_interpolations
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/int_extensions.dart';
import 'package:bayi_geliyo_mobile_application/main.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/banner.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/dialog.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/popup.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/sheet.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/soon.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/spinner.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/utilities.dart';
import 'package:flutter/material.dart';

enum AppDialogType { success, warning, info, failed, widget }

extension AppDialogTypeExt on AppDialogType {
  bool isSuccess() => this == AppDialogType.success;
  bool isWarning() => this == AppDialogType.warning;
  bool isInfo() => this == AppDialogType.info;
  bool isFailed() => this == AppDialogType.failed;
  bool isWidget() => this == AppDialogType.widget;
}

class AppDialogConfiguration {
  Duration duration;
  String? actionTitle;
  Widget leading;
  bool dissmisible;
  String? routename;
  String? submitTitle;
  String? cancelTitle;
  String? treeStateTitle;
  Color? backgroundColor;
  Color? barrierColor;
  double initialSize;
  //
  AppDialogConfiguration({this.duration = const Duration(seconds: 1), this.actionTitle, this.leading = const SizedBox(), this.dissmisible = false, this.routename = "dialog", this.submitTitle, this.cancelTitle, this.treeStateTitle, this.backgroundColor, this.barrierColor, this.initialSize = 0.5});
}

AppDialogConfiguration _defaultConfiguration = AppDialogConfiguration();

class AppDialog {
  AppDialog._();

  static BuildContext context = navigatorKey.currentContext!;

  static Future<bool> banner(String? message, {AppDialogType dialogType = AppDialogType.widget, AppDialogConfiguration? configuration, bool showAction = false}) async {
    return await bannerBody(context, message, dialogType, configuration, _defaultConfiguration, showAction);
  }

  static Future<bool> popup(String? message, {AppDialogType dialogType = AppDialogType.widget, AppDialogConfiguration? configuration, bool showAction = false}) async {
    return await popupBody(context, message, dialogType, configuration, _defaultConfiguration, showAction);
  }

  static Future<bool?> sheet(Widget? child, {AppDialogConfiguration? configuration, bool showCloseButton = false}) async {
    return await sheetBody(
      context,
      child: child,
      configuration: configuration?..dissmisible = true,
      defaultConfiguration: _defaultConfiguration
        ..dissmisible = true
        ..initialSize = 0.6,
      showCloseButton: showCloseButton,
    );
  }

  static Future<T> spinner<T>({required Future<T> Function() asyncFunction, bool showDescription = true, bool isPayment = false}) async {
    return await spinnerBody<T>(context, asyncFunction: asyncFunction, showDescription: showDescription, isPayment: isPayment).whenComplete(() async {
      await Future.delayed(300.millisecond());
    });
  }

  static Future<void> soon({bool temporarily = false}) async {
    return await soonBody(context, temporarily: temporarily);
  }

  static Future dialog(String? message, {AppDialogType dialogType = AppDialogType.warning, AppDialogConfiguration? configuration, Widget? child, bool treeState = false}) async {
    return await showDialog(
      context: context,
      barrierColor: context.theme.scaffoldBackgroundColor.increaseLuminance(factor: 0.05).withValues(alpha: 0.9),
      routeSettings: RouteSettings(name: configuration?.routename ?? AppDialogUtilities.getRouteName(dialogType)),
      barrierDismissible: configuration?.dissmisible ?? dialogType.isWidget() ? true : false,
      builder: (context) => dialogBody(configuration: configuration, dialogType: dialogType, child: child, context: context, message: message, treeState: treeState),
    );
  }
}
