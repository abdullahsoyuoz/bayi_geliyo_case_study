import 'package:bayi_geliyo_mobile_application/rest/model/response/base_response.dart';

class OkResponse implements BaseResponse {
  @override
  late Map<String, dynamic> body;
  @override
  late String message;
  @override
  late int statusCode;
  OkResponse();
}
