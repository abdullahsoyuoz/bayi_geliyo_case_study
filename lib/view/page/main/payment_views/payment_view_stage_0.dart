import 'package:bayi_geliyo_mobile_application/controller/extension/bool_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/paid_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/model/payment_method_model.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/colors.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/utility/bounce_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentViewStage0 extends StatelessWidget {
  PaymentViewStage0({super.key, required this.callback});
  final ValueNotifier<int?> _selectedPaymentNotifier = ValueNotifier<int?>(null);
  final BoolCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: _selectedPaymentNotifier,
          builder: (context, _, __) {
            return ListView.builder(
              controller: ScrollController(initialScrollOffset: -context.height),
              padding: EdgeInsets.all(AppDecoration.padding),
              itemCount: paymentMethodModelList().length,
              itemBuilder: (context, index) {
                PaymentMethodModel data = paymentMethodModelList()[index];
                bool active = _selectedPaymentNotifier.value == index;
                return AppBounce(
                  onPressed: () {
                    if (_selectedPaymentNotifier.value == index) {
                      _selectedPaymentNotifier.value = null;
                    } else {
                      if (data.active) {
                        _selectedPaymentNotifier.value = index;
                      }
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: Material(
                      color: context.theme.scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDecoration.radius * 2), side: BorderSide(color: active ? context.colors.primary : shadowColor(), width: 1)),
                      elevation: 0,
                      child: Column(
                        children: [
                          Expanded(child: Image.asset(data.iconPath).wrapPadding(bottom: AppDecoration.padding)),
                          Text(data.title, style: context.textTheme.bodyMedium?.copyWith(color: Color(0xFF015781), fontWeight: FontWeight.w700)),
                          Text(data.description, textAlign: TextAlign.center),
                        ],
                      ).wrapPaddingAll(AppDecoration.padding),
                    ),
                  ).wrapPadding(bottom: AppDecoration.padding),
                );
              },
            );
          },
        ),
        bottomNavigationBar: _bottomNowBar(context),
      ),
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
              _submitController();
            },
            child: Text(
              "continue".tr(),
              style: context.textTheme.titleLarge?.copyWith(
                color: context.theme.filledButtonTheme.style?.backgroundColor?.resolve({})?.getContrastColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ).wrapPaddingSymetric(horizontal: AppDecoration.padding),
        ],
      ).wrapPadding(bottom: context.paddingBottomBase),
    );
  }

  void _submitController() {
    if (_selectedPaymentNotifier.value != null) {
      PaidHandler.instance.baseModel.paidType = _selectedPaymentNotifier.value?.getPaidType();
      callback.call(true);
      _selectedPaymentNotifier.value = null;
    } else {
      AppDialog.banner("please_make_at_least_one_selection".tr(), dialogType: AppDialogType.failed);
    }
  }
}
