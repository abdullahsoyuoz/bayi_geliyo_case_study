class PaidHandler {
  static PaidHandler? _instance;
  PaidHandler._();
  static PaidHandler get instance => _instance ??= PaidHandler._();

  final PaidModel baseModel = PaidModel();
}

class PaidModel {
  PaidType? paidType;
  String? nameSurname;
  String? email;
  String? phone;
  String? linkTitle;
  String? linkDescription;
  String? language;
  String? currency;
  AmountType? amountType;
  String? amount;
  LimitType? limitType;
  List<bool>? customerDemands;
  PaymentType? paymentType;
  LimitTimeType? limitTimeType;
  DateTime? limitDateTime;
  List<bool>? posSelection;
  PaidModel({
    this.paidType,
    this.nameSurname,
    this.email,
    this.phone,
    this.linkTitle,
    this.linkDescription,
    this.language,
    this.currency,
    this.amountType,
    this.amount,
    this.limitType,
    this.customerDemands,
    this.paymentType,
    this.limitTimeType,
    this.posSelection,
    this.limitDateTime,
  });

  @override
  String toString() {
    return "${paidType?.name}\n$nameSurname -  $email - $phone\n$linkTitle - $linkDescription - $language\n$currency - ${amountType?.name} - $amount\n${limitType?.name} - $customerDemands\n${paymentType?.name} - $limitDateTime - ${limitTimeType?.name}\n$posSelection";
  }
}

enum PaidType { creditCard, link }

extension PaidTypeExtension on int {
  PaidType getPaidType() => PaidType.values[this];
}

enum PaymentType { singlePayment, installment }

enum AmountType { fixedAmount, variableAmount }

enum LimitType { limitedLink, unlimitedLink }

enum LimitTimeType { timeLimitedLink, timelessLink }

extension LimitTimeTypeExtension on LimitTimeType {
  bool hasLimit() => this == LimitTimeType.timeLimitedLink;
}
