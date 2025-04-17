import 'package:bayi_geliyo_mobile_application/rest/entity/persistent.dart';

class RefreshTokenRaw extends Persistent {
  RefreshTokenRaw({this.refreshToken});

  String? refreshToken;
  String? password;

  factory RefreshTokenRaw.fromJson(Map<String, dynamic> json) => RefreshTokenRaw(refreshToken: json["refresh_token"]);

  @override
  Map<String, dynamic> toJson() => {"refresh_token": refreshToken};
}

class RegisterRaw extends Persistent {
  RegisterRaw({this.fullName, this.password, this.email, this.phone, this.image, this.refCode});

  String? fullName;
  String? password;
  String? email;
  String? phone;
  String? image;
  String? refCode;

  factory RegisterRaw.fromJson(Map<String, dynamic> json) => RegisterRaw(fullName: json["full_name"], password: json["password"], email: json["email"], phone: json["phone"], image: json["image"], refCode: json["ref_code"]);

  @override
  Map<String, dynamic> toJson() => {"full_name": fullName, "password": password, "email": email, "phone": phone, "image": image, "ref_code": refCode};
}

class LoginRaw extends Persistent {
  LoginRaw({this.identity, this.password});

  String? identity;
  String? password;

  factory LoginRaw.fromJson(Map<String, dynamic> json) => LoginRaw(identity: json["email"], password: json["password"]);

  @override
  Map<String, dynamic> toJson() => {"email": identity, "password": password};
}
