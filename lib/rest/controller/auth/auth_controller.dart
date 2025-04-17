// ignore_for_file: unnecessary_null_comparison, unnecessary_getters_setters
import 'package:bayi_geliyo_mobile_application/rest/model/response/base_response.dart';
import 'package:bayi_geliyo_mobile_application/rest/raw/auth/auth_raw.dart';
import 'package:bayi_geliyo_mobile_application/rest/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  bool exceptedAction = false;

  Future<BaseResponse?> login(BuildContext context, {required LoginRaw entity}) async {
    BaseResponse? response;
    exceptedAction = true;
    try {
      response = await AuthService.instance.login(entity);
    } catch (e) {
      debugPrint('catch on AuthController.login() $e');
    }
    exceptedAction = false;
    notifyListeners();
    return response;
  }
}
