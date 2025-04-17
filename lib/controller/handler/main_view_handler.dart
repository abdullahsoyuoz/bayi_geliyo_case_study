import 'package:bayi_geliyo_mobile_application/controller/constant/asset.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainViewHandler with ChangeNotifier {
  MainViewHandler();
  int index = 0;

  List<BottomMenuItem> items = [
    BottomMenuItem(value: "home".tr(), index: 0, icon: AppIcon.home.path),
    BottomMenuItem(value: "wallet".tr(), index: 1, icon: AppIcon.wallet.path),
    BottomMenuItem(value: "menu".tr(), index: 2, icon: AppIcon.menu.path),
  ];

  void setIndex(int value) {
    index = value;
    notifyListeners();
  }
}

class BottomMenuItem {
  String value;
  int index;
  String icon;
  BottomMenuItem({
    required this.value,
    required this.index,
    required this.icon,
  });
}
