import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/main_view_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.indexNotifier,
  });

  final ValueNotifier<int> indexNotifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60 * 1.6,
      width: context.width,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor, boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(10), offset: Offset(0, -3), blurRadius: 3, spreadRadius: 3),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: MainViewHandler().items.map((e) {
            // const SizedBox(width: 56);
            bool active = e.index == indexNotifier.value;
            return IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                Provider.of<MainViewHandler>(context, listen: false).setIndex(e.index);
              },
              style: context.theme.iconButtonTheme.style?.copyWith(backgroundColor: WidgetStatePropertyAll(Colors.transparent), fixedSize: WidgetStatePropertyAll(Size.square(65))),
              icon: Column(
                children: [
                  Expanded(
                      child: Image.asset(
                    e.icon,
                    color: active ? context.colors.primary : context.colors.surface.withAlpha(150),
                  ).wrapPadding(bottom: 7)),
                  Text(
                    e.value,
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ).wrapPaddingAll(5),
            );
          }).toList(),
        ).wrapPaddingSymetric(horizontal: AppDecoration.padding * 2).wrapPadding(top: AppDecoration.padding * .5),
      ),
    ).wrapPadding(bottom: context.paddingBottomBase * 0.2);
  }
}
