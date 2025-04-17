import 'package:bayi_geliyo_mobile_application/controller/constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/colors.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDarkColorBase {
  Color primary() => primaryColorOnDark();
  Color secondary() => const Color(0xffFF9500);
  Color accent() => AppColors.blueW200;
  Color card() => const Color(0xFF0073B3);
  Color foreground() => Colors.white;
  Color background() => const Color(0xFF005681);
}

ThemeData appThemeDark() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  return ThemeData(
    useMaterial3: true,
    // ----------------------------------- COLOR
    colorScheme: colorSchemeForDark(),
    scaffoldBackgroundColor: AppDarkColorBase().background(),
    cardColor: colorSchemeForDark().surface,
    dividerColor: colorSchemeForDark().scrim,
    canvasColor: colorSchemeForDark().surface,
    iconTheme: const IconThemeData(color: Colors.white),
    dividerTheme: DividerThemeData(color: colorSchemeForDark().surface.increaseLuminance(factor: .3)),
    splashFactory: NoSplash.splashFactory,
    // ----------------------------------- TEXT
    fontFamily: AppFont.avenir,
    typography: Typography.material2021(colorScheme: colorSchemeForDark()),
    // ----------------------------------- DECORATION
    inputDecorationTheme: InputDecorationTheme(enabledBorder: InputBorder.none, focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: BorderSide(color: AppDarkColorBase().background().getContrastColor().withValues(alpha: .5), width: 2)), labelStyle: Typography.material2021(colorScheme: colorSchemeForDark()).black.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: .25)), filled: true, fillColor: Colors.transparent),
    // ----------------------------------- STYLE
    pageTransitionsTheme: PageTransitionsTheme(builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(TargetPlatform.values, value: (dynamic _) => const CupertinoPageTransitionsBuilder())),
    // ----------------------------------- WIDGET
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppDarkColorBase().background().increaseLuminance(),
      foregroundColor: colorSchemeForDark().onSurface,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: colorSchemeForDark().onSurface),
      // titleTextStyle: Theme.of(navigatorKey.currentContext!).textTheme.titleMedium,
    ),
    cardTheme: CardTheme(color: colorSchemeForDark().surface, elevation: AppDecoration.elevation, margin: EdgeInsets.zero, shadowColor: colorSchemeForDark().shadow, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppDarkColorBase().background().increaseLuminance(factor: 0.1),
      elevation: AppDecoration.elevation,
      selectedIconTheme: IconThemeData(color: colorSchemeForDark().primary),
      unselectedIconTheme: IconThemeData(color: AppColors.whiteW500),
      selectedItemColor: colorSchemeForDark().primary,
      unselectedItemColor: AppColors.whiteW500,
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    /* BURADA KALDIN */
    radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(colorSchemeForDark().primary), overlayColor: WidgetStatePropertyAll(colorSchemeForDark().primary), visualDensity: VisualDensity.standard, materialTapTargetSize: MaterialTapTargetSize.padded, splashRadius: kToolbarHeight),
    // ----------------------------------- DIALOG & SHEET
    progressIndicatorTheme: ProgressIndicatorThemeData(color: colorSchemeForDark().primary, circularTrackColor: colorSchemeForDark().primary.withValues(alpha: .25), linearTrackColor: colorSchemeForDark().secondary.withValues(alpha: .25)),
    badgeTheme: BadgeThemeData(backgroundColor: colorSchemeForDark().error, alignment: AlignmentDirectional.topEnd, largeSize: 20, smallSize: 10, padding: EdgeInsets.zero),
    bannerTheme: MaterialBannerThemeData(backgroundColor: colorSchemeForDark().surface, elevation: 0, dividerColor: Colors.transparent),
    snackBarTheme: SnackBarThemeData(backgroundColor: AppColors.blackW300, contentTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14), closeIconColor: Colors.white, actionTextColor: colorSchemeForDark().primary, behavior: SnackBarBehavior.fixed, disabledActionTextColor: Colors.black, insetPadding: const EdgeInsets.all(20), shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(0)), elevation: 0, dismissDirection: DismissDirection.down),
    dialogTheme: DialogTheme(backgroundColor: AppDarkColorBase().background(), elevation: AppDecoration.elevation, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius)), alignment: Alignment.center, actionsPadding: EdgeInsets.zero),
    bottomSheetTheme: BottomSheetThemeData(elevation: AppDecoration.elevation, showDragHandle: false, dragHandleColor: primaryColorOnDark(), backgroundColor: AppDarkColorBase().background().increaseLuminance(factor: 0.15), modalBarrierColor: Colors.black.withValues(alpha: .5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppDecoration.radius)))),
    drawerTheme: DrawerThemeData(elevation: AppDecoration.elevation, backgroundColor: AppDarkColorBase().background(), scrimColor: Colors.transparent, surfaceTintColor: Colors.transparent),
    // ----------------------------------- BUTTON
    chipTheme: ChipThemeData(
      showCheckmark: true,
      brightness: Brightness.light,
      elevation: 10,
      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius * .5)),
      backgroundColor: colorSchemeForDark().surface,
      selectedColor: colorSchemeForDark().primary,
      checkmarkColor: colorSchemeForDark().primary.getContrastColor(),
      surfaceTintColor: Colors.transparent,
      side: BorderSide.none,
      secondaryLabelStyle: TextStyle(color: colorSchemeForDark().primary.getContrastColor()),
      labelStyle: TextStyle(color: colorSchemeForDark().surface.getContrastColor()),
    ),
    sliderTheme: SliderThemeData(
      thumbColor: colorSchemeForDark().primary,
      activeTickMarkColor: Colors.transparent,
      activeTrackColor: colorSchemeForDark().primary.toPastel(),
      inactiveTickMarkColor: Colors.transparent,
      inactiveTrackColor: AppColors.blackW100,
      rangeTickMarkShape: const RoundRangeSliderTickMarkShape(tickMarkRadius: 5),
      rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
      rangeValueIndicatorShape: const RectangularRangeSliderValueIndicatorShape(),
      thumbShape: const RoundSliderThumbShape(),
      valueIndicatorColor: AppColors.blackW100,
      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
      valueIndicatorShape: SliderComponentShape.noThumb,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorSchemeForDark().primary;
        }
        return AppDarkColorBase().background().getContrastColor().withValues(alpha: .5);
      }),
      thumbIcon: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(FontAwesomeIcons.check);
        }
        return const Icon(FontAwesomeIcons.minus);
      }),
      trackColor: WidgetStateProperty.all(colorSchemeForDark().surface),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      trackOutlineWidth: const WidgetStatePropertyAll(0),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(colorSchemeForDark().surface), elevation: WidgetStateProperty.all(0), padding: WidgetStateProperty.all(const EdgeInsets.only(top: 20)), shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), shadowColor: WidgetStateProperty.all(Colors.transparent), side: WidgetStateProperty.all(BorderSide.none)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: colorSchemeForDark().surface, shape: const StadiumBorder()),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        side: const WidgetStatePropertyAll(BorderSide.none),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorSchemeForDark().scrim;
          }
          if (states.contains(WidgetState.selected)) {
            return colorSchemeForDark().primary;
          } else {
            return colorSchemeForDark().surface;
          }
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorSchemeForDark().scrim.getContrastColor();
          }
          if (states.contains(WidgetState.selected)) {
            return colorSchemeForDark().primary.getContrastColor();
          } else {
            return colorSchemeForDark().surface.getContrastColor();
          }
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(AppDarkColorBase().accent()), overlayColor: WidgetStatePropertyAll(AppDarkColorBase().accent().increaseLuminance()), surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent), splashFactory: NoSplash.splashFactory)),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(AppDarkColorBase().primary()),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        fixedSize: const WidgetStatePropertyAll(Size.square(40)),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.transparent;
          }
          return AppDarkColorBase().background().getContrastColor().withValues(alpha: .5);
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppDarkColorBase().primary().getContrastColor();
          }
          return AppDarkColorBase().background();
        }),
        /* textStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return TextStyle(fontSize: 14, color: AppDarkColorBase().primary().getContrastColor(), fontWeight: FontWeight.bold);
          }
          return TextStyle(fontSize: 14, color: AppDarkColorBase().background(), fontWeight: FontWeight.bold);
        }), */
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius))),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppDarkColorBase().primary();
          }
          return AppDarkColorBase().card();
        }),
        foregroundColor: WidgetStatePropertyAll(AppDarkColorBase().card().getContrastColor()),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return 20;
          } else {
            return 5;
          }
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(AppDarkColorBase().primary()),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 40)),
        fixedSize: const WidgetStatePropertyAll(Size.fromHeight(40)),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return const BorderSide(color: Colors.transparent);
          }
          return BorderSide(color: AppDarkColorBase().background().getContrastColor(), width: 3);
        }),
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppDarkColorBase().primary().getContrastColor();
          }
          return AppDarkColorBase().background().getContrastColor();
        }),
        /* textStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return TextStyle(fontSize: 14, color: AppDarkColorBase().primary().getContrastColor(), fontWeight: FontWeight.bold);
          }
          return TextStyle(fontSize: 14, color: AppDarkColorBase().background(), fontWeight: FontWeight.bold);
        }), */
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius))),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(AppDarkColorBase().primary()),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 40)),
        fixedSize: const WidgetStatePropertyAll(Size.fromHeight(40)),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.transparent;
          }
          return AppDarkColorBase().background().getContrastColor();
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppDarkColorBase().primary().getContrastColor();
          }
          return AppDarkColorBase().background();
        }),
        /* textStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return TextStyle(fontSize: 14, color: AppDarkColorBase().primary().getContrastColor(), fontWeight: FontWeight.bold);
          }
          return TextStyle(fontSize: 14, color: AppDarkColorBase().background(), fontWeight: FontWeight.bold);
        }), */
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius))),
      ),
    ),
    // ----------------------------------- PICKER
    timePickerTheme: TimePickerThemeData(
      // COLOR
      backgroundColor: AppDarkColorBase().background().increaseLuminance(),
      hourMinuteColor: colorSchemeForDark().surface.withValues(alpha: .5),
      dialBackgroundColor: colorSchemeForDark().surface.withValues(alpha: .5),
      dialTextColor: colorSchemeForDark().surface.getContrastColor(),
      hourMinuteTextColor: colorSchemeForDark().primary,
      dayPeriodTextColor: colorSchemeForDark().onSurface,
      dayPeriodColor: colorSchemeForDark().onSurface,
      entryModeIconColor: AppDarkColorBase().background().increaseLuminance(),
      dialHandColor: colorSchemeForDark().primary,
      // STYLE
      confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(colorSchemeForDark().surface.getContrastColor())),
      cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(colorSchemeForDark().surface.getContrastColor())),
      helpTextStyle: Typography.material2021(colorScheme: colorSchemeForDark()).black.bodyLarge,
      // OTHER
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius)),
      elevation: AppDecoration.elevation,
    ),
    datePickerTheme: DatePickerThemeData(
      // COLOR
      backgroundColor: colorSchemeForDark().surface,
      dividerColor: colorSchemeForDark().surface.increaseLuminance(factor: .1),
      dayOverlayColor: WidgetStatePropertyAll(colorSchemeForDark().secondary),
      yearOverlayColor: WidgetStatePropertyAll(colorSchemeForDark().secondary),
      todayForegroundColor: WidgetStateProperty.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return colorSchemeForDark().onSurface.getContrastColor();
        } else {
          return colorSchemeForDark().primary;
        }
      }),
      dayForegroundColor: WidgetStateProperty.resolveWith((state) {
        if (state.contains(WidgetState.disabled)) {
          return colorSchemeForDark().onSurface.withValues(alpha: .25);
        }
        if (state.contains(WidgetState.selected)) {
          return colorSchemeForDark().onSurface.getContrastColor();
        } else {
          return colorSchemeForDark().onSurface;
        }
      }),
      headerForegroundColor: colorSchemeForDark().primary,
      yearForegroundColor: WidgetStatePropertyAll(colorSchemeForDark().onSurface),
      rangeSelectionOverlayColor: WidgetStatePropertyAll(colorSchemeForDark().secondary),
      rangeSelectionBackgroundColor: colorSchemeForDark().primary.increaseLuminance(factor: .7),
      rangePickerHeaderForegroundColor: colorSchemeForDark().primary,
      // STYLE
      confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(colorSchemeForDark().surface.getContrastColor())),
      cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(colorSchemeForDark().surface.getContrastColor())),
      headerHeadlineStyle: Typography.material2021(colorScheme: colorSchemeForDark()).black.bodyLarge,
      // OTHER
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius)),
      elevation: AppDecoration.elevation,
    ),
    scrollbarTheme: const ScrollbarThemeData(trackVisibility: WidgetStatePropertyAll(true), thumbVisibility: WidgetStatePropertyAll<bool>(true), trackBorderColor: WidgetStatePropertyAll(Colors.amberAccent), trackColor: WidgetStatePropertyAll(Colors.amberAccent), thumbColor: WidgetStatePropertyAll(Colors.amberAccent), interactive: true, thickness: WidgetStatePropertyAll(10), radius: Radius.circular(10)),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(primaryColorOnDark().toNeon(factor: 0.2)),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColorOnDark();
        }
        return AppDarkColorBase().card();
      }),
      side: BorderSide.none,
    ),
  );
}

