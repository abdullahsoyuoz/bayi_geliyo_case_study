import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/theme/light_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;
  double get paddingTop => mediaQuery.padding.top + kToolbarHeight + 20;
  double get paddingBottom => mediaQuery.padding.bottom != 0 ? mediaQuery.padding.bottom + 20 : 20;
  double get paddingTopBase => mediaQuery.padding.top;
  double get paddingBottomBase => mediaQuery.padding.bottom != 0 ? mediaQuery.padding.bottom : 20;
  EdgeInsetsGeometry get paddingForTopLevel => EdgeInsets.only(top: paddingTop, bottom: 0, left: 20, right: 20);
  EdgeInsetsGeometry get paddingForList => EdgeInsets.only(top: paddingTop + 30, bottom: paddingBottom * 5, left: 20, right: 20); // +30 for AppBar
  EdgeInsetsGeometry get paddingForListWithoutAppBar => EdgeInsets.only(top: mediaQuery.padding.top * 2, bottom: paddingBottom * 5, left: 20, right: 20); // +30 for AppBar
  double get screenAspectRatio => mediaQuery.size.width / mediaQuery.size.height;
  Size get screenResolution => View.of(this).physicalSize;
  bool get isMobile => !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) && mediaQuery.size.width < 850;
  bool get isTablet => !kIsWeb && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) && mediaQuery.size.width >= 850;
  bool get isWeb => kIsWeb;
  bool get isDark => theme.scaffoldBackgroundColor.isDarkContrast();
  String? get routename => ModalRoute.of(this)!.settings.name;
  List<dynamic>? get arguments => ModalRoute.of(this)!.settings.arguments as List<dynamic>?;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colors {
    if (mounted) {
      return Theme.of(this).colorScheme;
    } else {
      return colorSchemeForLightTheme();
    }
  }
}
