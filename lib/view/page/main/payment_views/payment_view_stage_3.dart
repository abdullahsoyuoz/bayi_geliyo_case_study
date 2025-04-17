import 'package:bayi_geliyo_mobile_application/controller/extension/bool_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/paid_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/colors.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentViewStage3 extends StatefulWidget {
  const PaymentViewStage3({super.key, required this.callback});
  final BoolCallback callback;

  @override
  State<PaymentViewStage3> createState() => _PaymentViewStage3State();
}

class _PaymentViewStage3State extends State<PaymentViewStage3> {
  late TextEditingController _amountController;
  late FocusNode _amountNode;
  final ValueNotifier<String?> _selectedCurrenyNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<AmountType?> _selectedAmountTypeNotifier = ValueNotifier<AmountType?>(null);

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _amountNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountNode.dispose();
    _selectedCurrenyNotifier.dispose();
    _selectedAmountTypeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNowBar(context),
      body: ListView(
        controller: ScrollController(initialScrollOffset: -context.height),
        padding: EdgeInsets.all(AppDecoration.padding),
        children: [
          Text("amount".tr()).wrapPadding(bottom: AppDecoration.padding),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(AppDecoration.radius),
              border: Border.all(color: shadowColor()),
            ),
            child: ValueListenableBuilder(
                valueListenable: _selectedCurrenyNotifier,
                builder: (context, _, __) {
                  return DropdownButton(
                    items: ["Türk Lirası", "Dolar", "Euro"].map(
                      (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e, style: context.textTheme.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: 0.7))),
                        );
                      },
                    ).toList(),
                    hint: Text("selection_to_param".tr(args: ["currency".tr()]), style: context.textTheme.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: .50))),
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Icon(FontAwesomeIcons.chevronDown, size: 15),
                    dropdownColor: context.theme.scaffoldBackgroundColor,
                    value: _selectedCurrenyNotifier.value,
                    onChanged: (value) => _selectedCurrenyNotifier.value = value,
                  ).wrapPaddingSymetric(horizontal: 12);
                }),
          ).wrapPadding(bottom: AppDecoration.padding),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(AppDecoration.radius),
              border: Border.all(color: shadowColor()),
            ),
            child: ValueListenableBuilder(
                valueListenable: _selectedAmountTypeNotifier,
                builder: (context, _, __) {
                  return DropdownButton(
                    items: AmountType.values.map(
                      (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.name.tr(), style: context.textTheme.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: 0.7))),
                        );
                      },
                    ).toList(),
                    hint: Text(
                        "selection_to_param".tr(args: [
                          "attribute_of_param".tr(args: ["amount".tr()])
                        ]),
                        style: context.textTheme.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: .50))),
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Icon(FontAwesomeIcons.chevronDown, size: 15),
                    dropdownColor: context.theme.scaffoldBackgroundColor,
                    value: _selectedAmountTypeNotifier.value,
                    onChanged: (value) => _selectedAmountTypeNotifier.value = value as AmountType,
                  ).wrapPaddingSymetric(horizontal: 12);
                }),
          ).wrapPadding(bottom: AppDecoration.padding),
          TextField(
            controller: _amountController,
            focusNode: _amountNode,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(hintText: "enter_of_param".tr(args: ["amount".tr()])),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ).wrapPadding(bottom: AppDecoration.padding),
        ],
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
    if (_amountController.text.isNotEmpty && _selectedAmountTypeNotifier.value != null && _selectedCurrenyNotifier.value != null) {
      //
      FocusScope.of(context).unfocus();
      //
      PaidHandler.instance.baseModel.currency = _selectedCurrenyNotifier.value;
      PaidHandler.instance.baseModel.amountType = _selectedAmountTypeNotifier.value;
      PaidHandler.instance.baseModel.amount = _amountController.text;
      //
      widget.callback.call(true);
      //
      _amountController.clear();
    } else {
      AppDialog.banner("please_fill_required_areas".tr(), dialogType: AppDialogType.failed);
    }
  }
}
