import 'package:flutter/material.dart';

class AppLanguage {
  String title;
  String icon;
  Locale locale;
  bool isNative;
  AppLanguage({
    required this.title,
    required this.icon,
    required this.locale,
    this.isNative = false,
  });
}

List<AppLanguage> languageList() => [
      AppLanguage(title: 'Türkçe', icon: "assets/flag/tr.png", locale: const Locale('tr', 'TR'), isNative: true),
      AppLanguage(title: 'English', icon: "assets/flag/en.png", locale: const Locale('en', 'US'), isNative: true),
      AppLanguage(title: 'Deutsch', icon: "assets/flag/de.png", locale: const Locale('de', 'DE')),
      /* AppLanguage(title: 'Español', icon: "assets/flag/es.png", locale: const Locale('es', 'ES')),
      AppLanguage(title: 'Français', icon: "assets/flag/fr.png", locale: const Locale('fr', 'FR')),
      AppLanguage(title: 'Italiano', icon: "assets/flag/it.png", locale: const Locale('it', 'IT')),
      AppLanguage(title: 'Português', icon: "assets/flag/pt.png", locale: const Locale('pt', 'PT')),
      AppLanguage(title: 'Ελληνικά', icon: "assets/flag/el.png", locale: const Locale('el', 'GR')),
      AppLanguage(title: 'עברית', icon: "assets/flag/he.png", locale: const Locale('he', 'IL')),
      AppLanguage(title: 'русский', icon: "assets/flag/ru.png", locale: const Locale('ru', 'RU')),
      AppLanguage(title: '中國人', icon: "assets/flag/zh.png", locale: const Locale('zh', 'CN')),
      AppLanguage(title: '日本語', icon: "assets/flag/ja.png", locale: const Locale('ja', 'JP')),
      AppLanguage(title: 'हिन्दी', icon: "assets/flag/hi.png", locale: const Locale('hi', 'IN')),
      AppLanguage(title: 'Afrikaans', icon: "assets/flag/af.png", locale: const Locale('af', 'ZA')),
      AppLanguage(title: 'العربية', icon: "assets/flag/ar.png", locale: const Locale('ar', 'SA')), */
    ];
