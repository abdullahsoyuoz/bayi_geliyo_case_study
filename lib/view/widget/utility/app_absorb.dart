import 'package:flutter/material.dart';

class AppAbsorb extends StatelessWidget {
  const AppAbsorb({super.key, required this.child, required this.absorb, this.transparent = true});
  final Widget child;
  final bool absorb;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorb,
      child: Opacity(
          opacity: absorb
              ? transparent
                  ? 0.2
                  : 0
              : 1,
          child: child),
    );
  }
}
