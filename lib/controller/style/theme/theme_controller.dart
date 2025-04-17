import 'package:bayi_geliyo_mobile_application/controller/Constant/preferences.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/theme/light_theme.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;
  ThemeData get theme => _isDark ? appThemeDark() : appThemeLight();

  ThemeController() {
    initialize();
  }

  Future<void> toggleTheme({bool? value}) async {
    if (value != null) {
      _isDark = value;
    } else {
      _isDark = !_isDark;
    }
    await ThemePreferences.setIsDark(_isDark);
    notifyListeners();
  }

  Future<void> initialize() async {
    _isDark = await ThemePreferences.getIsDark();
    notifyListeners();
  }
}

class ThemePreferences {
  static Future<bool> getIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppPreferences.isDark.name) ?? false;
  }

  static Future<void> setIsDark(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppPreferences.isDark.name, value);
  }
}
