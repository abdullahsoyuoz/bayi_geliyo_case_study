import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/double_extensions.dart';
import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  int get red255 => (r * 255).round();
  int get green255 => (g * 255).round();
  int get blue255 => (b * 255).round();

  Color mix({Color mixing = Colors.white, double rate = 0.5}) => Color.lerp(this, mixing, rate)!;

  bool isDarkContrast() => ThemeData.estimateBrightnessForColor(this) == Brightness.dark;

  bool isLightContrast() => ThemeData.estimateBrightnessForColor(this) == Brightness.light;

  Color getContrastColor() => isDarkContrast() ? Colors.white : Colors.black;

  bool contrastCheck(Color targetColor, {double factor = 0.5}) => (luminance - targetColor.luminance).abs() >= factor;

  double get luminance => ((0.299 * red255 + 0.587 * green255 + 0.114 * blue255) / 255).toDoubleAsFixed();

  Color increaseLuminance({double factor = .6}) {
    final currentLuminance = luminance;
    final delta = (isDarkContrast() ? factor : 1 - factor) - currentLuminance;
    final newLuminance = (currentLuminance + delta).clamp(0.0, 1.0);
    return HSLColor.fromColor(this).withLightness(newLuminance).toColor();
  }

  Color increaseSaturation({double factor = 0.6}) {
    final hslColor = HSLColor.fromColor(this);
    final newSaturation = (hslColor.saturation + toARGB32()).clamp(0.0, 1.0);
    return hslColor.withSaturation(newSaturation).toColor();
  }

  Color complementaryColor() {
    final hslColor = HSLColor.fromColor(this);
    final complementaryHue = (hslColor.hue + 180.0) % 360.0;
    return HSLColor.fromAHSL(1.0, complementaryHue, hslColor.saturation, hslColor.lightness).toColor();
  }

  Color rotateColor(double angleInDegrees) {
    final hslColor = HSLColor.fromColor(this);
    final newHue = (hslColor.hue + angleInDegrees) % 360.0;
    return HSLColor.fromAHSL(1.0, newHue, hslColor.saturation, hslColor.lightness).toColor();
  }

  Color getAlternate(BuildContext context, Color alternate, {Color? target}) {
    return contrastCheck(target ?? context.theme.scaffoldBackgroundColor) ? this : alternate;
  }

  // COLOR EFFECT

  Color toPastel({double factor = .75}) {
    final red = (red255 * factor + 255 * (1.0 - factor)).toInt();
    final green = (green255 * factor + 255 * (1.0 - factor)).toInt();
    final blue = (blue255 * factor + 255 * (1.0 - factor)).toInt();
    return Color.fromARGB(255, red, green, blue);
  }

  Color toNeon({double factor = .25}) {
    final red = (red255 + 255 * factor).clamp(0, 255).toInt();
    final green = (green255 + 255 * factor).clamp(0, 255).toInt();
    final blue = (blue255 + 255 * factor).clamp(0, 255).toInt();
    return Color.fromARGB(255, red, green, blue);
  }

  Color toWarm({double factor = 0.1}) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withHue((hsl.hue - 10 * factor) % 360).toColor();
  }

  Color toCool({double factor = 0.1}) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withHue((hsl.hue + 10 * factor) % 360).toColor();
  }

  Color toFrosted({double factor = .5}) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withSaturation((hsl.saturation * factor).clamp(0.0, 1.0)).withLightness((hsl.lightness + 0.1).clamp(0.0, 1.0)).toColor();
  }

  Color toMidnight() {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness * 0.4).clamp(0.0, 1.0)).withSaturation((hsl.saturation * 0.7).clamp(0.0, 1.0)).toColor();
  }

  Color toSunlight({double factor = 0.2}) {
    return mix(mixing: Colors.yellow, rate: factor);
  }

  Color toDesaturate({double factor = 0.3}) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withSaturation((hsl.saturation * (1 - factor)).clamp(0.0, 1.0)).toColor();
  }

  Color toBoostContrast({double factor = 1.2}) {
    final hsl = HSLColor.fromColor(this);
    final newLightness = hsl.lightness < 0.5 ? (hsl.lightness / factor) : (hsl.lightness * factor);
    return hsl.withLightness(newLightness.clamp(0.0, 1.0)).toColor();
  }
}
