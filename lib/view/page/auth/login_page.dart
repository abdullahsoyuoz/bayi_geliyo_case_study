import 'package:bayi_geliyo_mobile_application/controller/constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/future_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/string_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/app_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/rest/handler/auth/auth_handler.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _identityController;
  late FocusNode _identityNode;
  late TextEditingController _passwordController;
  late FocusNode _passwordNode;
  final ValueNotifier<bool> _rememberMeNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _obscureNotifier = ValueNotifier<bool>(true);
  // final ScrollController _scrollController = ScrollController(initialScrollOffset: 1000);

  @override
  void initState() {
    super.initState();
    _identityController = TextEditingController();
    _identityNode = FocusNode();
    _passwordController = TextEditingController();
    _passwordNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //
    });
  }

  @override
  void dispose() {
    _identityController.dispose();
    _identityNode.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    _rememberMeNotifier.dispose();
    _obscureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => AppHandler.instance.closeApp(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: context.colors.primary,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: _bottomNowBar(context),
          body: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: AspectRatio(
            aspectRatio: 1.6,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppImage.back.path,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: context.width * 0.5,
                            child: Image.asset(
                              AppImage.logotype_on_dark.path,
                            ),
                          ).wrapPadding(bottom: AppDecoration.padding * .5),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "login_title".tr(),
                                    style: context.textTheme.headlineMedium?.copyWith(color: context.colors.primary.getContrastColor()),
                                  ),
                                  Image.asset(AppImage.logo_on_dark.path, width: 16, height: 16),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.5,
                              child: Text(
                                "login_description".tr(),
                                style: context.textTheme.titleSmall?.copyWith(color: context.colors.primary.getContrastColor()),
                              ),
                            ),
                          ],
                        ).wrapPadding(bottom: AppDecoration.padding),
                      ),
                    ],
                  ),
                ).wrapPadding(top: context.paddingTopBase + AppDecoration.padding, left: AppDecoration.padding),
              ],
            ),
          ),
        ),
        Container(
          width: context.width,
          height: context.height,
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppDecoration.radius * 2)),
            boxShadow: [
              BoxShadow(
                color: context.colors.secondary,
                blurRadius: 0,
                offset: Offset(0, -5),
                spreadRadius: 0,
              )
            ],
          ),
          child: _input(context),
        ).wrapPadding(top: context.width / 1.6),
      ],
    );
  }

  Widget _input(BuildContext context) {
    return ListView(
      controller: ScrollController(initialScrollOffset: 1000),
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: AppDecoration.padding, vertical: AppDecoration.padding * 2),
      children: [
        TextField(
          controller: _identityController,
          focusNode: _identityNode,
          decoration: InputDecoration(
            hintText: "login_identity_title".tr(),
            prefixIconConstraints: BoxConstraints(),
            prefixIcon: Image.asset(
              AppIcon.letter.path,
              width: 20,
              height: 20,
              color: context.colors.surface,
            ).wrapPadding(left: 17, right: 7),
          ),
          textInputAction: TextInputAction.next,
        ).wrapPadding(bottom: AppDecoration.padding),
        ValueListenableBuilder(
            valueListenable: _obscureNotifier,
            builder: (context, _, __) {
              return TextField(
                controller: _passwordController,
                focusNode: _passwordNode,
                obscureText: _obscureNotifier.value,
                decoration: InputDecoration(
                  hintText: "login_password_title".tr(),
                  prefixIconConstraints: BoxConstraints(),
                  suffixIconConstraints: BoxConstraints(),
                  prefixIcon: Image.asset(
                    AppIcon.lock.path,
                    width: 20,
                    height: 20,
                    color: context.colors.surface,
                  ).wrapPadding(left: 17, right: 7),
                  suffixIcon: Image.asset(
                    AppIcon.eye.path,
                    width: 20,
                    height: 20,
                    color: _obscureNotifier.value ? context.colors.surface : context.colors.error,
                  ).wrapPadding(left: 7, right: 17).onTap(() {
                    _obscureNotifier.value = !_obscureNotifier.value;
                  }),
                ),
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
              ).wrapPadding(bottom: AppDecoration.padding);
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _rememberMeNotifier,
                builder: (context, _, __) {
                  return Row(
                    children: [
                      Checkbox(
                        value: _rememberMeNotifier.value,
                        onChanged: null,
                        side: BorderSide(color: context.colors.surface, width: 1),
                        checkColor: context.colors.primary.getContrastColor(),
                      ),
                      Text("remember_me".tr()),
                    ],
                  ).onTap(
                    () {
                      _rememberMeNotifier.value = !_rememberMeNotifier.value;
                    },
                  );
                },
              ),
            ),
            TextButton(onPressed: () => _foo(), child: Text("forgot_password".tr()))
          ],
        )
      ],
    );
  }

  Widget _bottomNowBar(BuildContext context) {
    return Material(
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              AuthHandler.instance.login(context, _identityController.text, _passwordController.text, _rememberMeNotifier.value).withSpinner();
            },
            child: Text(
              "login".tr(),
              style: context.textTheme.titleLarge?.copyWith(
                color: context.theme.filledButtonTheme.style?.backgroundColor?.resolve({})?.getContrastColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ).wrapPaddingSymetric(horizontal: AppDecoration.padding),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "login_regist_title".tr().addSymbolAfter(symbol: ' '), style: context.textTheme.bodyMedium),
                TextSpan(
                  text: "login_regist_title_click".tr(),
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colors.secondary, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _foo();
                    },
                ),
              ],
            ),
          ).wrapPadding(top: AppDecoration.padding * 0.5),
        ],
      ).wrapPadding(bottom: context.paddingBottomBase),
    );
  }

  void _foo() {
    FocusScope.of(context).unfocus();
    AppDialog.banner("success".tr(), dialogType: AppDialogType.success);
  }
}
