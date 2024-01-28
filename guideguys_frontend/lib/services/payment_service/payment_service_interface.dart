import 'package:guideguys/modules/payment/payment_model.dart';

abstract class PaymentServiceInterface {
  Future<bool> savedPayment(PaymentModel proof);
}
