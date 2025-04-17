import 'dart:ui';

import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
    this.leadingIcon,
  });
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final double? scrolledUnderElevation;
  final ScrollNotificationPredicate notificationPredicate;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool forceMaterialTransparency;
  final Clip? clipBehavior;
  final dynamic leadingIcon;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.compose(inner: ImageFilter.blur(sigmaX: 50, sigmaY: 50), outer: ColorFilter.mode(context.theme.appBarTheme.backgroundColor?.withValues(alpha: .9) ?? Colors.transparent, BlendMode.darken)),
          child: AppBar(
            key: key,
            title: title,
            centerTitle: centerTitle,
            backgroundColor: backgroundColor ?? Colors.transparent,
            toolbarHeight: 80,
            actions: actions,
            actionsIconTheme: actionsIconTheme,
            automaticallyImplyLeading: false,
            bottom: bottom,
            bottomOpacity: bottomOpacity,
            clipBehavior: clipBehavior,
            elevation: elevation,
            excludeHeaderSemantics: excludeHeaderSemantics,
            flexibleSpace: flexibleSpace,
            forceMaterialTransparency: forceMaterialTransparency,
            foregroundColor: foregroundColor,
            iconTheme: iconTheme,
            leadingWidth: 80,
            notificationPredicate: notificationPredicate,
            primary: primary,
            scrolledUnderElevation: scrolledUnderElevation,
            shadowColor: shadowColor,
            shape: shape,
            surfaceTintColor: surfaceTintColor,
            systemOverlayStyle: systemOverlayStyle,
            titleSpacing: titleSpacing,
            titleTextStyle: titleTextStyle,
            toolbarOpacity: toolbarOpacity,
            toolbarTextStyle: toolbarTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class AppbarBackButton extends StatefulWidget {
  const AppbarBackButton({super.key});

  @override
  State<AppbarBackButton> createState() => _AppbarBackButtonState();
}

class _AppbarBackButtonState extends State<AppbarBackButton> {
  @override
  Widget build(BuildContext context) {
    // BU WIDGET'ı affettim.
    return Center(child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesomeIcons.chevronLeft, size: 25).wrapPaddingAll(5)));
  }
}
