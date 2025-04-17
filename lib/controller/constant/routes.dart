// ignore_for_file: non_constant_identifier_names

import 'package:bayi_geliyo_mobile_application/main.dart';
import 'package:bayi_geliyo_mobile_application/view/page/app/splash.dart';
import 'package:bayi_geliyo_mobile_application/view/page/auth/auth_views.dart';
import 'package:bayi_geliyo_mobile_application/view/page/auth/login_page.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_page.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_result_page.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_summary_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes() => {
      // APP
      AppRoutes.app_starter: (context) => AppStarter(destination: AppRoutes.splash_page),
      AppRoutes.splash_page: (context) => const SplashPage(),
      // AUTHENTICATION
      AppRoutes.auth_view: (context) => const AuthMainView(),
      AppRoutes.login_page: (context) => const LoginPage(),
      // MAIN
      AppRoutes.payment_page: (context) => const PaymentPage(),
      AppRoutes.payment_summary_page: (context) => const PaymentSummaryPage(),
      AppRoutes.payment_result_page: (context) => const PaymentResultPage(),
      // DETAIL
    };

class AppRoutes {
  // APP
  static String app_starter = "app_starter";
  static String splash_page = "splash_page";
  // AUTH
  static String auth_view = "auth_view";
  static String login_page = "login_page";
  // MAIN
  static String payment_page = "payment_page";
  static String payment_summary_page = "payment_summary_page";
  static String payment_result_page = "payment_result_page";
  // DETAIL
}
