import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

PopScope<dynamic> dialogBody({AppDialogConfiguration? configuration, required AppDialogType dialogType, Widget? child, required BuildContext context, String? message, required bool treeState}) {
  return PopScope(
    canPop: configuration?.dissmisible ?? dialogType.isWidget() ? true : false,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(AppDecoration.radius),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: AppDecoration.padding),
        elevation: 10,
        child:
            (dialogType.isWidget())
                ? child
                : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDecoration.padding, vertical: 60),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Lottie.asset(AppDialog.getDialogAnimatedIcon(dialogType), width: 30, repeat: false),
                          Icon(AppDialogUtilities.getDialogIcon(dialogType), size: 30, color: context.textTheme.bodyMedium?.color),
                          Expanded(child: Text(message ?? AppDialogUtilities.getDialogMessage(dialogType).tr()).wrapPadding(left: AppDecoration.padding)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          // submit button return true
                          child: SizedBox(
                            height: kToolbarHeight,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: dialogType != AppDialogType.warning ? BorderRadius.vertical(bottom: Radius.circular(AppDecoration.radius)) : BorderRadius.only(bottomLeft: Radius.circular(AppDecoration.radius)))),
                                surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
                                backgroundColor: WidgetStateProperty.resolveWith((states) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return Colors.transparent;
                                  } else {
                                    if ((dialogType == AppDialogType.warning) && treeState) {
                                      return context.theme.scaffoldBackgroundColor.increaseLuminance(factor: context.isDark ? .30 : .85);
                                    } else {
                                      return AppDialogUtilities.getDialogColor(context, dialogType);
                                    }
                                  }
                                }),
                                overlayColor: WidgetStateProperty.resolveWith((states) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return context.theme.primaryColor;
                                  } else {
                                    return Colors.transparent;
                                  }
                                }),
                                foregroundColor: WidgetStateProperty.resolveWith((states) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return context.theme.primaryColor.getContrastColor();
                                  } else {
                                    if ((dialogType == AppDialogType.warning) && treeState) {
                                      return context.theme.scaffoldBackgroundColor.increaseLuminance(factor: context.isDark ? .30 : .85).getContrastColor();
                                    } else {
                                      return AppDialogUtilities.getDialogColor(context, dialogType).getContrastColor();
                                    }
                                  }
                                }),
                                textStyle: WidgetStateProperty.resolveWith((states) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: context.theme.primaryColor.getContrastColor());
                                  } else {
                                    return context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppDialogUtilities.getDialogColor(context, dialogType).getContrastColor());
                                  }
                                }),
                              ),
                              child: Center(child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.center, child: Text(configuration?.submitTitle ?? AppDialogUtilities.getDialogSubmitTitle(dialogType).tr()))),
                            ),
                          ),
                        ),
                        if ((dialogType == AppDialogType.warning) && treeState) // treestate button return false
                          Expanded(
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context, false),
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                                  surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
                                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return Colors.transparent;
                                    } else {
                                      return context.theme.scaffoldBackgroundColor.increaseLuminance(factor: context.isDark ? .25 : .90);
                                    }
                                  }),
                                  overlayColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return context.theme.primaryColor;
                                    } else {
                                      return Colors.transparent;
                                    }
                                  }),
                                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return context.theme.primaryColor.getContrastColor();
                                    } else {
                                      return context.theme.scaffoldBackgroundColor.increaseLuminance(factor: context.isDark ? .25 : .90).getContrastColor();
                                    }
                                  }),
                                  textStyle: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: context.theme.primaryColor.getContrastColor());
                                    } else {
                                      return context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: context.theme.scaffoldBackgroundColor.increaseLuminance(factor: context.isDark ? .1 : 0.9).getContrastColor());
                                    }
                                  }),
                                ),
                                child: Center(child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.center, child: Text(configuration?.treeStateTitle ?? "other".tr()))),
                              ),
                            ),
                          ),
                        if (dialogType == AppDialogType.warning) // cancel button return null
                          Expanded(
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context, null),
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(AppDecoration.radius)))),
                                  surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
                                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return Colors.transparent;
                                    } else {
                                      return context.theme.scaffoldBackgroundColor.increaseLuminance(factor: context.isDark ? .20 : 0.95);
                                    }
                                  }),
                                  overlayColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return context.theme.primaryColor;
                                    } else {
                                      return Colors.transparent;
                                    }
                                  }),
                                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return context.theme.primaryColor.getContrastColor();
                                    } else {
                                      return context.theme.scaffoldBackgroundColor.increaseLuminance(factor: context.isDark ? .1 : 0.9).getContrastColor();
                                    }
                                  }),
                                  textStyle: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: context.theme.primaryColor.getContrastColor());
                                    } else {
                                      return context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: context.theme.scaffoldBackgroundColor.increaseLuminance(factor: context.isDark ? .1 : 0.9).getContrastColor());
                                    }
                                  }),
                                ),
                                child: Center(child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.center, child: Text((configuration?.cancelTitle ?? 'cancel').tr()))),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
      ),
    ).wrapPaddingSymetric(vertical: kToolbarHeight),
  );
}
