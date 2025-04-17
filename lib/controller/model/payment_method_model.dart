import 'package:bayi_geliyo_mobile_application/controller/constant/asset.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentMethodModel {
  late String iconPath;
  late String title;
  late String description;
  late bool active;
  PaymentMethodModel({required this.iconPath, required this.title, required this.description, required this.active});
}

List<PaymentMethodModel> paymentMethodModelList() => [
      PaymentMethodModel(iconPath: AppIcon.credit_card.path, title: "get_paid_param".tr(args: ["credit_card".tr()]), description: "get_paid_with_credit_card_description".tr(), active: false),
      PaymentMethodModel(iconPath: AppIcon.link.path, title: "get_paid_param".tr(args: ["link".tr()]), description: "get_paid_with_link_description".tr(), active: true),
    ];
