import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/theme/theme_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeChangerButton extends StatefulWidget {
  final double? size;
  final bool isExtend;

  const ThemeChangerButton({super.key, this.size}) : isExtend = false;
  const ThemeChangerButton.extend({super.key, this.size}) : isExtend = true;

  @override
  State<ThemeChangerButton> createState() => _ThemeChangerButtonState();
}

class _ThemeChangerButtonState extends State<ThemeChangerButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isExtend) {
      return FilledButton(
        onPressed: () {
          Provider.of<ThemeController>(context, listen: false).toggleTheme();
        },
        style: context.theme.filledButtonTheme.style?.copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
        child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [SizedBox.square(dimension: 40, child: Icon(!context.isDark ? FontAwesomeIcons.solidMoon : FontAwesomeIcons.solidSun)), Text(!context.isDark ? "dark".tr() : "light".tr()).wrapPaddingSymetric(horizontal: 5)]),
      );
    } else {
      return IconButton(
        onPressed: () {
          Provider.of<ThemeController>(context, listen: false).toggleTheme();
        },
        style: context.theme.filledButtonTheme.style?.copyWith(backgroundColor: const WidgetStatePropertyAll(Colors.transparent), padding: const WidgetStatePropertyAll(EdgeInsets.zero), fixedSize: const WidgetStatePropertyAll(Size.square(40)), iconColor: WidgetStatePropertyAll(context.colors.onSurface)),
        icon: Icon(!context.isDark ? FontAwesomeIcons.solidMoon : FontAwesomeIcons.solidSun),
      );
    }
  }
}
