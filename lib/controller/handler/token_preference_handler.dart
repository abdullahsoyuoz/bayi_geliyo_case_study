import 'package:bayi_geliyo_mobile_application/controller/Constant/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenPreferenceHandler {
  static TokenPreferenceHandler? _instance;
  TokenPreferenceHandler._();
  static TokenPreferenceHandler get instance => _instance ??= TokenPreferenceHandler._();

  String bearerToken = '';

  Future<bool?> setToken(String token) async {
    bearerToken = token;
    return await SharedPreferences.getInstance().then((preferences) async {
      return await preferences.setString(AppPreferences.token.name, token);
    });
  }

  Future<String?> getToken() async {
    return await SharedPreferences.getInstance().then((preferences) async {
      String? result = preferences.getString(AppPreferences.token.name);
      if (result != null) {
        return bearerToken = result;
      } else {
        return null;
      }
    });
  }

  Future<void> clearToken() async {
    await SharedPreferences.getInstance().then((preferences) async {
      await preferences.remove(AppPreferences.token.name);
      bearerToken = '';
    });
  }
}
