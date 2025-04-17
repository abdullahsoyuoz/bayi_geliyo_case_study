// ignore_for_file: unnecessary_string_interpolations

import 'package:bayi_geliyo_mobile_application/controller/extension/duration_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  bool get isToday => (day == DateTime.now().day && month == DateTime.now().month && year == DateTime.now().year);
  DateTime addDays(int quantity) => add(Duration(days: quantity));
  bool isFuture() => isAfter(DateTime.now());
  bool isPast() => isBefore(DateTime.now());
  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;
  bool isSameTime(DateTime other) => microsecondsSinceEpoch == other.microsecondsSinceEpoch;
  String getDayString(BuildContext context, {bool short = false}) => (short) ? DateFormatWithLocale.locale(context, 'EE').format(this) : DateFormatWithLocale.locale(context, 'EEEE').format(this);
  String format(BuildContext context, {String query = 'dd.MM.yyyy - HH:mm', bool todayString = false, bool todayStringLong = false}) {
    // DateFormat formatBase = DateFormat(query);
    DateFormat formatBase = DateFormatWithLocale.locale(context, query);
    if (todayString) {
      try {
        if (addDays(1).isToday) {
          if (todayStringLong) {
            return "${'yesterday'.tr()} - ${formatBase.format(this)}";
          } else {
            return "${'yesterday'.tr()}";
          }
        } else if (isToday) {
          if (todayStringLong) {
            return "${'today'.tr()} - ${formatBase.format(this)}";
          } else {
            return "${'today'.tr()}";
          }
        } else if (addDays(-1).isToday) {
          if (todayStringLong) {
            return "${'tomorrow'.tr()} - ${formatBase.format(this)}";
          } else {
            return "${'tomorrow'.tr()}";
          }
        } else {
          return formatBase.format(this);
        }
      } on Exception catch (e) {
        return '$e';
      }
    } else {
      return formatBase.format(this);
    }
  }

  String distance(BuildContext context, DateTime other) {
    int differenceInMilliseconds = other.millisecondsSinceEpoch - millisecondsSinceEpoch;
    return Duration(milliseconds: differenceInMilliseconds).counttimerHolder();
  }

  Duration distanceDuration(BuildContext context, DateTime other) {
    int differenceInMilliseconds = other.millisecondsSinceEpoch - millisecondsSinceEpoch;
    return Duration(milliseconds: differenceInMilliseconds);
  }

  bool greaterThanInSecond(DateTime other, int second) => differenceDuration(other).inSeconds >= second;
  bool greaterThanInMinute(DateTime other, int minute) => differenceDuration(other).inMinutes >= minute;
  bool greaterThanInHour(DateTime other, int hour) => differenceDuration(other).inHours >= hour;
  Duration differenceDuration(DateTime other) => difference(other);
}

extension DateFormatWithLocale on DateFormat {
  static DateFormat locale(BuildContext context, String pattern) {
    final Locale locale = context.locale;
    // ignore: unnecessary_null_comparison
    if (locale != null) {
      return DateFormat(pattern, locale.toString());
    } else {
      return DateFormat(pattern);
    }
  }
}
