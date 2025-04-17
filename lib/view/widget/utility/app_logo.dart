import 'package:bayi_geliyo_mobile_application/controller/constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double? size;
  const AppLogo({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(context.isDark ? AppImage.logo_on_dark.path : AppImage.logo_on_light.path, width: size ?? context.width * 0.3, height: size ?? context.width * 0.3));
  }
}
