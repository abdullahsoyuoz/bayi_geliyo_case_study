// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';
import 'package:bayi_geliyo_mobile_application/controller/constant/notifiers.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/token_preference_handler.dart';
import 'package:bayi_geliyo_mobile_application/rest/handler/auth/auth_handler.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class AppHandler {
  static AppHandler? _instance;
  AppHandler._();
  static AppHandler get instance => _instance ?? AppHandler._();

  //--------INITIALIZE

  Future<bool> initialize(BuildContext context) async {
    bool result = true;
    if (developmentMode) {
      await AppDialog.banner('Development mode active!', dialogType: AppDialogType.failed);
      await Future.delayed(const Duration(milliseconds: 500));
    }
    AuthHandler.instance.autoLogin(context);
    return result;
  }

  //--------APP CONTROLS

  Future restartApp({bool quickly = false, bool tokenClean = false}) async {
    await AppHandler.instance.clean(tokenClean: tokenClean);
    // restart();
  }

  Future closeApp() async {
    await AppDialog.dialog("exit_app_dialog".tr(), dialogType: AppDialogType.warning, configuration: AppDialogConfiguration(submitTitle: "close".tr())).then((dialog) {
      if (dialog is bool && dialog) {
        exit(0);
      }
    });
  }

  Future<void> clean({bool tokenClean = false}) async {
    if (tokenClean) {
      await TokenPreferenceHandler.instance.clearToken();
    }
  }

  //--------OTHER CONTROLS

  // ignore: unused_element
  int _versionParse(String? value) {
    List<String> parts = (value ?? "").split('.');
    while (parts.length < 3) {
      parts.add('0');
    }
    List<String> paddedParts = parts.map((part) {
      if (parts.indexOf(part) != 0 && part.length > 4) {
        return part.substring(0, 4);
      } else {
        return part.padLeft(4, '0');
      }
    }).toList();
    String formattedVersion = paddedParts.join();
    return int.tryParse(formattedVersion) ?? 0;
  }

  String generateCode() {
    var rnd = Random();
    var characters = 'ABCDEFGHIJKLMNOPQRVWXYZ0123456789';
    var code = '';

    for (var i = 0; i < 6; i++) {
      var index = rnd.nextInt(characters.length);
      code += characters[index];
    }

    return code;
  }

  String turkishCharacterToEnglish(String text) {
    List<String> turkishChars = ['ı', 'ğ', 'İ', 'Ğ', 'ç', 'Ç', 'ş', 'Ş', 'ö', 'Ö', 'ü', 'Ü'];
    List<String> englishChars = ['i', 'g', 'I', 'G', 'c', 'C', 's', 'S', 'o', 'O', 'u', 'U'];

    for (int i = 0; i < turkishChars.length; i++) {
      text = text.replaceAll(turkishChars[i], englishChars[i]);
    }
    return text;
  }

  String getCurrentSymbol(String word) {
    switch (word) {
      case "Türk Lirası":
        return "₺";
      case "Dolar":
        return "\$";
      case "Euro":
        return "€";
      default:
        return "₺";
    }
  }
}
