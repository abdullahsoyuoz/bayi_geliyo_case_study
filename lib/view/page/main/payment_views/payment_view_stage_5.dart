import 'package:bayi_geliyo_mobile_application/controller/extension/bool_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/datetime_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/paid_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/colors.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentViewStage5 extends StatefulWidget {
  const PaymentViewStage5({super.key, required this.callback});
  final BoolCallback callback;

  @override
  State<PaymentViewStage5> createState() => _PaymentViewStage5State();
}

class _PaymentViewStage5State extends State<PaymentViewStage5> {
  final ValueNotifier<PaymentType?> _selectedPaymentTypeNotifier = ValueNotifier<PaymentType?>(null);
  final ValueNotifier<LimitTimeType?> _selectedLimitTimeTypeNotifier = ValueNotifier<LimitTimeType?>(null);
  final ValueNotifier<DateTime?> _selectedLimitedDateTimeNotifier = ValueNotifier<DateTime?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _selectedLimitTimeTypeNotifier.dispose();
    _selectedPaymentTypeNotifier.dispose();
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
          Text("credit_card".tr()).wrapPadding(bottom: AppDecoration.padding),
          ValueListenableBuilder(
            valueListenable: _selectedPaymentTypeNotifier,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: PaymentType.values.map(
                  (e) {
                    return Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(AppDecoration.radius),
                          border: Border.all(color: shadowColor()),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _selectedPaymentTypeNotifier.value == e,
                              onChanged: (value) {
                                if (_selectedPaymentTypeNotifier.value == e) {
                                  _selectedPaymentTypeNotifier.value = null;
                                } else {
                                  _selectedPaymentTypeNotifier.value = e;
                                }
                              },
                            ),
                            Text(e.name.tr())
                          ],
                        ),
                      ).wrapPadding(right: (PaymentType.values.indexOf(e) == 0 ? AppDecoration.padding : 0)).onTap(
                        () {
                          if (_selectedPaymentTypeNotifier.value == e) {
                            _selectedPaymentTypeNotifier.value = null;
                          } else {
                            _selectedPaymentTypeNotifier.value = e;
                          }
                        },
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ).wrapPadding(bottom: AppDecoration.padding),
          Text("set_to_param".tr(args: ["limit".tr()])).wrapPadding(bottom: AppDecoration.padding),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(AppDecoration.radius),
              border: Border.all(color: shadowColor()),
            ),
            child: ValueListenableBuilder(
                valueListenable: _selectedLimitTimeTypeNotifier,
                builder: (context, _, __) {
                  return DropdownButton(
                    items: LimitTimeType.values.map(
                      (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.name.tr(), style: context.textTheme.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: 0.7))),
                        );
                      },
                    ).toList(),
                    hint: Text(
                        "selection_to_param".tr(args: [
                          "duration_of_param".tr(args: ["limit".tr()])
                        ]),
                        style: context.textTheme.bodyMedium?.copyWith(color: Colors.black.withValues(alpha: .50))),
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Icon(FontAwesomeIcons.chevronDown, size: 15),
                    dropdownColor: context.theme.scaffoldBackgroundColor,
                    value: _selectedLimitTimeTypeNotifier.value,
                    onChanged: (value) async {
                      if (value != null) {
                        if (value.hasLimit()) {
                          await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2099),
                          ).then((date) {
                            if (date != null) {
                              _selectedLimitedDateTimeNotifier.value = date;
                              _selectedLimitTimeTypeNotifier.value = value;
                            } else {
                              _selectedLimitedDateTimeNotifier.value = null;
                              _selectedLimitTimeTypeNotifier.value = null;
                            }
                          });
                        } else {
                          _selectedLimitedDateTimeNotifier.value = null;
                          _selectedLimitTimeTypeNotifier.value = value;
                        }
                        setState(() {});
                      }
                    },
                  ).wrapPaddingSymetric(horizontal: 12);
                }),
          ).wrapPadding(bottom: AppDecoration.padding * 0.5),
          if (_selectedLimitTimeTypeNotifier.value != null && _selectedLimitedDateTimeNotifier.value != null)
            Text(
              _selectedLimitedDateTimeNotifier.value!.format(context, query: "dd.MM.yyyy"),
              style: context.textTheme.bodyMedium?.copyWith(color: context.colors.surface),
            ).wrapPadding(left: 10)
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
    if (_selectedLimitTimeTypeNotifier.value != null && _selectedPaymentTypeNotifier.value != null) {
      //
      FocusScope.of(context).unfocus();
      //
      PaidHandler.instance.baseModel.limitTimeType = _selectedLimitTimeTypeNotifier.value;
      PaidHandler.instance.baseModel.limitDateTime = _selectedLimitedDateTimeNotifier.value;
      PaidHandler.instance.baseModel.paymentType = _selectedPaymentTypeNotifier.value;
      //
      widget.callback.call(true);
      //
      _selectedLimitTimeTypeNotifier.value = null;
      _selectedPaymentTypeNotifier.value = null;
    } else {
      AppDialog.banner("please_fill_required_areas".tr(), dialogType: AppDialogType.failed);
    }
  }
}
