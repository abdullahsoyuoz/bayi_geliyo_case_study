import 'package:bayi_geliyo_mobile_application/controller/Constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/colors.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppLightColorBase {
  Color primary() => primaryColorOnLight();
  Color secondary() => accentColor();
  Color accent() => Color.fromARGB(255, 88, 160, 208);
  Color card() => cardColor();
  Color foreground() => Colors.black;
  Color background() => const Color.fromARGB(255, 252, 252, 252);
}

ThemeData appThemeLight() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  return ThemeData(
    useMaterial3: true,
    // ----------------------------------- COLOR
    colorScheme: colorSchemeForLightTheme(),
    scaffoldBackgroundColor: AppLightColorBase().background(),
    cardColor: colorSchemeForLightTheme().surface,
    dividerColor: colorSchemeForLightTheme().scrim,
    canvasColor: colorSchemeForLightTheme().surface,
    iconTheme: const IconThemeData(color: Colors.black),
    dividerTheme: DividerThemeData(color: colorSchemeForLightTheme().surface.increaseLuminance(), thickness: 0.2),
    splashFactory: InkSparkle.splashFactory,
    // ----------------------------------- TEXT
    fontFamily: AppFont.avenir,
    typography: Typography.material2021(colorScheme: colorSchemeForLightTheme()),

    // ----------------------------------- DECORATION
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDecoration.radius), borderSide: BorderSide(color: shadowColor(), width: 1)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDecoration.radius), borderSide: BorderSide(color: shadowColor().increaseLuminance(factor: .075), width: 2)),
      labelStyle: Typography.material2021(colorScheme: colorSchemeForLightTheme()).white.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: .50)),
      hintStyle: Typography.material2021(colorScheme: colorSchemeForLightTheme()).white.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: .50)),
      filled: true,
      fillColor: Colors.white,
    ),
    // ----------------------------------- STYLE
    pageTransitionsTheme: PageTransitionsTheme(builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(TargetPlatform.values, value: (dynamic _) => const CupertinoPageTransitionsBuilder())),
    // ----------------------------------- WIDGET
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppLightColorBase().background(),
      foregroundColor: colorSchemeForLightTheme().onSurface,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.grey.shade100,
      centerTitle: true,
    ),
    cardTheme: CardTheme(color: AppLightColorBase().card(), elevation: AppDecoration.elevation * 0.5, margin: EdgeInsets.zero, shadowColor: colorSchemeForLightTheme().shadow, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), surfaceTintColor: Colors.transparent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppLightColorBase().background().increaseLuminance(),
      elevation: AppDecoration.elevation,
      selectedIconTheme: IconThemeData(color: colorSchemeForLightTheme().onSurface),
      unselectedIconTheme: IconThemeData(color: AppColors.whiteW300),
      selectedItemColor: colorSchemeForLightTheme().onSurface,
      unselectedItemColor: AppColors.whiteW500,
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    /* BURADA KALDIN */
    radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(colorSchemeForLightTheme().primary), overlayColor: WidgetStatePropertyAll(colorSchemeForLightTheme().primary), visualDensity: VisualDensity.standard, materialTapTargetSize: MaterialTapTargetSize.padded, splashRadius: kToolbarHeight),
    // ----------------------------------- DIALOG & SHEET
    progressIndicatorTheme: ProgressIndicatorThemeData(color: colorSchemeForLightTheme().primary, circularTrackColor: colorSchemeForLightTheme().primary.withValues(alpha: .25), linearTrackColor: colorSchemeForLightTheme().secondary.withValues(alpha: .25)),
    badgeTheme: BadgeThemeData(backgroundColor: AppColors.redW400, alignment: AlignmentDirectional.topEnd, largeSize: 20, smallSize: 10, padding: EdgeInsets.zero),
    bannerTheme: MaterialBannerThemeData(backgroundColor: colorSchemeForLightTheme().surface, elevation: 0, dividerColor: Colors.transparent),
    snackBarTheme: SnackBarThemeData(backgroundColor: AppColors.whiteW100, contentTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14), closeIconColor: Colors.black, actionTextColor: AppColors.orangeW300, behavior: SnackBarBehavior.fixed, disabledActionTextColor: Colors.black, insetPadding: const EdgeInsets.all(20), shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(0)), elevation: 0, dismissDirection: DismissDirection.down),
    dialogTheme: DialogTheme(backgroundColor: AppLightColorBase().background(), elevation: AppDecoration.elevation, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius)), alignment: Alignment.center, actionsPadding: EdgeInsets.zero),
    bottomSheetTheme: BottomSheetThemeData(elevation: AppDecoration.elevation, showDragHandle: false, backgroundColor: AppLightColorBase().background(), dragHandleColor: AppLightColorBase().card(), modalBarrierColor: AppLightColorBase().background().getContrastColor().withValues(alpha: .75), shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppDecoration.radius)))),
    drawerTheme: DrawerThemeData(elevation: AppDecoration.elevation, backgroundColor: AppLightColorBase().background(), scrimColor: Colors.transparent, surfaceTintColor: Colors.transparent),
    // ----------------------------------- BUTTON
    chipTheme: ChipThemeData(
      showCheckmark: true,
      brightness: Brightness.light,
      elevation: 10,
      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius * .5)),
      backgroundColor: colorSchemeForLightTheme().surface,
      selectedColor: colorSchemeForLightTheme().primary,
      checkmarkColor: colorSchemeForLightTheme().primary.getContrastColor(),
      surfaceTintColor: Colors.transparent,
      side: BorderSide.none,
      labelStyle: TextStyle(color: colorSchemeForLightTheme().primary.getContrastColor()),
    ),
    sliderTheme: SliderThemeData(
      thumbColor: colorSchemeForLightTheme().primary,
      activeTickMarkColor: Colors.transparent,
      activeTrackColor: colorSchemeForLightTheme().primary.toPastel(),
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
          return colorSchemeForLightTheme().primary;
        }
        return AppLightColorBase().background().increaseLuminance();
      }),
      thumbIcon: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(FontAwesomeIcons.check);
        }
        return const Icon(FontAwesomeIcons.minus);
      }),
      trackColor: WidgetStateProperty.all(colorSchemeForLightTheme().surface.toPastel()),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      trackOutlineWidth: const WidgetStatePropertyAll(0),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
      menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(colorSchemeForLightTheme().surface), elevation: WidgetStateProperty.all(0), padding: WidgetStateProperty.all(const EdgeInsets.only(top: 20)), shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), shadowColor: WidgetStateProperty.all(Colors.transparent), side: WidgetStateProperty.all(BorderSide.none)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: colorSchemeForLightTheme().surface, shape: const StadiumBorder()),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        side: const WidgetStatePropertyAll(BorderSide.none),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorSchemeForLightTheme().scrim;
          }
          if (states.contains(WidgetState.selected)) {
            return colorSchemeForLightTheme().primary;
          } else {
            return AppLightColorBase().background();
          }
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorSchemeForLightTheme().scrim.getContrastColor();
          }
          if (states.contains(WidgetState.selected)) {
            return colorSchemeForLightTheme().primary.getContrastColor();
          } else {
            return AppLightColorBase().background().getContrastColor();
          }
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.pressed)) {
              return AppLightColorBase().primary();
            }
            return AppLightColorBase().secondary();
          },
        ),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(AppLightColorBase().primary()),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        fixedSize: const WidgetStatePropertyAll(Size.square(40)),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.transparent;
          }
          return AppLightColorBase().card().increaseLuminance();
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppLightColorBase().primary().getContrastColor();
          }
          return AppLightColorBase().background();
        }),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius))),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppLightColorBase().primary();
          }
          return AppLightColorBase().card();
        }),
        foregroundColor: WidgetStatePropertyAll(AppLightColorBase().card().getContrastColor()),
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
        overlayColor: WidgetStatePropertyAll(AppLightColorBase().primary()),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 40)),
        fixedSize: const WidgetStatePropertyAll(Size.fromHeight(40)),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return const BorderSide(color: Colors.transparent);
            // return Colors.transparent;
          }
          return BorderSide(color: AppLightColorBase().background().getContrastColor(), width: 3);
        }),
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppLightColorBase().primary().getContrastColor();
          }
          return AppLightColorBase().background().getContrastColor();
        }),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius))),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(AppLightColorBase().secondary()),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 40)),
        fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 68)),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.transparent;
          }
          return AppLightColorBase().primary();
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppLightColorBase().primary().getContrastColor();
          }
          return AppLightColorBase().background();
        }),
        textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        /* textStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return TextStyle(fontSize: 14, color: AppLightColorBase().primary().getContrastColor(), fontWeight: FontWeight.bold);
          }
          return TextStyle(fontSize: 14, color: AppLightColorBase().background(), fontWeight: FontWeight.bold);
        }), */
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius * 1.5))),
      ),
    ),
    // ----------------------------------- PICKER
    timePickerTheme: TimePickerThemeData(
      //  COLOR
      backgroundColor: AppLightColorBase().background().increaseLuminance(factor: .1),
      hourMinuteColor: colorSchemeForLightTheme().surface.withValues(alpha: .5),
      dialBackgroundColor: colorSchemeForLightTheme().surface.withValues(alpha: .5),
      dialTextColor: colorSchemeForLightTheme().surface.getContrastColor(),
      hourMinuteTextColor: colorSchemeForLightTheme().onSurface,
      dayPeriodTextColor: colorSchemeForLightTheme().onSurface,
      dayPeriodColor: colorSchemeForLightTheme().onSurface,
      entryModeIconColor: AppLightColorBase().background(),
      dialHandColor: colorSchemeForLightTheme().primary,
      //  STYLE
      confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(colorSchemeForLightTheme().surface.getContrastColor())),
      cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStateProperty.all(colorSchemeForLightTheme().surface.getContrastColor())),
      helpTextStyle: Typography.material2021(colorScheme: colorSchemeForLightTheme()).black.bodyLarge,
      // OTHER
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius)),
      elevation: AppDecoration.elevation,
    ),
    datePickerTheme: DatePickerThemeData(
      // COLOR
      backgroundColor: AppLightColorBase().primary(),
      dividerColor: colorSchemeForLightTheme().surface.increaseLuminance(factor: .1),
      dayOverlayColor: WidgetStatePropertyAll(colorSchemeForLightTheme().secondary),
      yearOverlayColor: WidgetStatePropertyAll(colorSchemeForLightTheme().secondary),
      todayForegroundColor: WidgetStateProperty.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return colorSchemeForLightTheme().secondary;
        } else {
          return AppLightColorBase().primary().getContrastColor();
        }
      }),
      dayForegroundColor: WidgetStateProperty.resolveWith((state) {
        if (state.contains(WidgetState.disabled)) {
          return AppLightColorBase().primary().getContrastColor().withValues(alpha: .25);
        }
        if (state.contains(WidgetState.selected)) {
          return colorSchemeForLightTheme().secondary;
        } else {
          return AppLightColorBase().primary().getContrastColor();
        }
      }),
      weekdayStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headerForegroundColor: AppLightColorBase().primary().getContrastColor(),
      yearForegroundColor: WidgetStatePropertyAll(AppLightColorBase().primary().getContrastColor()),
      rangeSelectionOverlayColor: WidgetStatePropertyAll(colorSchemeForLightTheme().secondary),
      rangeSelectionBackgroundColor: colorSchemeForLightTheme().primary.increaseLuminance(factor: .7),
      rangePickerHeaderForegroundColor: colorSchemeForLightTheme().primary,
      // STYLE
      confirmButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppLightColorBase().primary().getContrastColor()),
        foregroundColor: WidgetStateProperty.all(AppLightColorBase().primary().getContrastColor().getContrastColor()),
      ),
      cancelButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppLightColorBase().primary().getContrastColor()),
        foregroundColor: WidgetStateProperty.all(AppLightColorBase().primary().getContrastColor().getContrastColor()),
      ),
      headerHeadlineStyle: Typography.material2021(colorScheme: colorSchemeForLightTheme()).black.bodyLarge,
      // OTHER
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius)),
      elevation: AppDecoration.elevation,
    ),
    scrollbarTheme: const ScrollbarThemeData(trackVisibility: WidgetStatePropertyAll(true), thumbVisibility: WidgetStatePropertyAll<bool>(true), trackBorderColor: WidgetStatePropertyAll(Colors.amberAccent), trackColor: WidgetStatePropertyAll(Colors.amberAccent), thumbColor: WidgetStatePropertyAll(Colors.amberAccent), interactive: true, thickness: WidgetStatePropertyAll(10), radius: Radius.circular(10)),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(primaryColorOnLight().getContrastColor()),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColorOnLight();
        }
        return Colors.transparent;
      }),
      side: BorderSide(color: AppLightColorBase().primary()),
    ),
  );
}

