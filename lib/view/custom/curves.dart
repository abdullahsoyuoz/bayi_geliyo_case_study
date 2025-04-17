import 'package:flutter/animation.dart';
import 'dart:math';

class AppCurves {
  static Curve sine({double count = 3}) => _SineCurve(count: count);
  static Curve spring({double a = 0.15, double w = 19.4}) => _SpringCurve(a: a, w: w);
  static Curve springReverse({double a = 0.15, double w = 19.4}) => _ReverseSpringCurve(a: a, w: w);
  static Curve square() => _SquareCurve();
  static Curve smoothStep() => _SmoothStepCurve();
  static Curve decay({double velocity = 1.0, double overDamping = 10.0}) => _DecayCurve(overDamping: overDamping, velocity: velocity);
  static Curve overshoot({double tension = 0.0}) => _OvershootCurve(tension: tension);
  static Curve flicker({double amplitude = 0.15, double frequency = 19.4}) => _FlickerCurve(amplitude: amplitude, frequency: frequency);
}

class _SineCurve extends Curve {
  final double count;
  const _SineCurve({this.count = 3});
  @override
  double transformInternal(double t) => sin(count * 2 * pi * t) * 0.5 + 0.5;
}

class _SpringCurve extends Curve {
  const _SpringCurve({this.a = 0.15, this.w = 19.4});
  final double a;
  final double w;
  @override
  double transformInternal(double t) => -(pow(e, -t / a) * cos(t * w)) + 1;
}

class _ReverseSpringCurve extends Curve {
  const _ReverseSpringCurve({this.a = 0.15, this.w = 19.4});
  final double a;
  final double w;
  @override
  double transformInternal(double t) => 1 - (-(pow(e, -(1 - t) / a) * cos((1 - t) * w)) + 1);
}

class _SquareCurve extends Curve {
  @override
  double transformInternal(double t) => t < 0.5 ? 0.0 : 1.0;
}

class _DecayCurve extends Curve {
  final double velocity;
  final double overDamping;
  const _DecayCurve({this.velocity = 1.0, this.overDamping = 10.0});
  @override
  double transformInternal(double t) {
    final double damping = 1.0 / (overDamping * sqrt(1 - pow(overDamping, 2)));
    final double delta = -velocity * damping;
    return pow(e, delta * t) * cos(sqrt(1 - pow(overDamping, 2)) * t + atan(1 / overDamping)) + 1.0;
  }
}

class _OvershootCurve extends Curve {
  final double tension;
  const _OvershootCurve({this.tension = 0.0});
  @override
  double transformInternal(double t) {
    final double s = tension * 1.5;
    final double a = t - 1.0;
    return pow(a, 3) + a * s + 1.0;
  }
}

class _SmoothStepCurve extends Curve {
  @override
  double transformInternal(double t) => t * t * (3 - 2 * t);
}

class _FlickerCurve extends Curve {
  const _FlickerCurve({this.amplitude = 0.15, this.frequency = 19.4});

  final double amplitude;
  final double frequency;

  @override
  double transformInternal(double t) {
    final random = Random();
    final flickerAmount = random.nextDouble() * 0.5;
    final flickerOffset = random.nextDouble() * 2.0 - 1.0;
    return t + flickerOffset * flickerAmount;
  }
}
