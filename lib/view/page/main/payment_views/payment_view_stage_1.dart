import 'package:bayi_geliyo_mobile_application/controller/constant/formatter.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/bool_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/paid_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class PaymentViewStage1 extends StatefulWidget {
  const PaymentViewStage1({super.key, required this.callback});
  final BoolCallback callback;

  @override
  State<PaymentViewStage1> createState() => _PaymentViewStage1State();
}

class _PaymentViewStage1State extends State<PaymentViewStage1> {
  final TextEditingController _nameSurnameController = TextEditingController();
  final FocusNode _nameSurnameNode = FocusNode();
  final TextEditingController _mailController = TextEditingController();
  final FocusNode _mailNode = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _nameSurnameController.dispose();
    _nameSurnameNode.dispose();
    _mailController.dispose();
    _mailNode.dispose();
    _phoneController.dispose();
    _phoneNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: _bottomNowBar(context),
        body: Form(
          key: _formKey,
          child: ListView(
            controller: ScrollController(initialScrollOffset: -context.height),
            padding: EdgeInsets.all(AppDecoration.padding),
            children: [
              Text("info_of_param".tr(args: ["recipient".tr()])).wrapPadding(bottom: AppDecoration.padding),
              TextField(
                controller: _nameSurnameController,
                focusNode: _nameSurnameNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: "name_surname".tr()),
              ).wrapPadding(bottom: AppDecoration.padding),
              TextFormField(
                controller: _mailController,
                focusNode: _mailNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "mail_address".tr(),
                ),
                validator: Validatorless.multiple([Validatorless.email("")]),
              ).wrapPadding(bottom: AppDecoration.padding),
              TextFormField(
                controller: _phoneController,
                focusNode: _phoneNode,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true),
                inputFormatters: [AppFormatter.phone],
                decoration: InputDecoration(hintText: "mobile_phone".tr()),
                validator: Validatorless.multiple([Validatorless.length(17, "")]),
              ),
            ],
          ),
        ),
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
    if (_nameSurnameController.text.isNotEmpty && _mailController.text.isNotEmpty && _phoneController.text.isNotEmpty && _formKey.currentState!.validate()) {
      //
      FocusScope.of(context).unfocus();
      //
      PaidHandler.instance.baseModel.nameSurname = _nameSurnameController.text;
      PaidHandler.instance.baseModel.email = _mailController.text;
      PaidHandler.instance.baseModel.phone = _phoneController.text;
      //
      widget.callback.call(true);
      //
      _nameSurnameController.clear();
      _mailController.clear();
      _phoneController.clear();
    } else {
      AppDialog.banner("please_fill_required_areas".tr(), dialogType: AppDialogType.failed);
    }
  }
}
