import 'package:flutter/material.dart';

class ClipperAnimationBase extends CustomClipper<Path> {
  ClipperAnimationBase(this.animation) : super(reclip: animation) {
    curve = CurvedAnimation(parent: animation, curve: Curves.ease);
  }
  late Animation<double> animation;
  late Animation curve;
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ClipperBase extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
