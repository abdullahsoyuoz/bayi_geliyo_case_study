// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaginationView extends StatelessWidget {
  const PaginationView({super.key, required this.value, this.increaseCallback, this.decreaseCallback, this.increaseChild, this.decreaseChild, this.innerDecoration, this.outherDecoration, this.size});
  final int value;
  final VoidCallback? increaseCallback;
  final VoidCallback? decreaseCallback;
  final Widget? increaseChild;
  final Widget? decreaseChild;
  final BoxDecoration? innerDecoration;
  final BoxDecoration? outherDecoration;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size != null ? size!.width : context.width * 0.9,
      height: size != null ? size!.height : kToolbarHeight,
      child: DecoratedBox(
        decoration: outherDecoration ?? const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                if (decreaseCallback != null) {
                  decreaseCallback!.call();
                }
                debugPrint('NEXTER LOG :: decrease tap');
              },
              child: DecoratedBox(decoration: innerDecoration ?? const BoxDecoration(), child: Padding(padding: const EdgeInsets.all(3), child: decreaseChild ?? Text("back".tr()))),
            ),
            Expanded(child: const Divider().wrapPaddingSymetric(horizontal: AppDecoration.padding)),
            Center(child: Text("${'page'.tr()} ${(value + 1).toString()}")),
            Expanded(child: const Divider().wrapPaddingSymetric(horizontal: AppDecoration.padding)),
            TextButton(
              onPressed: () {
                if (increaseCallback != null) {
                  increaseCallback!.call();
                }
                debugPrint('NEXTER LOG :: increase tap');
              },
              child: DecoratedBox(decoration: innerDecoration ?? const BoxDecoration(), child: Padding(padding: const EdgeInsets.all(3), child: increaseChild ?? Text("next".tr()))),
            ),
          ],
        ).wrapPaddingAll(8),
      ),
    );
  }
}
