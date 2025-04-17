import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/int_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/widget_extensions.dart';
import 'package:bayi_geliyo_mobile_application/view/custom/curves.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef CheckCallback = void Function(bool value);

class PasswordFilter extends StatefulWidget {
  const PasswordFilter({super.key, required this.child, required this.controller, required this.focusNode, required this.validate, this.direction = Direction.forward});

  final Widget child;
  final TextEditingController controller;
  final FocusNode focusNode;
  final CheckCallback validate;
  final Direction direction;

  @override
  // ignore: library_private_types_in_public_api
  _PasswordFilterState createState() => _PasswordFilterState();
}

class _PasswordFilterState extends State<PasswordFilter> {
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumeric = false;
  bool hasSpecialCharacter = false;
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkPassword);
    widget.focusNode.addListener(_checkPassword);
  }

  void _checkPassword() {
    final text = widget.controller.text;
    if (mounted) {
      setState(() {
        hasUpperCase = text.contains(RegExp(r'[A-Z]'));
        hasLowerCase = text.contains(RegExp(r'[a-z]'));
        hasNumeric = text.contains(RegExp(r'[0-9]'));
        hasSpecialCharacter = text.contains(RegExp(r'[@#$!%*?&\-_.,()/+-]'));
        hasMinLength = text.length >= 8;
      });
    }
    widget.validate(hasUpperCase && hasLowerCase && hasNumeric && hasSpecialCharacter && hasMinLength);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.direction == Direction.reverse) widget.child,
        AnimatedContainer(
          duration: 300.millisecond(),
          alignment: Alignment.centerLeft,
          child: AnimatedCrossFade(
            duration: 300.millisecond(),
            alignment: Alignment.centerLeft,
            crossFadeState: widget.focusNode.hasFocus ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstCurve: AppCurves.overshoot(),
            sizeCurve: AppCurves.overshoot(),
            secondCurve: AppCurves.overshoot(),
            firstChild: Column(
              children: [
                buildCheckRow("uppercase".tr(), hasUpperCase),
                buildCheckRow("lowercase".tr(), hasLowerCase),
                buildCheckRow("numeric_character".tr(), hasNumeric),
                buildCheckRow("special_character_param".tr(args: ["@#\$!%*?&\\-_.,()/+-"]), hasSpecialCharacter),
                buildCheckRow("at_least_characters".tr(args: ['8']), hasMinLength),
              ],
            ),
            secondChild: const SizedBox(),
          ),
        ),
        if (widget.direction == Direction.forward) widget.child,
      ],
    );
  }

  Widget buildCheckRow(String label, bool value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [SizedBox(width: 20, child: Center(child: Icon(value ? FontAwesomeIcons.solidCircleCheck : FontAwesomeIcons.solidCircleQuestion, size: 20, color: value ? context.colors.primaryContainer : context.theme.scaffoldBackgroundColor))).wrapPadding(right: 10), Expanded(child: Text(label, style: context.textTheme.bodyMedium?.copyWith(height: 0)))]).wrapPadding(top: 10);
  }
}
