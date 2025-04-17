// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'package:bayi_geliyo_mobile_application/rest/model/response/base_response.dart';
import 'package:bayi_geliyo_mobile_application/rest/model/response/find_response.dart';
import 'package:http/http.dart' as http;

Future<BaseResponse> patchRequest(String url, {dynamic entityData, String? bearerToken}) async {
  Map<String, String> headers = {};
  headers["Content-Type"] = "application/json";
  if (bearerToken != null) {
    headers["Authorization"] = "Bearer $bearerToken";
  }

  Map<String, dynamic> _json = entityData.toJson();
  String encoded = json.encode(_json);
  return http.patch(Uri.parse(url), headers: headers, body: encoded).then((http.Response response) {
    return FindResponse.control(response);
  });
}
