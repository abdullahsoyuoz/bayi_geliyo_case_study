import 'dart:async';
import 'package:bayi_geliyo_mobile_application/rest/model/response/base_response.dart';
import 'package:bayi_geliyo_mobile_application/rest/model/response/find_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<BaseResponse> deleteRequest(String url, {String? bearerToken}) async {
  Map<String, String> headers = {};
  headers["Content-Type"] = "application/json ; charset=utf-8";
  if (bearerToken != null) {
    headers["Authorization"] = "Bearer $bearerToken";
  }
  debugPrint('DELETE :: $url');
  return http.delete(Uri.parse(url), headers: headers).then((http.Response response) {
    return FindResponse.control(response);
  });
}
