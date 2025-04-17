import 'dart:math';

import 'package:easy_localization/easy_localization.dart';

extension DoubleExtensions on double {
  double toDegrees() => this * 180 / pi;
  double toRadians() => this * pi / 180;
  double toDoubleAsFixed({int digit = 2}) => double.parse(toStringAsFixed(digit));
  String addCurrencySymbolBefore({String currencySymbol = 'TL', int digit = 2}) => '$currencySymbol ${toStringAsFixed(digit)}';
  String addCurrencySymbolAfter({String currencySymbol = 'TL', int digit = 2}) => '${toStringAsFixed(digit)} $currencySymbol';
  bool isInRange(double start, double end) => this >= start && this <= end;
  double random({int min = 0}) => this * Random().nextDouble().toDoubleAsFixed();
  double rounder({bool upper = true}) => upper ? ceilToDouble() : roundToDouble();

  String percentage({int percentageOf = 100, bool percentageString = true, bool round = true}) {
    if (percentageString) {
      if (round) {
        return "%${((toDouble() / percentageOf) * 100).round()}";
      } else {
        return "%${((toDouble() / percentageOf) * 100)}";
      }
    } else {
      if (round) {
        return "${((toDouble() / percentageOf) * 100).round()}";
      } else {
        return "${((toDouble() / percentageOf) * 100)}";
      }
    }
  }

  double reduceFloat({double comingMin = 0, double comingMax = 100}) => (this - comingMin) * (1 - 0) / (comingMax - comingMin) + 0;
  int reduceDivision({int division = 5, double comingMin = 0, double comingMax = 100}) => (reduceFloat(comingMin: comingMin, comingMax: comingMax) * division).floor().clamp(1, division);
  double reduceDivisionHalf({int division = 5, double comingMin = 0, double comingMax = 100}) {
    for (int i = 0; i <= division * 2; i++) {
      if (reduceFloat(comingMin: comingMin, comingMax: comingMax) <= i * 0.5 / division) {
        return i * 0.5;
      }
    }
    return division.toDouble();
  }

  String getCurrency() {
    return NumberFormat.currency(locale: "it", symbol: "TL").format(this);
  }
}