ColorScheme colorSchemeForDark() => const ColorScheme.dark().copyWith(
  brightness: Brightness.light,
  primary: primaryColorOnDark(),
  onPrimary: primaryColorOnDark().increaseLuminance(factor: 0.2),
  primaryContainer: AppColors.greenW300,
  onPrimaryContainer: AppColors.greenW100.getContrastColor(),
  //
  secondary: AppDarkColorBase().secondary(),
  onSecondary: AppDarkColorBase().secondary().increaseLuminance(factor: 0.2),
  secondaryContainer: AppColors.redW200,
  onSecondaryContainer: AppColors.redW100.getContrastColor(),
  //
  tertiary: AppDarkColorBase().accent(),
  onTertiary: AppDarkColorBase().accent().increaseLuminance(factor: 0.2),
  tertiaryContainer: AppColors.orangeW200,
  onTertiaryContainer: AppColors.orangeW100.getContrastColor(),
  //
  error: AppColors.redW200,
  onError: AppColors.redW200.increaseLuminance(factor: 0.2),
  errorContainer: AppColors.redW500,
  onErrorContainer: AppColors.redW500.increaseLuminance(factor: 0.2),
  //
  // background: AppDarkColorBase().background(),
  // onBackground: AppDarkColorBase().background().increaseLuminance(target: 0.75),
  //
  surface: AppDarkColorBase().card(),
  // onSurface: AppDarkColorBase().foreground(),
  // surfaceVariant: AppDarkColorBase().background(),
  onSurfaceVariant: AppDarkColorBase().background().increaseLuminance(factor: 0.2),
  surfaceTint: AppDarkColorBase().background().increaseLuminance(factor: 0.5),
  //
  scrim: AppDarkColorBase().card().increaseLuminance(factor: .3),
  shadow: Colors.black,
  outline: primaryColorOnDark(),
  outlineVariant: AppColors.whiteW200,
);
