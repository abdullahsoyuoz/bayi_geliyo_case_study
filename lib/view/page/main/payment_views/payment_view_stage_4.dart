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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentViewStage4 extends StatefulWidget {
  const PaymentViewStage4({super.key, required this.callback});
  final BoolCallback callback;

  @override
  State<PaymentViewStage4> createState() => _PaymentViewStage4State();
}

class _PaymentViewStage4State extends State<PaymentViewStage4> {
  final ValueNotifier<LimitType?> _selectedLimitTypeNotifier = ValueNotifier<LimitType?>(null);
  final ValueNotifier<List<bool>> _customerDemandsNotifier = ValueNotifier<List<bool>>(List.generate(3, (index) => false));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _selectedLimitTypeNotifier.dispose();
    _customerDemandsNotifier.dispose();
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
          Text("set_to_param".tr(args: ["limit".tr()])).wrapPadding(bottom: AppDecoration.padding),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(AppDecoration.radius),
              border: Border.all(color: shadowColor()),
            ),
            child: ValueListenableBuilder(
                valueListenable: _selectedLimitTypeNotifier,
                builder: (context, _, __) {
                  return DropdownButton(
                    items: LimitType.values.map(
                      (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.name.tr(), style: context.textTheme.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: 0.7))),
                        );
                      },
                    ).toList(),
                    hint: Text(
                        "selection_to_param".tr(args: [
                          "feature_of_param".tr(args: ["limit".tr()])
                        ]),
                        style: context.textTheme.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: .50))),
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Icon(FontAwesomeIcons.chevronDown, size: 15),
                    dropdownColor: context.theme.scaffoldBackgroundColor,
                    value: _selectedLimitTypeNotifier.value,
                    onChanged: (value) => _selectedLimitTypeNotifier.value = value,
                  ).wrapPaddingSymetric(horizontal: 12);
                }),
          ).wrapPadding(bottom: AppDecoration.padding),
          Text("${"customer_demands".tr()} (${"optional".tr()})").wrapPadding(bottom: AppDecoration.padding),
          ValueListenableBuilder(
            valueListenable: _customerDemandsNotifier,
            builder: (context, _, __) {
              return Column(
                children: List.generate(3, (index) => index).map(
                  (index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(AppDecoration.radius),
                        border: Border.all(color: shadowColor()),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _customerDemandsNotifier.value[index],
                            onChanged: (value) {
                              setState(() {
                                _customerDemandsNotifier.value[index] = value ?? false;
                              });
                            },
                          ),
                          Expanded(child: Text("customer_request_option_$index".tr()))
                        ],
                      ).onTap(
                        () {
                          setState(() {
                            _customerDemandsNotifier.value[index] = !_customerDemandsNotifier.value[index];
                          });
                        },
                      ).wrapPaddingSymetric(horizontal: 10),
                    ).wrapPadding(bottom: AppDecoration.padding);
                  },
                ).toList(),
              );
            },
          )
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
    if (_selectedLimitTypeNotifier.value != null) {
      //
      FocusScope.of(context).unfocus();
      //
      PaidHandler.instance.baseModel.limitType = _selectedLimitTypeNotifier.value;
      PaidHandler.instance.baseModel.customerDemands = _customerDemandsNotifier.value;
      //
      widget.callback.call(true);
      //
      _selectedLimitTypeNotifier.value = null;
      _customerDemandsNotifier.value = List.generate(3, (index) => false);
    } else {
      AppDialog.banner("please_fill_required_areas".tr(), dialogType: AppDialogType.failed);
    }
  }
}
