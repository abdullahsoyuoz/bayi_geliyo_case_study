 abstract class BaseResponse {
  Map<String, dynamic> get body;
  set body(Map<String, dynamic> value);
  String get message;
  set message(String value);
  int get statusCode;
  set statusCode(int code);
}
