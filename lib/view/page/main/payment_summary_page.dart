import 'package:bayi_geliyo_mobile_application/controller/constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/constant/routes.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/datetime_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/future_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/int_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/app_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/paid_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/button.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentSummaryPage extends StatefulWidget {
  const PaymentSummaryPage({super.key});

  @override
  State<PaymentSummaryPage> createState() => _PaymentSummaryPageState();
}

class _PaymentSummaryPageState extends State<PaymentSummaryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        forceMaterialTransparency: false,
        shadowColor: context.colors.surface.withAlpha(30),
        title: Text(
          "summary_of_param".tr(args: ["payment".tr()]),
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: context.colors.primary),
        ),
        leading: IconButton.filled(
          onPressed: () => Navigator.pop(context),
          icon: Icon(FontAwesomeIcons.chevronLeft),
          style: AppButtonStyle.circle(context, color: context.colors.tertiary, iconSize: 20),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.only(left: AppDecoration.padding, right: AppDecoration.padding, bottom: AppDecoration.padding * 3),
      children: [
        AspectRatio(aspectRatio: 1.5, child: Image.asset(AppIcon.link_alt.path)),
        Text("summary_of_param".tr(args: ["link_payment".tr()]), style: context.textTheme.titleLarge?.copyWith(color: context.colors.primary, fontWeight: FontWeight.bold)),
        Text("payment_summary_description".tr(), style: context.textTheme.bodyMedium?.copyWith(color: context.colors.surface)).wrapPadding(bottom: AppDecoration.padding),
        _title(title: "info_of_param".tr(args: ["recipient".tr()])),
        Text("${PaidHandler.instance.baseModel.nameSurname}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _dottedLine(),
        Text("${PaidHandler.instance.baseModel.email}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _dottedLine(),
        Text("${PaidHandler.instance.baseModel.phone}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _divider(),
        _title(title: "settings_param".tr(args: ["link".tr()])),
        Text("${PaidHandler.instance.baseModel.linkTitle}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _dottedLine(),
        if (PaidHandler.instance.baseModel.linkDescription != null && PaidHandler.instance.baseModel.linkDescription!.isNotEmpty)
          Column(
            children: [
              Text("${PaidHandler.instance.baseModel.linkDescription}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
              _dottedLine(),
            ],
          ),
        Text("${PaidHandler.instance.baseModel.language}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _divider(),
        _title(title: "amount".tr()),
        Text("${PaidHandler.instance.baseModel.currency}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _dottedLine(),
        Text("${PaidHandler.instance.baseModel.amountType?.name.tr()}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _dottedLine(),
        Text("${PaidHandler.instance.baseModel.amount} ${AppHandler.instance.getCurrentSymbol(PaidHandler.instance.baseModel.currency!)}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _divider(),
        _title(title: "${"customer_demands".tr()} (${"optional".tr()})"),
        if (PaidHandler.instance.baseModel.customerDemands != null)
          Column(
              children: PaidHandler.instance.baseModel.customerDemands!.map(
            (e) {
              return Row(
                children: [
                  Checkbox(value: e, onChanged: (value) {}, visualDensity: VisualDensity.compact),
                  Expanded(child: Text("customer_request_option_${PaidHandler.instance.baseModel.customerDemands?.indexOf(e)}".tr())),
                ],
              );
            },
          ).toList()),
        _divider(),
        _title(title: "credit_card".tr()),
        Column(
            children: PaymentType.values.map(
          (e) {
            return Row(
              children: [
                Checkbox(value: PaidHandler.instance.baseModel.paymentType == e, onChanged: (value) {}, visualDensity: VisualDensity.compact),
                Expanded(child: Text(e.name.tr())),
              ],
            );
          },
        ).toList()),
        _divider(),
        _title(title: "set_to_param".tr(args: ["link".tr()])),
        Text("${PaidHandler.instance.baseModel.limitTimeType?.name.tr()}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        if (PaidHandler.instance.baseModel.limitTimeType != null && PaidHandler.instance.baseModel.limitTimeType!.hasLimit()) Text("${PaidHandler.instance.baseModel.limitDateTime?.format(context, query: "dd.MM.yyyy")}", style: context.textTheme.bodyMedium?.copyWith(color: context.colors.onSurface)),
        _dottedLine(),
        Text("${PaidHandler.instance.baseModel.amountType?.name.tr()}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _dottedLine(),
        Text("${PaidHandler.instance.baseModel.amount} ${AppHandler.instance.getCurrentSymbol(PaidHandler.instance.baseModel.currency!)}", style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface)),
        _divider(),
        _title(title: "credit_card".tr()),
        Column(
                children: PaidHandler.instance.baseModel.posSelection!.map(
          (e) {
            int index = PaidHandler.instance.baseModel.posSelection!.indexOf(e);
            return Row(
              children: [
                Checkbox(value: PaidHandler.instance.baseModel.posSelection![index], onChanged: (value) {}, visualDensity: VisualDensity.compact),
                Expanded(child: Text("POS ${index + 1}")),
              ],
            );
          },
        ).toList())
            .wrapPadding(bottom: AppDecoration.padding * 3),
        FilledButton(
          onPressed: () async {
            _submitControl();
          },
          child: Text(
            "send_param".tr(args: ["link".tr()]),
            style: context.textTheme.titleLarge?.copyWith(
              color: context.theme.filledButtonTheme.style?.backgroundColor?.resolve({})?.getContrastColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  void _submitControl() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(3.second()).whenComplete(() {}).withSpinner(isPayment: true).whenComplete(() {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.payment_result_page, (route) => false);
        }
      });
    });
  }

  Widget _divider() => Divider(thickness: 1).wrapPaddingSymetric(horizontal: AppDecoration.padding, vertical: AppDecoration.padding * 1.5);

  Widget _title({required String title}) => Text(title, style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: context.colors.surface)).wrapPadding(bottom: 10);

  Widget _dottedLine() => DottedLine(dashGapRadius: 20, dashRadius: 10, dashGapLength: 2, dashLength: 2, lineThickness: 1, dashColor: context.colors.tertiary.increaseLuminance(factor: .7)).wrapPaddingSymetric(vertical: 5);
}
