// ignore_for_file: prefer_null_aware_operators

import 'package:bayi_geliyo_mobile_application/rest/entity/persistent.dart';

class AuthenticationJWTData extends Persistent {
  AuthenticationJWTData({this.status, this.message, this.data});

  bool? status;
  String? message;
  AuthenticationJWTEntity? data;

  factory AuthenticationJWTData.fromJson(Map<String, dynamic> json) => AuthenticationJWTData(status: json["status"], message: json["message"], data: json["data"] == null ? null : AuthenticationJWTEntity.fromJson(json["data"]));

  @override
  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data == null ? null : data!.toJson()};
}

class AuthenticationJWTEntity extends Persistent {
  AuthenticationJWTEntity({this.token, this.role, this.restaurantId, this.phoneVerified});

  String? token;
  int? role;
  int? restaurantId;
  int? phoneVerified;

  factory AuthenticationJWTEntity.fromJson(Map<String, dynamic> json) => AuthenticationJWTEntity(token: json["token"], role: json["role"], phoneVerified: json["phone_verified"], restaurantId: json["restaurant_id"]);

  @override
  Map<String, dynamic> toJson() => {"token": token, "role": role, "phone_verified": phoneVerified, "restaurant_id": restaurantId};
}
