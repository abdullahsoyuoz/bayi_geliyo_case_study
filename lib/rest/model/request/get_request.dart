import 'dart:async';
import 'package:bayi_geliyo_mobile_application/rest/model/response/base_response.dart';
import 'package:bayi_geliyo_mobile_application/rest/model/response/find_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<BaseResponse> getRequest(String url, {String? bearerToken, bool gateWayStatus = false}) async {
  Map<String, String> headers = {};
  headers["Content-Type"] = "application/json ; charset=utf-8";
  if (bearerToken != null) {
    if (gateWayStatus) {
      headers["AuthorizationKey"] = "RGlnaXRhbEdhdGU/P1NpbmNhcFRla1Njb290ZXJfV2Vtb3NpczIwMjQrKz8/";
    } else {
      headers["Authorization"] = "Bearer $bearerToken";
    }
  }
  debugPrint('GET :: $url || TOKEN :: boşMu ? ${(bearerToken == null || bearerToken.isEmpty || bearerToken == '')} - ${DateFormat('HH:mm:ss').format(DateTime.now())}');
  return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
    return FindResponse.control(response);
  });
}

Future<BaseResponse> telegramGetRequest(String url, {String? chatId, String? message}) async {
  final Map<String, String> queryParams = {'chat_id': chatId ?? '', 'text': message ?? ''};

  final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

  return http.get(uri).then((http.Response response) {
    return FindResponse.control(response);
  });
}

Future<BaseResponse> getRequestBody(String url, {String? bearerToken}) async {
  Map<String, String> headers = {};
  headers["Content-Type"] = "application/json ; charset=utf-8";
  if (bearerToken != null) {
    headers["Authorization"] = "Bearer $bearerToken";
  }

  return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
    return FindResponse.control(response);
  });
}

Future<BaseResponse> getRequestMobiliz(String url) async {
  Map<String, String> headers = {};
  headers["Content-Type"] = "application/json ; charset=utf-8";
  headers["Mobiliz-Token"] = "ed7c5b9503379a022146ebad9c7d19cb21026de18b262b2256a3d11fdd3eb079";

  return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
    return FindResponse.control(response);
  });
}
