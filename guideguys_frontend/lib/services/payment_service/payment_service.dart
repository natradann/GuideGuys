import 'package:guideguys/modules/payment/payment_model.dart';
import 'package:guideguys/services/ip_for_connect.dart';
import 'package:guideguys/services/payment_service/payment_service_interface.dart';
import 'package:http/http.dart' as http;

class PaymentService implements PaymentServiceInterface {
  @override
  Future<bool> savedPayment(PaymentModel proof) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$ngrokLink/payments/create/proof'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: paymentModelToJson(proof)
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        throw Exception('no data');
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error");
      } else {
        throw Exception("Unknown Error");
      }
    } catch (_) {
      rethrow;
    }
  }
}
