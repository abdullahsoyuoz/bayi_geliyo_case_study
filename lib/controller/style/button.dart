import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class AppButtonStyle {
  static ButtonStyle? standart(BuildContext context, {bool enable = true}) {
    return context.theme.filledButtonTheme.style?.copyWith(
      backgroundColor: WidgetStatePropertyAll(enable ? context.colors.primary : context.colors.surface),
      foregroundColor: WidgetStatePropertyAll(enable ? context.colors.primary.getContrastColor() : context.colors.onSurface.withValues(alpha: .3)),
    );
  }

  static ButtonStyle? alternative(BuildContext context, {bool enable = true}) {
    return context.theme.filledButtonTheme.style?.copyWith(
      backgroundColor: WidgetStatePropertyAll(enable ? context.colors.tertiary : context.colors.surface),
      foregroundColor: WidgetStatePropertyAll(enable ? context.colors.tertiary.getContrastColor() : context.colors.onSurface.withValues(alpha: .3)),
    );
  }

  static ButtonStyle? circle(
    BuildContext context, {
    bool enable = true,
    Color? color,
    double? iconSize,
  }) {
    return context.theme.iconButtonTheme.style?.copyWith(
      backgroundColor: WidgetStatePropertyAll(enable ? color ?? context.theme.scaffoldBackgroundColor.withAlpha(50) : context.colors.surface),
      foregroundColor: WidgetStatePropertyAll(enable ? context.theme.scaffoldBackgroundColor : context.colors.onSurface.withValues(alpha: .3)),
      shape: WidgetStatePropertyAll(CircleBorder()),
      iconSize: WidgetStatePropertyAll(iconSize ?? 15),
      fixedSize: WidgetStatePropertyAll(Size.square(iconSize ?? 15)),
    );
  }
}
