import 'package:bayi_geliyo_mobile_application/controller/Constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/string_extensions.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/utility/bounce_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart' as lottie;

Future<void> soonBody(BuildContext context, {bool temporarily = false}) async {
  Color backgroundColor = context.theme.scaffoldBackgroundColor;
  showDialog(
    context: context,
    barrierColor: backgroundColor.withValues(alpha: .9),
    barrierDismissible: true,
    builder: (context) {
      return AppBounce(
        onPressed: () => Navigator.pop(context),
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const StadiumBorder(),
          child: Stack(
            children: [
              Center(child: Image.asset(context.isDark ? AppImage.logo_on_dark.path : AppImage.logo_on_light.path, color: backgroundColor.getContrastColor(), width: context.width * 0.3)),
              /* Center(
                child: lottie.Lottie.asset(AppAnimation.confetti),
              ), */
              /* Center(
                child: RotatedBox(
                  quarterTurns: 1,
                  child: lottie.Lottie.asset(AppAnimation.confetti),
                ),
              ), */
              Align(alignment: Alignment.topCenter, child: Padding(padding: const EdgeInsets.only(top: 40.0), child: Text((temporarily ? "temporarily_of".tr(args: ["\n${"disabled".tr()}"]) : "coming_soon".tr()).addSymbolAfter(symbol: '!'), textAlign: TextAlign.center, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: backgroundColor.getContrastColor())))),
              Align(alignment: Alignment.bottomCenter, child: Padding(padding: const EdgeInsets.only(bottom: 40.0), child: Text("click_for_param".tr(args: ["close_icase".tr()]), textAlign: TextAlign.center, style: context.textTheme.bodyLarge?.copyWith(color: backgroundColor.getContrastColor().withValues(alpha: .25))))),
            ],
          ),
        ),
      );
    },
  );
}