Color activeColorLight = const Color.fromARGB(255, 212, 159, 35);
Color deactiveColorLight = const Color.fromARGB(255, 208, 207, 213);

// Color _card() => Colors.white;

ColorScheme colorSchemeForLightTheme() => const ColorScheme.light().copyWith(
      brightness: Brightness.light,
      primary: primaryColorOnLight(),
      onPrimary: primaryColorOnLight().increaseLuminance(factor: 0.15),
      primaryContainer: AppColors.greenW300,
      onPrimaryContainer: AppColors.greenW100.getContrastColor(),
      //
      secondary: AppLightColorBase().secondary(),
      onSecondary: AppLightColorBase().secondary().increaseLuminance(factor: 0.15),
      secondaryContainer: AppColors.redW300,
      onSecondaryContainer: AppColors.redW100.getContrastColor(),
      //
      tertiary: AppLightColorBase().accent(),
      onTertiary: AppLightColorBase().accent().increaseLuminance(factor: 0.15),
      tertiaryContainer: AppColors.orangeW100,
      onTertiaryContainer: AppColors.orangeW100.getContrastColor(),
      //
      error: AppColors.redW200,
      onError: AppColors.redW200.increaseLuminance(factor: 0.15),
      errorContainer: AppColors.redW500,
      onErrorContainer: AppColors.redW500.increaseLuminance(factor: 0.15),
      //
      // background: AppLightColorBase().backgroundColorLight(),
      // onBackground: AppLightColorBase().backgroundColorLight().increaseLuminance(target: 0.75),
      //
      surface: AppLightColorBase().card(),
      onSurface: AppLightColorBase().foreground(),
      // surfaceVariant: AppLightColorBase().backgroundColorLight(),
      onSurfaceVariant: primaryColorOnLight(),
      surfaceTint: Colors.transparent,
      //
      scrim: AppLightColorBase().card().increaseLuminance(factor: .3),
      shadow: Colors.black,
      outline: AppLightColorBase().foreground(),
      outlineVariant: AppColors.whiteW200,
    );
