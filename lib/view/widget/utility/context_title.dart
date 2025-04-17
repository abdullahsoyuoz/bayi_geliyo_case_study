import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:flutter/material.dart';

class ContextTitle extends StatelessWidget {
  const ContextTitle(this.title, {super.key, this.divider = true, this.color});
  final String title;
  final bool divider;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: context.textTheme.headlineSmall), if (divider) SizedBox(width: context.width * 0.2, child: Divider(color: color))]).wrapPaddingSymetric(vertical: AppDecoration.padding);
  }
}
