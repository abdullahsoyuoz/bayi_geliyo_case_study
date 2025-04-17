import 'package:bayi_geliyo_mobile_application/controller/Constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/utility/app_absorb.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/utility/app_logo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// spinnerBody Fonksiyonu
Future<T> spinnerBody<T>(BuildContext context, {required Future<T> Function() asyncFunction, bool showDescription = true, bool isPayment = false}) async {
  dynamic result;
  try {
    await showDialog(
      context: context,
      routeSettings: const RouteSettings(name: "spinner"),
      barrierColor: context.isDark ? Colors.black.withValues(alpha: isPayment ? 1 : .85) : Colors.white.withValues(alpha: isPayment ? 1 : .85),
      builder: (BuildContext dialogContext) {
        return FutureBuilder<T>(
          future: asyncFunction(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                AppDialog.dialog("error".tr(), dialogType: AppDialogType.failed);
                Navigator.of(context, rootNavigator: true).pop();
              } else {
                result = snapshot.data;
                if (context.mounted) {
                  try {
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  } on Exception catch (e) {
                    AppDialog.dialog("${"error".tr()} : $e", dialogType: AppDialogType.failed);
                  }
                }
              }
            }
            return (isPayment) ? AppPaymentSpinner() : AppSpinner(showDescription: showDescription);
          },
        );
      },
    );
  } catch (e) {
    AppDialog.dialog("error".tr(), dialogType: AppDialogType.failed);
  }
  return result;
}

class AppSpinner extends StatelessWidget {
  final bool showDescription;
  const AppSpinner({super.key, this.showDescription = false});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: StatefulBuilder(
        builder: (dialogContext, setState) {
          return SafeArea(
            child: SizedBox.expand(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppAbsorb(
                      absorb: true,
                      transparent: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (showDescription) Text('placeholder_param'.tr(args: ['please_wait'.tr()]), style: dialogContext.textTheme.titleLarge?.copyWith(color: Colors.white)).wrapPadding(bottom: kToolbarHeight * 0.5),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: Hero(tag: "applogo", child: AppLogo())),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (showDescription) AppAbsorb(absorb: true, transparent: false, child: Text('placeholder_param'.tr(args: ['please_wait'.tr()]), style: dialogContext.textTheme.titleLarge?.copyWith(color: context.colors.primary)).wrapPadding(bottom: kToolbarHeight * 0.5)),
                        SizedBox.square(dimension: 25, child: CircularProgressIndicator(color: context.isDark ? Colors.white : Colors.black, backgroundColor: Colors.transparent)),
                        if (showDescription) Text('placeholder_param'.tr(args: ['please_wait'.tr()]), style: dialogContext.textTheme.titleLarge?.copyWith()).wrapPadding(top: kToolbarHeight * 0.5),
                      ],
                    ),
                  ),
                ],
              ).wrapPaddingSymetric(vertical: kToolbarHeight * 0.75),
            ),
          );
        },
      ),
    );
  }
}

class AppPaymentSpinner extends StatelessWidget {
  final bool showDescription;
  const AppPaymentSpinner({super.key, this.showDescription = false});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: StatefulBuilder(
        builder: (dialogContext, setState) {
          return SizedBox.expand(
            child: Material(
              color: context.theme.scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBar(
                    title: Text(
                      "summary_of_param".tr(args: ["payment".tr()]),
                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: context.colors.primary),
                    ),
                    automaticallyImplyLeading: false,
                    backgroundColor: context.theme.scaffoldBackgroundColor,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(AppAnimation.gears.path,
                          width: context.width * 0.75,
                          delegates: LottieDelegates(values: [
                            ValueDelegate.colorFilter(["**"], value: ColorFilter.mode(context.colors.primary, BlendMode.src)),
                          ])),
                      Text(
                        "payment_spinner_description".tr(),
                        style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: context.colors.primary),
                        textAlign: TextAlign.center,
                      ).wrapPadding(bottom: AppDecoration.padding * 0.5),
                      Text("please_wait".tr()),
                    ],
                  )),
                  Image.asset(
                    context.isDark ? AppImage.logotype_on_dark.path : AppImage.logotype_on_light.path,
                    width: context.width * .3,
                  ).wrapPadding(bottom: AppDecoration.padding)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
