import 'package:bayi_geliyo_mobile_application/view/widget/dialog/constructor.dart';

extension FutureExtensions<T> on Future<T> {
  Future<T> withSpinner({bool showDescription = true, bool isPayment = false}) async {
    final result = await AppDialog.spinner<T>(asyncFunction: () => this, showDescription: showDescription, isPayment: isPayment);
    return result;
  }
}
