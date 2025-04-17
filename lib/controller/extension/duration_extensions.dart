// ignore_for_file: unnecessary_string_interpolations

import 'package:bayi_geliyo_mobile_application/controller/extension/context_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/int_extensions.dart';
import 'package:bayi_geliyo_mobile_application/controller/extension/string_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DurationExtension on Duration {
  String lastHolder({bool showMinute = true, bool showHour = true}) {
    final days = (inDays.abs()).toString();
    final hours = (inHours.abs()).remainder(24).toString().padLeft(2, '0');
    final minutes = (inMinutes.abs()).remainder(60).toString().padLeft(2, '0');

    String result = '${"last".tr()} ';

    if (int.tryParse(days)! > 0) {
      result += '$days ${'day'.tr()} ';
    }
    if (int.tryParse(hours)! > 0) {
      result += '$hours ${'hour_on_time'.tr()} ';
    }
    if ((int.tryParse(minutes)! > 0) && (int.tryParse(days)! < 0)) {
      result += '$minutes ${'minute_on_time'.tr()} ';
    }
    return result;
  }

  String counttimerHolder() {
    final days = (inDays.abs()).toString();
    final hours = (inHours.abs()).remainder(24).toString().padLeft(2, '0');
    final minutes = (inMinutes.abs()).remainder(60).toString().padLeft(2, '0');
    final seconds = (inSeconds.abs()).remainder(60).toString().padLeft(2, '0');

    String result = '';

    if (int.tryParse(days)! > 0) {
      result += '$days ${'day_abbr'.tr()} ';
    }
    if (int.tryParse(hours)! > 0) {
      result += '$hours ${'hour_abbr'.tr()} ';
    }
    if (int.tryParse(minutes)! > 0) {
      result += '$minutes ${'minute_abbr'.tr()} ';
    }
    result += '$seconds ${'second_abbr'.tr()}';
    return result;
  }

  static RichText counttimerHolderRichtext(BuildContext context, Duration duration) {
    final days = duration.inDays.abs();
    final hours = duration.inHours.abs().remainder(24).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.abs().remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.abs().remainder(60).toString().padLeft(2, '0');

    Color keyColor = context.colors.onSurface.withValues(alpha: .25);
    Color valueColor = context.colors.onSurface;

    final text = TextSpan(
      children: [
        if (days > 0) TextSpan(text: '${'\t'.repeat(4 - days.length())}$days ', style: context.textTheme.bodyLarge?.copyWith(height: 1, fontWeight: FontWeight.bold, color: valueColor)),
        if (days > 0) TextSpan(text: '${'day_abbr'.tr()}\n', style: context.textTheme.bodyLarge?.copyWith(height: 1, fontWeight: FontWeight.bold, color: keyColor)),
        if (int.tryParse(hours)! > 0) TextSpan(text: '${'\t'.repeat(days.length())}$hours ', style: context.textTheme.bodyLarge?.copyWith(height: 1, fontWeight: FontWeight.bold, color: valueColor)),
        if (int.tryParse(hours)! > 0) TextSpan(text: '${'hour_abbr'.tr()}\n', style: context.textTheme.bodyLarge?.copyWith(height: 1, fontWeight: FontWeight.bold, color: keyColor)),
        if (int.tryParse(minutes)! > 0) TextSpan(text: '${'\t'.repeat(days.length())}$minutes ', style: context.textTheme.bodyLarge?.copyWith(height: 1, fontWeight: FontWeight.bold, color: valueColor)),
        if (int.tryParse(minutes)! > 0) TextSpan(text: '${'minute_abbr'.tr()}\n', style: context.textTheme.bodyLarge?.copyWith(height: 1, fontWeight: FontWeight.bold, color: keyColor)),
        TextSpan(text: '${'\t'.repeat(days.length())}$seconds ', style: context.textTheme.bodyLarge?.copyWith(height: 1, fontWeight: FontWeight.bold, color: valueColor)),
        TextSpan(text: '${'second_abbr'.tr()}', style: context.textTheme.bodyLarge?.copyWith(height: 1, fontWeight: FontWeight.bold, color: keyColor)),
      ],
    );

    return RichText(text: text);
  }
}
