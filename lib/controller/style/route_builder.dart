import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/int_extensions.dart';
import 'package:bayi_geliyo_mobile_application/view/custom/curves.dart';
import 'package:flutter/material.dart';

Route appRouteBuilder(BuildContext context, Widget routePage, {RouteSettings? routeSettings, Color? barrierColor, Duration? transitionDuration, Duration? reverseTransitionDuration}) {
  return PageRouteBuilder(
    transitionDuration: transitionDuration ?? 500.millisecond(),
    reverseTransitionDuration: reverseTransitionDuration ?? 500.millisecond(),
    barrierColor: barrierColor ?? context.theme.scaffoldBackgroundColor,
    barrierDismissible: false,
    settings: routeSettings,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
      return routePage;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {
      return FadeTransition(opacity: CurvedAnimation(parent: animation, curve: AppCurves.overshoot()), child: child);
    },
  );
}
