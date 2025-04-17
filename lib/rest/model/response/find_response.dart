// ignore_for_file: unnecessary_new, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison

import 'package:bayi_geliyo_mobile_application/rest/model/response/bad_response.dart';
import 'package:bayi_geliyo_mobile_application/rest/model/response/base_response.dart';
import 'package:bayi_geliyo_mobile_application/rest/model/response/http_status_family.dart';
import 'package:bayi_geliyo_mobile_application/rest/model/response/ok_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FindResponse {
  static BaseResponse control(http.Response response) {
    int statusCode = response.statusCode;
    Map<String, dynamic>? _jsonMap;
    if (response.body != null && response.body.isNotEmpty) {
      _jsonMap = json.decode(utf8.decode(response.bodyBytes));
    }
    String message = "";
    if (statusCode >= 100 && statusCode < 200) {
      message = HttpStatusFamily.INFORMATIONAL.toString();
    } else if (statusCode >= 200 && statusCode < 300) {
      message = HttpStatusFamily.SUCCESSFUL.toString();
    } else if (statusCode >= 300 && statusCode < 400) {
      message = HttpStatusFamily.REDIRECTION.toString();
    } else if (statusCode >= 400 && statusCode < 500) {
      message = HttpStatusFamily.CLIENT_ERROR.toString();
    } else if (statusCode >= 500 && statusCode < 600) {
      message = HttpStatusFamily.SERVER_ERROR.toString();
    } else {
      message = HttpStatusFamily.OTHER.toString();
    }

    if (statusCode < 200 || statusCode >= 400 || json == null || (response.request!.method == "GET" && _jsonMap!.containsKey("page") && _jsonMap["page"]["totalElements"] < 1)) {
      BaseResponse responseBad = new BadResponse();
      if (_jsonMap != null && _jsonMap.isNotEmpty) {
        debugPrint(_jsonMap.toString());
        responseBad.body = _jsonMap;
      }
      responseBad.message = message;
      responseBad.statusCode = response.statusCode;
      return responseBad;
    } else {
      OkResponse responseOk = new OkResponse();
      if (_jsonMap != null && _jsonMap.isNotEmpty) {
        responseOk.body = _jsonMap;
      }
      responseOk.message = message;
      responseOk.statusCode = response.statusCode;
      return responseOk;
    }
  }
}
