/* // ignore_for_file: unnecessary_new
import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/model/filter_model.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/dialog/dialog.dart';
import 'package:bayi_geliyo_mobile_application/view/widget/filter/filter_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

String _getDialogSubmitTitle(AppDialogType dialogType) {
  switch (dialogType) {
    case AppDialogType.success:
      return 'okay';
    case AppDialogType.info:
      return 'understand';
    case AppDialogType.warning:
      return 'accept';
    case AppDialogType.failed:
      return 'okay';
    default:
      return 'okay';
  }
}

Future appFilterDialog(
  BuildContext context, {
  bool onWillPop = true,
  FilterDataModel? model,
  String routeName = 'filter dialog',
  Color? barrierColor,
  AppDialogConfiguration? configuration,
}) {
  double radius = 20;
  barrierColor = barrierColor ?? context.colors.primary;
  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    barrierDismissible: onWillPop,
    routeSettings: RouteSettings(name: routeName),
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return BackdropFilter(
          filter: ColorFilter.mode(Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.75), BlendMode.srcOver),
          child: Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 10,
            shadowColor: const Color.fromARGB(180, 0, 0, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppFilterView(
                        parentFilter: parentFilter,
                        callback: (value) {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(configuration?.radius ?? 20 * 0.5)))),
                                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return Colors.greenAccent.shade700;
                                    } else {
                                      return Colors.greenAccent.shade700;
                                      // return Theme.of(context).scaffoldBackgroundColor;
                                    }
                                  }),
                                ),
                                child: Center(child: Text((configuration?.submitTitle ?? _getDialogSubmitTitle(AppDialogType.success)).tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium!.color!))),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context, false),
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(configuration?.radius ?? 20 * 0.5)))),
                                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return Theme.of(context).textTheme.bodyMedium!.color!;
                                    } else {
                                      return Theme.of(context).scaffoldBackgroundColor;
                                    }
                                  }),
                                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return Theme.of(context).scaffoldBackgroundColor;
                                    } else {
                                      return Theme.of(context).textTheme.bodyMedium!.color!;
                                    }
                                  }),
                                ),
                                child: Center(child: Text(context.tr(configuration?.cancelTitle ?? 'cancel'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        );
      });
    },
  ).then((value) {
    if (value != null && model != null) {
      model.debugPrintFilterDataModel();
    }
  });
}
 */
