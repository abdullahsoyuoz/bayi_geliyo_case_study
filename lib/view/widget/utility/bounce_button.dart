import 'package:bayi_geliyo_mobile_application/controller/extension/int_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bouncing_widgets/flutter_bouncing_widgets.dart';

class AppBounce extends StatefulWidget {
  const AppBounce({
    super.key,
    this.child,
    this.onPressed,
    this.isScrollable,
    this.canReverse,
    this.scaleFactor,
    this.disableDuration,
    this.duration,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final bool? isScrollable;
  final bool? canReverse;
  final double? scaleFactor;
  final Duration? disableDuration;
  final Duration? duration;

  @override
  State createState() => _AppBounceState();
}

class _AppBounceState extends State<AppBounce> {
  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return CustomBounceWidget(
      onPressed: () async {
        if (!_isDisabled) {
          widget.onPressed?.call();
          await _disableButton();
        } else {
          null;
        }
      },
      duration: widget.duration ?? 300.millisecond(),
      scaleFactor: widget.scaleFactor ?? 1,
      isScrollable: widget.isScrollable ?? true,
      canReverse: widget.canReverse ?? true,
      child: widget.child ?? SizedBox(),
    );
  }

  Future<void> _disableButton() async {
    setState(() {
      _isDisabled = true;
    });
    await Future.delayed(widget.disableDuration ?? const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isDisabled = false;
        });
      }
    });
  }
}
