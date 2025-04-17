import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class Surface extends StatelessWidget {
  const Surface({super.key, this.color, this.stops, this.child});
  final Color? color;
  final List<double>? stops;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? const SizedBox(),
        Align(alignment: Alignment.bottomCenter, child: SizedBox.expand(child: ShaderMask(blendMode: BlendMode.src, shaderCallback: (b) => LinearGradient(colors: [color ?? context.theme.scaffoldBackgroundColor, Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter, stops: stops ?? [0, 1]).createShader(b), child: ColoredBox(color: (color ?? context.theme.scaffoldBackgroundColor))))),
      ],
    );
  }
}
