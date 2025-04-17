import 'package:bayi_geliyo_mobile_application/controller/style/glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension WidgetExtension on Widget {
  Widget wrapPadding({double? top, double? bottom, double? left, double? right}) => Padding(padding: EdgeInsets.only(top: top ?? 0, bottom: bottom ?? 0, left: left ?? 0, right: right ?? 0), child: this);
  Widget wrapPaddingAll(double distance) => Padding(padding: EdgeInsets.all(distance), child: this);
  Widget wrapPaddingSymetric({double? horizontal, double? vertical}) => Padding(padding: EdgeInsets.symmetric(vertical: vertical ?? 0, horizontal: horizontal ?? 0), child: this);
  Widget decoration(BoxDecoration decoration) => DecoratedBox(decoration: decoration, child: this);
  Widget defaultTextStyle(TextStyle style) => DefaultTextStyle(style: style, child: this);
  Widget fixedSize(Size size) => SizedBox(height: size.height, width: size.width, child: this);
  Widget constrained({double? maxHeight, double? maxWidth, double? minHeight, double? minWidth}) => ConstrainedBox(constraints: BoxConstraints(maxHeight: maxHeight ?? 0, maxWidth: maxWidth ?? 0, minHeight: minHeight ?? 0, minWidth: minWidth ?? 0), child: this);
  Widget disableGlow() => ScrollConfiguration(behavior: WithoutGlow(), child: this);
  Widget iconButton(VoidCallback callback) => IconButton(onPressed: callback, icon: this);
  Widget showArea({Color color = Colors.red}) => ColoredBox(color: color.withValues(alpha: .5), child: this);
  // WIDGET ACTIONS
  Widget onTap(VoidCallback callback) => GestureDetector(onTap: callback, child: this);
  Widget copied(String value, {bool showDialog = false}) => GestureDetector(onTap: () => Clipboard.setData(ClipboardData(text: value)), child: this);
  // todo share
}
