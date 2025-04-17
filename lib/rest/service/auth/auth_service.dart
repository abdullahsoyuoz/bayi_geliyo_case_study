import 'package:bayi_geliyo_mobile_application/rest/model/request/post_request.dart';
import 'package:bayi_geliyo_mobile_application/rest/model/response/base_response.dart';
import 'package:bayi_geliyo_mobile_application/rest/raw/auth/auth_raw.dart';
import 'package:bayi_geliyo_mobile_application/rest/service/crud_service.dart';

class AuthService extends CrudService<LoginRaw> {
  static AuthService? _instance;
  AuthService._();
  static AuthService get instance => _instance ?? AuthService._();

  Future<BaseResponse> login(LoginRaw entity) async {
    return await postRequest("$apiURL/login", entityData: entity);
  }
}
