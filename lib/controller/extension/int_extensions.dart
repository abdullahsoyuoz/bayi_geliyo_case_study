import 'dart:math';

extension IntExtensions on int {
  Duration hour() => Duration(hours: this);
  Duration minute() => Duration(minutes: this);
  Duration second() => Duration(seconds: this);
  Duration millisecond() => Duration(milliseconds: this);
  int random({int min = 0}) => min + Random().nextInt(this - min + 1);
  bool modular(int times) => this % times == 0;
  int length() => toString().length;
}
