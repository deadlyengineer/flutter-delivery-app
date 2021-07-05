import 'package:return_me/labelconfig.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

Future<void> initSquarePayment() async {
  await InAppPayments.setSquareApplicationId(SQUARE_SANDBOX_APP_ID);
}
