// ignore_for_file: library_prefixes

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bayi_geliyo_mobile_application/controller/constant/notifiers.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:image/image.dart' as Img;

class FileOperations {
  static Future<bool> uploadFile(Uint8List? fileUint8List, fileName, String imagePath) async {
    try {
      if (fileUint8List == null) return false;

      Img.Image image = Img.decodeImage(fileUint8List)!;

      final directory = await pathProvider.getApplicationDocumentsDirectory();
      File file2 = File('${directory.path}/app/picture.jpg');
      file2.createSync(recursive: true);
      file2.writeAsBytesSync(encodeJpg(image));
      String base64Image = base64Encode(file2.readAsBytesSync());
      String apiUserBaseUrlEndpoint = "$serverAppBasePath/$imagePath";
      return http.post(Uri.parse(apiUserBaseUrlEndpoint), body: {"image": base64Image, "filename": fileName}).then((res) {
        return res.statusCode == 200;
      }).catchError((err) {
        return false;
      });
    } catch (e) {
      return false;
    }
  }
}
