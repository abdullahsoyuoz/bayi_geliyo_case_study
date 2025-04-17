import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssetLoaderHandler {
  static AssetLoaderHandler? _instance;
  AssetLoaderHandler._();
  static AssetLoaderHandler get instance => _instance ??= AssetLoaderHandler._();

  Widget loadingBuilder(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress != null) {
      double? loadRate = loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!;
      return AspectRatio(aspectRatio: 1, child: Stack(children: [Opacity(opacity: loadRate, child: Center(child: Icon(FontAwesomeIcons.solidFile, size: context.width * 0.3, color: context.colors.primary))), Center(child: CircularProgressIndicator(value: loadRate, color: context.colors.primary))]));
    } else {
      return child;
    }
  }

  Widget errorBuilder(BuildContext context, Object error, StackTrace? stackTrace) {
    return AspectRatio(aspectRatio: 1, child: Center(child: Icon(FontAwesomeIcons.fileCircleExclamation, size: context.width * 0.3, color: context.colors.primary)));
  }
}
