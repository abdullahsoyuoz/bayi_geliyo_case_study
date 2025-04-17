import 'dart:async';

import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<bool?> sheetBody(BuildContext context, {Widget? child, AppDialogConfiguration? configuration, required AppDialogConfiguration defaultConfiguration, required bool showCloseButton}) async {
  Completer<bool> completer = Completer<bool>();

  await showModalBottomSheet(
    context: context,
    enableDrag: true,
    anchorPoint: const Offset(0, 0),
    isScrollControlled: false,
    elevation: AppDecoration.elevation,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppDecoration.radius))),
    // backgroundColor: backgroundColor ?? context.theme.bottomSheetTheme.backgroundColor,
    backgroundColor: Colors.transparent,
    scrollControlDisabledMaxHeightRatio: (configuration ?? defaultConfiguration).initialSize,
    isDismissible: (configuration ?? defaultConfiguration).dissmisible ? (configuration ?? defaultConfiguration).dissmisible : false,

    builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showCloseButton)
            TextButton(
              onPressed: () {
                if (!completer.isCompleted) {
                  completer.complete(false);
                  Navigator.pop(context);
                }
              },
              child: Text((configuration ?? defaultConfiguration).cancelTitle ?? "click_for_param".tr(args: ["close_icase".tr()])),
            ).wrapPadding(right: AppDecoration.padding),
          Expanded(child: Material(shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppDecoration.radius))), child: SizedBox(width: context.width, child: child?.wrapPaddingSymetric(vertical: AppDecoration.padding)).wrapPaddingSymetric(horizontal: AppDecoration.padding))),
        ],
      );
    },
  ).whenComplete(() {
    if (!completer.isCompleted) {
      completer.complete(true);
    }
  });
  return completer.future;
}
