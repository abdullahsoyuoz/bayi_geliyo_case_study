import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/datetime_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/decoration.dart';
import 'package:bayi_geliyo_mobile_application/controller/style/input.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AppInputType { date }

typedef StringCallback = void Function(String value);
typedef DateTimeCallback = void Function(DateTime value);

class AppInput extends StatefulWidget {
  final AppInputType type;
  final bool enabled;
  final DateTime? initialDate;
  final String? label;
  final DateTimeCallback? callback;
  final bool followedTimeSelection;
  const AppInput.date({super.key, this.enabled = true, this.label, this.initialDate, this.callback, this.followedTimeSelection = true}) : type = AppInputType.date;
  // const AppInput.number({super.key, this.enabled = true, this.label}) : type = AppInputType.number;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.initialDate != null) {
        if (widget.followedTimeSelection) {
          controller.text = widget.initialDate!.format(context, query: 'dd.MM.yyyy HH:mm');
        } else {
          controller.text = widget.initialDate!.format(context, query: 'dd.MM.yyyy');
        }
        setState(() {});
      }
      node.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (context) {
            switch (widget.type) {
              case AppInputType.date:
                return TextFormField(
                  enabled: true,
                  readOnly: true,
                  controller: controller,
                  focusNode: node,
                  textInputAction: TextInputAction.next,
                  style: context.textTheme.bodyLarge?.copyWith(color: widget.enabled ? context.colors.onSurface : context.colors.primary),
                  decoration: InputDecoration(
                    enabledBorder: AppInputDecoration.noneBorder(),
                    focusedBorder: AppInputDecoration.noneBorder(),
                    labelText: "enter_of_param".tr(args: [widget.label ?? 'date'.tr()]),
                    labelStyle: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurface.withValues(alpha: .2)),
                    suffixIcon:
                        (controller.text.isNotEmpty && widget.enabled)
                            ? IconButton(
                              style: context.theme.iconButtonTheme.style?.copyWith(backgroundColor: const WidgetStatePropertyAll(Colors.transparent)),
                              onPressed: () {
                                controller.clear();
                                setState(() {});
                              },
                              icon: Icon(FontAwesomeIcons.eraser, size: AppDecoration.padding, color: context.colors.onSurface),
                            )
                            : const SizedBox(),
                  ),
                  onTap: () async {
                    if (widget.enabled == false) {
                      AppDialog.banner('Bu Alan Değiştirilemez', dialogType: AppDialogType.failed);
                    } else {
                      await showDatePicker(context: context, firstDate: DateTime(0), lastDate: DateTime.now()).then((dateTimeValue) async {
                        if (dateTimeValue != null) {
                          DateTime? combinedDateTime;
                          if (!widget.followedTimeSelection) {
                            combinedDateTime = DateTime(dateTimeValue.year, dateTimeValue.month, dateTimeValue.day);
                          } else {
                            // ignore: use_build_context_synchronously
                            await showTimePicker(context: context, initialTime: TimeOfDay.now()).then((timeOfDayValue) {
                              if (timeOfDayValue != null) {
                                combinedDateTime = DateTime(dateTimeValue.year, dateTimeValue.month, dateTimeValue.day, timeOfDayValue.hour, timeOfDayValue.minute);
                              }
                            });
                          }
                          if (widget.followedTimeSelection) {
                            // ignore: use_build_context_synchronously
                            controller.text = combinedDateTime!.format(context, query: 'dd.MM.yyyy HH:mm');
                          } else {
                            // ignore: use_build_context_synchronously
                            controller.text = combinedDateTime!.format(context, query: 'dd.MM.yyyy');
                          }
                          widget.callback?.call(combinedDateTime!);
                        }
                      });
                    }
                  },
                );
            }
          },
        ),
      ],
    );
  }
}
