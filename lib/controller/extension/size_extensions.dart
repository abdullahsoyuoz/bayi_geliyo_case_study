import 'package:flutter/material.dart';

extension SizeExtensions on Size {
  Size rescale({double scale = 0.1}) => Size(width * scale, height * scale);
}
