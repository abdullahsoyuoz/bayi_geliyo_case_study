import 'package:bayi_geliyo_mobile_application/controller/extension/bool_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/color_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/handler/paid_handler.dart';
import 'package:bayi_geliyo_mobile_application/controller/model/languages.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/colors.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validatorless/validatorless.dart';

class PaymentViewStage2 extends StatefulWidget {
  const PaymentViewStage2({super.key, required this.callback});
  final BoolCallback callback;

  @override
  State<PaymentViewStage2> createState() => _PaymentViewStage2State();
}

class _PaymentViewStage2State extends State<PaymentViewStage2> {
  late TextEditingController _linkTitleController;
  late FocusNode _linkTitleNode;
  late TextEditingController _linkDescriptionController;
  late FocusNode _linkDescriptionNode;
  final ValueNotifier<String?> _selectedLanguageNotifier = ValueNotifier<String?>(null);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _linkTitleController = TextEditingController();
    _linkTitleNode = FocusNode();
    _linkDescriptionController = TextEditingController();
    _linkDescriptionNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _linkTitleController.dispose();
    _linkTitleNode.dispose();
    _linkDescriptionController.dispose();
    _linkDescriptionNode.dispose();
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
              Text("settings_param".tr(args: ["link".tr()])).wrapPadding(bottom: AppDecoration.padding),
              TextFormField(
                controller: _linkTitleController,
                focusNode: _linkTitleNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: "title_of_param".tr(args: ["link".tr()])),
                validator: Validatorless.multiple([Validatorless.required("")]),
              ).wrapPadding(bottom: AppDecoration.padding),
              TextField(
                controller: _linkDescriptionController,
                focusNode: _linkDescriptionNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(hintText: "${"description".tr()} (${"optional".tr()})"),
              ).wrapPadding(bottom: AppDecoration.padding),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(AppDecoration.radius),
                  border: Border.all(color: shadowColor()),
                ),
                child: ValueListenableBuilder(
                    valueListenable: _selectedLanguageNotifier,
                    builder: (context, _, __) {
                      return DropdownButton(
                        items: languageList().map(
                          (e) {
                            return DropdownMenuItem(
                              value: e.title,
                              child: Text(e.title, style: context.textTheme.bodyMedium),
                            );
                          },
                        ).toList(),
                        hint: Text("selection_to_param".tr(args: ["language".tr()]), style: context.textTheme.bodyMedium),
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: Icon(FontAwesomeIcons.chevronDown, size: 15),
                        dropdownColor: context.theme.scaffoldBackgroundColor,
                        value: _selectedLanguageNotifier.value,
                        onChanged: (value) => _selectedLanguageNotifier.value = value,
                      ).wrapPaddingSymetric(horizontal: 12);
                    }),
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
    if (_linkTitleController.text.isNotEmpty && _selectedLanguageNotifier.value != null && _selectedLanguageNotifier.value!.isNotEmpty && _formKey.currentState!.validate()) {
      //
      FocusScope.of(context).unfocus();
      //
      PaidHandler.instance.baseModel.linkTitle = _linkTitleController.text;
      PaidHandler.instance.baseModel.linkDescription = _linkDescriptionController.text;
      PaidHandler.instance.baseModel.language = _selectedLanguageNotifier.value;
      //
      widget.callback.call(true);
      //
      _linkTitleController.clear();
      _linkDescriptionController.clear();
      _selectedLanguageNotifier.value = null;
    } else {
      AppDialog.banner("please_fill_required_areas".tr(), dialogType: AppDialogType.failed);
    }
  }
}
