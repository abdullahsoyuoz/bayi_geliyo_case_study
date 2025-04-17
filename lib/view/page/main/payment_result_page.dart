import 'package:bayi_geliyo_mobile_application/controller/constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/constant/routes.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/main_view_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/button.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/utility/app_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PaymentResultPage extends StatefulWidget {
  const PaymentResultPage({super.key});

  @override
  State<PaymentResultPage> createState() => _PaymentResultPageState();
}

class _PaymentResultPageState extends State<PaymentResultPage> {
  ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    indexNotifier.value = Provider.of<MainViewHandler>(context, listen: true).index;
    return Scaffold(
      appBar: AppBar(
        title: Text("result_screen".tr(), style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: context.colors.primary)),
        automaticallyImplyLeading: false,
      ),
      body: _body(context),
      bottomNavigationBar: AppBottomNavigationBar(indexNotifier: indexNotifier),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                AppAnimation.success.path,
                repeat: false,
                delegates: LottieDelegates(values: [
                  ValueDelegate.colorFilter(["**"], value: ColorFilter.mode(context.colors.primary, BlendMode.src)),
                ]),
              ).wrapPadding(bottom: AppDecoration.padding * 1.5),
              Text(
                "payment_spinner_success".tr(),
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: context.colors.primary),
                textAlign: TextAlign.center,
              )
            ],
          )),
          FilledButton(
            onPressed: () async {
              await Navigator.pushNamedAndRemoveUntil(context, AppRoutes.payment_page, (route) => false);
            },
            style: AppButtonStyle.alternative(context),
            child: Text("get_new_payment".tr()),
          ).wrapPadding(bottom: AppDecoration.padding * .5),
          FilledButton(
            onPressed: () {},
            style: AppButtonStyle.alternative(context),
            child: Text("back_to_home".tr()),
          ).wrapPadding(bottom: AppDecoration.padding),
        ],
      ).wrapPaddingSymetric(horizontal: AppDecoration.padding),
    );
  }
}
