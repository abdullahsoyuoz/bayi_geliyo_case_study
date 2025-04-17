import 'dart:math';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/double_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/int_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/utility/app_absorb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class AppBottomSheet extends StatefulWidget {
  AppBottomSheet({super.key, this.maxSize = 0.65, this.initialSize = 0.175, this.child, this.title, this.color, this.leadingIcon, this.showArrow = true});
  double maxSize;
  double initialSize;
  Widget? child;
  String? title;
  Color? color;
  IconData? leadingIcon;
  bool showArrow;

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> with SingleTickerProviderStateMixin {
  double? minSize;
  DraggableScrollableController draggableScrollableController = DraggableScrollableController();
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, lowerBound: 0, upperBound: widget.initialSize, duration: 300.millisecond(), reverseDuration: 300.millisecond());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    minSize = minSize ?? widget.initialSize;
    ValueNotifier<double> currentSheetPosition = ValueNotifier<double>(0);

    return Material(
      color: widget.color ?? context.theme.scaffoldBackgroundColor.increaseLuminance(),
      shape: context.theme.bottomSheetTheme.shape,
      child: DefaultTextStyle(
        style: context.textTheme.bodyMedium!.copyWith(color: (widget.color ?? context.theme.bottomSheetTheme.backgroundColor as Color).getContrastColor()),
        child: SizedBox(
          width: context.width,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return DraggableScrollableSheet(
                maxChildSize: widget.maxSize,
                minChildSize: animationController.value,
                initialChildSize: animationController.value,
                controller: draggableScrollableController,
                snap: true,
                expand: false,
                snapAnimationDuration: 250.millisecond(),
                snapSizes: [widget.initialSize, widget.maxSize],
                builder: (context, scrollController) {
                  return NotificationListener<DraggableScrollableNotification>(
                    onNotification: (notification) {
                      currentSheetPosition.value = notification.extent.reduceFloat(comingMax: widget.maxSize, comingMin: minSize!);
                      return true;
                    },
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (currentSheetPosition.value == 0) {
                                draggableScrollableController.animateTo(1, duration: 300.millisecond(), curve: Curves.ease);
                              } else {
                                draggableScrollableController.animateTo(0, duration: 300.millisecond(), curve: Curves.ease);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Opacity(opacity: widget.leadingIcon != null ? 1 : 0, child: Icon(widget.leadingIcon ?? FontAwesomeIcons.chevronUp, color: (widget.color != null) ? widget.color!.getContrastColor() : context.theme.iconTheme.color as Color)),
                                Text(widget.title ?? ""),
                                AppAbsorb(
                                  absorb: !widget.showArrow,
                                  transparent: false,
                                  child: ValueListenableBuilder(
                                    valueListenable: currentSheetPosition,
                                    builder: (context, _, __) {
                                      return Transform.rotate(angle: pi * -currentSheetPosition.value, child: Icon(FontAwesomeIcons.chevronUp, color: (widget.color != null) ? widget.color!.getContrastColor() : context.theme.iconTheme.color as Color));
                                    },
                                  ),
                                ),
                              ],
                            ).wrapPaddingSymetric(horizontal: AppDecoration.padding, vertical: AppDecoration.padding),
                          ),
                          widget.child ?? const SizedBox(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
