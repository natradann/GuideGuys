import 'dart:convert';
import 'dart:typed_data';

import 'package:guideguys/modules/payment/payment_model.dart';
import 'package:guideguys/services/payment_service/payment_service.dart';
import 'package:guideguys/services/payment_service/payment_service_interface.dart';

class PaymentViewModel {
  PaymentServiceInterface service = PaymentService();

  Future<bool> savePaymentInfo({
    required String historyId,
    required Uint8List slipImage,
  }) async {
    try {
      PaymentModel newPayment = PaymentModel(
        historyId: historyId,
        base64Slip: base64Encode(slipImage),
      );

      return await service.savedPayment(newPayment);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
