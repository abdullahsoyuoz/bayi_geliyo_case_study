import 'package:bayi_geliyo_mobile_application/controller/handler/app_handler.dart';
import 'package:bayi_geliyo_mobile_application/view/page/auth/login_page.dart';

import 'package:flutter/material.dart';

class AuthMainView extends StatefulWidget {
  const AuthMainView({super.key});

  @override
  State<AuthMainView> createState() => _AuthMainViewState();
}

class _AuthMainViewState extends State<AuthMainView> {
  ValueNotifier<bool> onLoginNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    onLoginNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async => await AppHandler.instance.closeApp(),
      child: ValueListenableBuilder(
        valueListenable: onLoginNotifier,
        builder: (context, value, child) {
          if (onLoginNotifier.value) {
            return LoginPage();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
