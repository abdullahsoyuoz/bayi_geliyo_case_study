// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously
import 'package:bayi_geliyo_mobile_application/controller/constant/preferences.dart';
import 'package:bayi_geliyo_mobile_application/controller/constant/routes.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/token_preference_handler.dart';
import 'package:bayi_geliyo_mobile_application/rest/controller/auth/auth_controller.dart';
import 'package:bayi_geliyo_mobile_application/rest/model/response/bad_response.dart';
import 'package:bayi_geliyo_mobile_application/rest/model/response/ok_response.dart';
import 'package:bayi_geliyo_mobile_application/rest/raw/auth/auth_raw.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHandler {
  static AuthHandler? _instance;
  AuthHandler._();
  static AuthHandler get instance => _instance ?? AuthHandler._();

  Future<bool?> login(BuildContext context, String identity, String password, bool rememberMe) async {
    if (identity.isNotEmpty && password.isNotEmpty) {
      try {
        LoginRaw loginRaw = LoginRaw(identity: identity, password: password);
        await Provider.of<AuthController>(context, listen: false).login(context, entity: loginRaw).then((response) async {
          if (response is OkResponse && response.body != null && response.body["token"] != null) {
            if (rememberMe) {
              await TokenPreferenceHandler.instance.setToken(response.body["token"]);
              await SharedPreferences.getInstance().then((preferences) {
                preferences.setString(AppPreferences.identity.name, identity);
                preferences.setString(AppPreferences.password.name, password);
              });
            } else {
              TokenPreferenceHandler.instance.clearToken();
            }
            await loginInitialize(context);
          } else if (response is BadResponse) {
            if (response.body != null && response.body["error"] != null) {
              await AppDialog.dialog(response.body["error"], dialogType: AppDialogType.failed);
              return false;
            } else {
              await AppDialog.dialog(null, dialogType: AppDialogType.failed);
              return false;
            }
          } else {
            await AppDialog.dialog(null, dialogType: AppDialogType.failed);
            return false;
          }
        });
      } on Exception catch (e) {
        debugPrint('catch on AuthHandler.login() $e');
        return null;
      }
      return null;
    } else {
      AppDialog.banner("please_fill_required_areas".tr(), dialogType: AppDialogType.failed);
      return null;
    }
  }

  Future<void> autoLogin(BuildContext context, {bool identityControl = true}) async {
    TokenPreferenceHandler.instance.getToken().then((token) async {
      if (token != null) {
        await SharedPreferences.getInstance().then((preferences) async {
          await login(
            context,
            preferences.getString(AppPreferences.identity.name) ?? "",
            preferences.getString(AppPreferences.password.name) ?? "",
            true,
          ).then(
            (value) async {
              if (value != null && value) {
                await loginInitialize(context);
              } else {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.auth_view, (route) => false);
              }
            },
          );
        });
      } else {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.auth_view, (route) => false);
      }
    });
  }

  Future<void> loginInitialize(BuildContext context) async {
    await Navigator.pushNamedAndRemoveUntil(context, AppRoutes.payment_page, (route) => false);
  }
}
