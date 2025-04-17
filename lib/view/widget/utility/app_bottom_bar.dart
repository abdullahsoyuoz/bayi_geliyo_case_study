import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(child: SizedBox(height: 50 * 1.6, width: context.width, child: child?.wrapPaddingSymetric(horizontal: AppDecoration.padding)).wrapPadding(bottom: context.paddingBottomBase * 0.5));
  }
}
