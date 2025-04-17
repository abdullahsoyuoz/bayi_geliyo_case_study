import 'dart:math';

import 'package:bayi_geliyo_mobile_application/controller/constant/asset.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/bool_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/double_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/paid_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/colors.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentViewStage6 extends StatefulWidget {
  const PaymentViewStage6({super.key, required this.callback});
  final BoolCallback callback;

  @override
  State<PaymentViewStage6> createState() => _PaymentViewStage6State();
}

class _PaymentViewStage6State extends State<PaymentViewStage6> {
  final ValueNotifier<List<bool>> _selectedPosNotifier = ValueNotifier<List<bool>>(List.generate(3, (index) => false));
  List<double> posValues = List.generate(3, (index) => (Random().nextInt(4) + 1) + Random().nextDouble().toDoubleAsFixed());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _selectedPosNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(PaidHandler.instance.baseModel.toString());

    return Scaffold(
      bottomNavigationBar: _bottomNowBar(context),
      body: ListView(
        controller: ScrollController(initialScrollOffset: -context.height),
        padding: EdgeInsets.all(AppDecoration.padding),
        children: [
          Text("selection_to_param".tr(args: ["POS"])).wrapPadding(bottom: AppDecoration.padding),
          ValueListenableBuilder(
            valueListenable: _selectedPosNotifier,
            builder: (context, value, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(AppDecoration.radius),
                      border: Border.all(color: shadowColor()),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _selectedPosNotifier.value[index],
                          onChanged: (value) {
                            setState(() {
                              _selectedPosNotifier.value[index] = value ?? false;
                            });
                          },
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: context.theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(AppDecoration.radius),
                            border: Border.all(color: shadowColor()),
                          ),
                          child: Image.asset(AppIcon.images.path, width: 40, height: 40).wrapPaddingAll(5),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(text: "POS ${index + 1}", style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                                if (index == 0) TextSpan(text: " (${"suggestion".tr()})", style: context.textTheme.bodySmall?.copyWith(color: context.colors.primaryContainer.increaseLuminance(factor: .6))),
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(text: "1-12 taksit / %${posValues[index]}'dan oranlar", style: context.textTheme.bodySmall?.copyWith(color: context.colors.surface)),
                              ])),
                            ],
                          ).wrapPaddingSymetric(horizontal: 10),
                        ),
                        Icon(FontAwesomeIcons.chevronDown, size: 15, color: context.colors.surface).wrapPadding(right: AppDecoration.padding)
                      ],
                    ).onTap(
                      () {
                        setState(() {
                          _selectedPosNotifier.value[index] = !_selectedPosNotifier.value[index];
                        });
                      },
                    ).wrapPaddingSymetric(vertical: AppDecoration.padding * 0.5),
                  ).wrapPadding(bottom: AppDecoration.padding);
                },
              );
            },
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
    bool selected = false;
    for (var element in _selectedPosNotifier.value) {
      selected = selected || element;
    }
    if (selected) {
      PaidHandler.instance.baseModel.posSelection = _selectedPosNotifier.value;
      //
      widget.callback.call(true);
      //
      _selectedPosNotifier.value = List.generate(3, (index) => false);
    } else {
      AppDialog.banner("please_make_at_least_one_selection".tr(), dialogType: AppDialogType.failed);
    }
  }
}
