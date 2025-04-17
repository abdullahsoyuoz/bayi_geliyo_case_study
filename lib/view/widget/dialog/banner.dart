import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:async';

Future<bool> bannerBody(BuildContext context, String? message, AppDialogType dialogType, AppDialogConfiguration? configuration, AppDialogConfiguration defaultConfiguration, bool showAction) async {
  bool result = false;
  Completer<bool> completer = Completer<bool>();

  ScaffoldMessenger.of(context).clearMaterialBanners();
  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      backgroundColor: (dialogType.isWidget() && configuration?.backgroundColor != null) ? configuration?.backgroundColor : AppDialogUtilities.getDialogColor(context, dialogType),
      leading: (configuration ?? defaultConfiguration).leading,
      content: SizedBox(height: kToolbarHeight, child: FittedBox(alignment: Alignment.centerLeft, fit: BoxFit.scaleDown, child: Text(message ?? AppDialogUtilities.getDialogMessage(dialogType).tr(), style: context.textTheme.bodyMedium?.copyWith(color: ((dialogType.isWidget() && configuration?.backgroundColor != null) ? configuration?.backgroundColor : AppDialogUtilities.getDialogColor(context, dialogType))?.getContrastColor())))),
      padding: EdgeInsets.zero,
      actions: [
        if (!showAction) const SizedBox(),
        if (showAction)
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              result = true;
              if (!completer.isCompleted) {
                completer.complete(result); // Sonucu hemen döndür
              }
            },
            style: ButtonStyle(foregroundColor: WidgetStateProperty.all(AppDialogUtilities.getDialogColor(context, dialogType).getContrastColor()), backgroundColor: WidgetStatePropertyAll(AppDialogUtilities.getDialogColor(context, dialogType).increaseLuminance(factor: .5)), overlayColor: WidgetStatePropertyAll(AppDialogUtilities.getDialogColor(context, dialogType).increaseLuminance(factor: .45))),
            child: Text((configuration ?? defaultConfiguration).actionTitle ?? 'click'.tr(), style: context.textTheme.bodyMedium?.copyWith(color: AppDialogUtilities.getDialogColor(context, dialogType).getContrastColor())),
          ),
      ],
    ),
  );
  Future.delayed((configuration ?? defaultConfiguration).duration, () {
    if (!completer.isCompleted) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      completer.complete(result);
    }
  });

  return completer.future;
}
