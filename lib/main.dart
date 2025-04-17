// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:io';
import 'package:bayi_geliyo_mobile_application/controller/handler/main_view_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/theme/theme_controller.dart';
import 'package:bayi_geliyo_mobile_application/controller/constant/routes.dart';
import 'package:bayi_geliyo_mobile_application/controller/model/languages.dart';
import 'package:bayi_geliyo_mobile_application/rest/controller/auth/auth_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() => run();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future run() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {} on Exception {
    //
  }
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  await Hive.initFlutter();
  HttpOverrides.global = MyHttpOverrides();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // StopwatchHandler().start();
  runApp(
    EasyLocalization(
      supportedLocales: languageList().map((e) => e.locale).toList(),
      startLocale: languageList()[0].locale,
      useOnlyLangCode: true,
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeController()),
          ChangeNotifierProvider(create: (context) => AuthController()),
          ChangeNotifierProvider(create: (context) => MainViewHandler()),
        ],
        child: Consumer<ThemeController>(
          builder: (context, _, __) {
            return AppStarter(destination: AppRoutes.splash_page);
          },
        ),
      ),
    ),
  );
}

class AppStarter extends StatefulWidget {
  const AppStarter({super.key, required this.destination});
  final String? destination;

  @override
  State<AppStarter> createState() => _AppStarterState();
}

class _AppStarterState extends State<AppStarter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ThemeController>(context, listen: false).initialize();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: appRoutes(), initialRoute: widget.destination ?? AppRoutes.splash_page, navigatorKey: navigatorKey, showPerformanceOverlay: false, debugShowCheckedModeBanner: false, color: Colors.black, theme: Provider.of<ThemeController>(context, listen: true).theme, locale: context.locale, localizationsDelegates: context.localizationDelegates, supportedLocales: context.supportedLocales);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
