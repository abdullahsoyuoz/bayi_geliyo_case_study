import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/utilities.dart';
import 'package:flutter/material.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:async';

Future<bool> popupBody(BuildContext context, String? message, AppDialogType dialogType, AppDialogConfiguration? configuration, AppDialogConfiguration defaultConfiguration, bool showAction) async {
  bool result = false;
  Completer<bool> completer = Completer<bool>();

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: false,
      backgroundColor: (dialogType.isWidget() && configuration?.backgroundColor != null) ? configuration?.backgroundColor : AppDialogUtilities.getDialogColor(context, dialogType),
      duration: (configuration ?? defaultConfiguration).dissmisible ? const Duration(days: 1) : (configuration ?? defaultConfiguration).duration,
      content: SizedBox(child: FittedBox(alignment: Alignment.centerLeft, fit: BoxFit.scaleDown, child: Text(message ?? AppDialogUtilities.getDialogMessage(dialogType).tr(), style: context.textTheme.bodyMedium?.copyWith(color: ((dialogType.isWidget() && configuration?.backgroundColor != null) ? configuration?.backgroundColor?.getContrastColor() : AppDialogUtilities.getDialogColor(context, dialogType).getContrastColor()))))),
      action:
          (showAction)
              ? SnackBarAction(
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  result = true;
                  if (!completer.isCompleted) {
                    completer.complete(result); // Sonucu hemen döndür
                  }
                },
                label: (configuration ?? defaultConfiguration).actionTitle ?? 'click'.tr(),
                textColor: ((dialogType.isWidget() && configuration?.backgroundColor != null) ? configuration?.backgroundColor?.getContrastColor() : AppDialogUtilities.getDialogColor(context, dialogType).getContrastColor()),
                backgroundColor: Colors.transparent,
              )
              : null,
    ),
  );
  Future.delayed((configuration ?? defaultConfiguration).duration, () {
    if (!completer.isCompleted) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      completer.complete(result);
    }
  });

  return completer.future;
}
