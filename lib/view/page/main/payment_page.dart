import 'package:bayi_geliyo_mobile_application/controller/constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/constant/routes.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/app_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/button.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_views/payment_view_stage_0.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_views/payment_view_stage_1.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_views/payment_view_stage_2.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_views/payment_view_stage_3.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_views/payment_view_stage_4.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_views/payment_view_stage_5.dart';
import 'package:bayi_geliyo_mobile_application/view/page/main/payment_views/payment_view_stage_6.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/utility/app_absorb.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final ValueNotifier<int> _paymentViewIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _next(bool pass) {
    if (pass) {
      _paymentViewIndexNotifier.value++;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => AppHandler.instance.closeApp(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: context.colors.primary,
          resizeToAvoidBottomInset: false,
          body: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _paymentViewIndexNotifier,
        builder: (context, _, __) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton.filled(
                                  onPressed: () {
                                    if (_paymentViewIndexNotifier.value == 0) {
                                      AppHandler.instance.closeApp();
                                    } else {
                                      _paymentViewIndexNotifier.value--;
                                      // _pageController.animateTo(_paymentViewIndexNotifier.value.toDouble(), duration: 300.millisecond(), curve: AppCurves.overshoot());
                                    }
                                  },
                                  icon: Icon(FontAwesomeIcons.chevronLeft),
                                  style: AppButtonStyle.circle(context),
                                ),
                                Text(
                                  "payment_view_${_paymentViewIndexNotifier.value}_title".tr(),
                                  style: context.textTheme.titleLarge?.copyWith(color: context.theme.scaffoldBackgroundColor, fontWeight: FontWeight.bold),
                                ),
                                AppAbsorb(
                                  // for symetric
                                  absorb: true,
                                  transparent: false,
                                  child: IconButton.filled(
                                    onPressed: () {},
                                    icon: Icon(FontAwesomeIcons.chevronLeft),
                                  ),
                                ),
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
                                          "payment_view_${_paymentViewIndexNotifier.value}_subtitle".tr(),
                                          style: context.textTheme.headlineSmall?.copyWith(color: context.colors.primary.getContrastColor(), fontWeight: FontWeight.bold),
                                        ),
                                        Image.asset(AppImage.logo_on_dark.path, width: 16, height: 16),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.width * 0.7,
                                    child: Text(
                                      "payment_view_${_paymentViewIndexNotifier.value}_description".tr(),
                                      style: context.textTheme.bodySmall?.copyWith(color: context.colors.primary.getContrastColor(), fontWeight: FontWeight.bold),
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
                child: _view(),
              ).wrapPadding(top: context.width / 1.6),
            ],
          );
        });
  }

  Widget _view() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDecoration.radius * 2),
      ),
      child: Builder(
        builder: (context) {
          switch (_paymentViewIndexNotifier.value) {
            case 0:
              return PaymentViewStage0(callback: _next);
            case 1:
              return PaymentViewStage1(callback: _next);
            case 2:
              return PaymentViewStage2(callback: _next);
            case 3:
              return PaymentViewStage3(callback: _next);
            case 4:
              return PaymentViewStage4(callback: _next);
            case 5:
              return PaymentViewStage5(callback: _next);
            case 6:
              return PaymentViewStage6(callback: (pass) {
                if (pass) Navigator.pushNamed(context, AppRoutes.payment_summary_page);
              });
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
