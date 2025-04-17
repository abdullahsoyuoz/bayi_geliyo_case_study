import 'dart:io';
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/int_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/model/languages.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/button.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/utility/custom_appbar.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageChangerButton extends StatefulWidget {
  final bool isExtend;

  const LanguageChangerButton({super.key}) : isExtend = false;
  const LanguageChangerButton.extend({super.key}) : isExtend = true;

  @override
  State<LanguageChangerButton> createState() => _LanguageChangerButtonState();
}

class _LanguageChangerButtonState extends State<LanguageChangerButton> {
  AppLanguage? currentLanguage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isExtend) {
      return FilledButton(
        style: context.theme.filledButtonTheme.style?.copyWith(padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [Image.asset(languageList().firstWhere((element) => element.locale.languageCode == context.locale.languageCode).icon, width: 40), Text(languageList().firstWhere((element) => element.locale.languageCode == context.locale.languageCode).title).wrapPaddingSymetric(horizontal: 5)]).wrapPaddingAll(1),
        /* padding: EdgeInsets.zero,
      iconSize: 30, */
        onPressed: () {
          routingLangChange(context);
        },
      );
    } else {
      return IconButton(
        style: context.theme.filledButtonTheme.style?.copyWith(backgroundColor: const WidgetStatePropertyAll(Colors.transparent), padding: const WidgetStatePropertyAll(EdgeInsets.zero), fixedSize: const WidgetStatePropertyAll(Size.square(30))),
        icon: Image.asset(languageList().firstWhere((element) => element.locale.languageCode == context.locale.languageCode).icon, width: 30),
        onPressed: () {
          routingLangChange(context);
        },
      );
    }
  }
}

void routingLangChange(BuildContext context) {
  Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CustomAppBar(title: Text("change_param".tr(args: ["language".tr()])), automaticallyImplyLeading: false),
            bottomNavigationBar: FilledButton(
              onPressed: () async {
                bool isNativeCheck = false;
                languageList().forEach((element) {
                  if (context.locale == element.locale) {
                    isNativeCheck = element.isNative;
                  }
                });
                if (!isNativeCheck) {
                  await AppDialog.dialog("language_change_hint".tr(), dialogType: AppDialogType.info).then((value) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  });
                } else {
                  sleep(100.millisecond());
                  Navigator.pop(context);
                }
              },
              style: AppButtonStyle.standart(context),
              child: Text("confirm".tr()),
            ).wrapPaddingAll(AppDecoration.padding),
            body: ListView.builder(
              padding: context.paddingForList,
              itemCount: languageList().length,
              itemBuilder: (context, index) {
                final e = languageList()[index];
                return FilledButton(
                  onPressed: () async {
                    // ignore: invalid_use_of_protected_member
                    context.setLocale(e.locale);
                  },
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(context.theme.scaffoldBackgroundColor), foregroundColor: WidgetStatePropertyAll(context.colors.onSurface)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            // SizedBox(width: context.width * 0.15, child: Text("#${index + 1}").wrapPadding(right: AppDecoration.padding)),
                            Image.asset(e.icon, width: 36),
                            Expanded(child: Text(e.title).wrapPadding(left: 10)),
                          ],
                        ),
                      ),
                      if (context.locale == e.locale) Text("selected".tr()),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    ),
  );
}
